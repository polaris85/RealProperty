//
//  MapKViewController.m
//  Real Property
//
//  Created by Anibal Rodriguez on 24/02/14.
//  Copyright (c) 2014 Moviloft. All rights reserved.
//

#import "MapKViewController.h"
#import "MapaAnnotation.h"
#import "DetailViewController.h"
#import "AppDelegate.h"
@interface MapKViewController ()

@end

@implementation MapKViewController

@synthesize helpView4;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self centerOnUser];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    [_spinner startAnimating];
    self.navigationController.navigationBarHidden = NO;
    UIBarButtonItem *flipButton = [[UIBarButtonItem alloc]
                                   initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh
                                   target:self
                                   action:@selector(reloadCenter:)];
    flipButton.style = UIBarButtonItemStyleBordered;
    self.navigationItem.rightBarButtonItem = flipButton;
    
    self.map.delegate = self;
    self.map.scrollEnabled = YES;
    self.map.zoomEnabled = YES;
    self.navigationController.topViewController.title = @"Geolocalización";
    CLLocationCoordinate2D centerCoordinate = CLLocationCoordinate2DMake(lat, lon);
    double regionWidth = 5200;
    double regionHeight = 2550;
    MKCoordinateRegion startRegion = MKCoordinateRegionMakeWithDistance(centerCoordinate, regionWidth, regionHeight);
    
    [self.map setRegion:startRegion
               animated:YES];
    
    self.map.showsUserLocation = YES;
    
    
    [self centerOnUser];
    
    [self performSelector:@selector(centerOnUser) withObject:self afterDelay:2.0];
    
    AppDelegate *appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    
    if(!appDelegate.isFirstHelpViewed4){
        [helpView4 setHidden:NO];
        appDelegate.isFirstHelpViewed4 = YES;
    }else{
        [helpView4 setHidden:YES];
    }
	// Do any additional setup after loading the view.
}
-(void)reloadCenter:(UIBarButtonItem *)sender{
    
    [self centerOnUser];
    NSLog(@"recargado");
    
}

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view
{
    [self.map setCenterCoordinate:[[view annotation] coordinate] animated:YES];
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    if([annotation isKindOfClass:[MKUserLocation class]]) {
        return nil;
    }
    
    MKAnnotationView *view = [self.map dequeueReusableAnnotationViewWithIdentifier:@"annoView"];
    if(!view) {
        view = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"annoView"];
    }
    
    view.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    view.image = [UIImage imageNamed:@"mapicon.png"];
    view.canShowCallout = YES;
    
    return view;
}
- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
    NSLog(@"%@",view.annotation.title);
    DetailViewController *dvc = [self.storyboard instantiateViewControllerWithIdentifier:@"fichaMaster"];
    [self.navigationController pushViewController:dvc animated:YES];
    dvc.IDInmueble = view.annotation.subtitle;
    //InfoView *infoView = [[InfoView alloc]initWithNibName:@"InfoView" bundle:nil];
    //[self.navigationController pushViewController:infoView animated:YES];
    
}
- (void)centerOnUser
{
    [self.map setCenterCoordinate:self.map.userLocation.location.coordinate];
    if (lat < 0) {
        
        NSString *latitud   =  [[NSNumber numberWithFloat:lat] stringValue];
        NSString *longitud  =  [[NSNumber numberWithFloat:lon] stringValue];
        
        [self.map setCenterCoordinate:self.map.userLocation.location.coordinate];
        NSLog(@"latitud %f longitud %f", lat, lon);
        NSMutableString *urlGeo = [[NSMutableString alloc] initWithString:@"https://www.realproperty.cl/mobilData.php?functName="];
        [urlGeo appendString:@"getCercanos&coord="];
        [urlGeo appendString:latitud];
        [urlGeo appendString:@","];
        [urlGeo appendString:longitud];
        [urlGeo appendString:@"&maxKM=5&limit=1000"];
        NSLog(@"%@", urlGeo);
        NSURL *urlReGeo = [NSURL URLWithString:urlGeo];
        NSData *dataGeo = [NSData dataWithContentsOfURL:urlReGeo];
        NSError *error;
        self.inmuebles = [NSJSONSerialization JSONObjectWithData:dataGeo options:kNilOptions error:&error];
    
        NSURLRequest * request = [[NSURLRequest alloc] initWithURL:urlReGeo];
        NSURLConnection * conexion = [[NSURLConnection alloc] initWithRequest:request delegate:self];
        NSLog(@"%@",conexion);
    }
    NSLog(@"latitud %f longitud %f", lat, lon);
    
    
    
    for (NSDictionary *inmuebles in self.inmuebles) {
        CLLocationCoordinate2D annotationCoordinate = CLLocationCoordinate2DMake([inmuebles[@"latitud"] doubleValue],[inmuebles[@"longitud"] doubleValue]);
        NSLog(@" latitud: %@", inmuebles[@"latitud"]);
        NSLog(@"longitud: %@", inmuebles[@"longitud"]);
        MapaAnnotation *annotation = [[MapaAnnotation alloc] init];
        annotation.coordinate = annotationCoordinate;
        annotation.title = inmuebles[@"titulo"];
        annotation.subtitle = inmuebles[@"inmuebleID"];
        
       
        
        [self.map addAnnotation:(id)annotation];
    }

  
}
-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
    NSLog(@"ya cargo, paro el spining");
    [_spinner setHidden:YES];
    [_spinner stopAnimating];
}

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    lat = userLocation.location.coordinate.latitude;
    lon = userLocation.location.coordinate.longitude;

    [self.map setCenterCoordinate:self.map.userLocation.location.coordinate];
    //[self centerOnUser];
    
    NSLog(@"cambio su ubicacion actual");
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)closeHelpScreen:(UIButton*)sender
{
    [helpView4 setHidden:YES];
}
@end
