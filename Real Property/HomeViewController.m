//
//  HomeViewController.m
//  Real Property
//
//  Created by Anibal Rodriguez on 28/12/13.
//  Copyright (c) 2013 Moviloft. All rights reserved.
//

#import "HomeViewController.h"
#import "BusquedaViewController.h"
#import "ViewController.h"
#import "DetailHomeViewController.h"
#import "AsyncImageView.h"
#import "afterLoginViewController.h"
#import "FavoritosViewController.h"
#import "AppDelegate.h"


@interface HomeViewController ()

@end

@implementation HomeViewController

@synthesize propiedades, descripcion, wrap, label, carousel, jsonBanner, mensajeB;
@synthesize helpView1;
@synthesize helpView2;
@synthesize isHelpViewed;

-(void)awakeFromNib{

    NSString *urlGetBanner = [NSString stringWithFormat:@"http://www.realproperty.cl/mobilData.php?functName=getBanners"];
    NSURL *urlBanner = [NSURL URLWithString:urlGetBanner];
    NSData *dataBanner = [NSData dataWithContentsOfURL:urlBanner];
    NSError *error;
    self.jsonBanner = [NSJSONSerialization JSONObjectWithData:dataBanner options:kNilOptions error:&error];
    NSArray * imgBanner         = [jsonBanner valueForKey:@"image"];
    tempText    = [jsonBanner valueForKey:@"description"];
    textLarge   = [jsonBanner valueForKey:@"text"];
    temp        = [NSMutableArray array];
    idinmueble  = [jsonBanner valueForKey:@"inmuebleID"];
    link        = [jsonBanner valueForKey:@"link"];
    
    
    
    NSURLRequest * request = [[NSURLRequest alloc] initWithURL:urlBanner];
    NSURLConnection * conexion = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    NSLog(@"%@",conexion);
  
    
    for (int i = 0; i < [imgBanner count]; i++) {
        NSString *imageTemp = [imgBanner objectAtIndex:i];
        NSMutableString *urlImage = [[NSMutableString alloc] initWithString:@"http://www.realproperty.cl"];
        [urlImage appendString:imageTemp];
        [temp addObject:urlImage];
    }
    
    NSLog(@"%@",temp);

}


- (void)viewDidLoad
{
    [super viewDidLoad];
    AppDelegate *appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    
    if(!appDelegate.isFirstHelpViewed1){
        [helpView1 setHidden:NO];
        [helpView2 setHidden:YES];
        appDelegate.isFirstHelpViewed1 = YES;
    }else{
        [helpView1 setHidden:YES];
        [helpView2 setHidden:YES];
    }
    wrap = NO;
    [_spining setHidden:NO];
    carousel.type = iCarouselTypeLinear;

}


// metodos de conexion



-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
    NSLog(@"ya cargo, paro el spining");
    [_spining setHidden:YES];
    [_spining stopAnimating];
}
-(void)cargaSpining{
    [_spining startAnimating];
    [_spining setHidden:NO];
    //[self performSelector:@selector(cargaSpining)withObject:nil afterDelay:5.0];
}

// otros metodos


- (void)viewDidUnload
{
    [self setLabel:nil];
    [super viewDidUnload];
    NSLog(@"Salio la vista");
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}
- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillAppear:animated];
    [_favoritosItem setSelectedImageTintColor:nil];
    [_favoritosItem setSelectedItem:nil];
    NSLog(@"de vuelta");
}

-(void)viewDidAppear:(BOOL)animated
{
    
    [super viewDidAppear:animated];
    
    NSUserDefaults * defaults2 = [NSUserDefaults standardUserDefaults];
    NSString * load = [defaults2 objectForKey:@"guardarid"];
    success = [load integerValue];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];

    NSLog(@"me voy a ir");
}


- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
    [_spining stopAnimating];
    [_spining setHidden:YES];
    NSLog(@"me fui");
}

#pragma mark -
#pragma mark iCarousel methods

- (NSUInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    
    return temp.count;
}

- (NSUInteger)numberOfVisibleItemsInCarousel:(iCarousel *)carousel
{
    //limit the number of items views loaded concurrently (for performance reasons)
    return temp.count;
}
/*
- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSUInteger)index reusingView:(UIView *)view
{
    //create a numbered view
    NSString    * strinTemp     = [temp objectAtIndex:index];
    NSURL       * urlImageTemp  = [[NSURL alloc] initWithString:strinTemp];
    NSData      * dataTemp      = [NSData dataWithContentsOfURL:urlImageTemp];
    
	view = [[UIImageView alloc] initWithImage:[UIImage imageWithData:dataTemp]];
	return view;
}
 */
- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSUInteger)index reusingView:(AsyncImageView *)view
{
    
    
    if (view == nil) {
        view = [[AsyncImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 568)];
    }
    NSString    * strinTemp     = [temp objectAtIndex:index];
    NSURL       * urlImageTemp  = [[NSURL alloc] initWithString:strinTemp];
    view.image =[UIImage imageNamed:@"placeholderhome.png"];
    view.imageURL = urlImageTemp;
    
    
	return view;
}

- (NSUInteger)numberOfPlaceholdersInCarousel:(iCarousel *)carousel
{
	//note: placeholder views are only displayed on some carousels if wrapping is disabled
	return 0;
}
/*
- (CGFloat)carouselItemWidth:(iCarousel *)carousel
{
    //usually this should be slightly wider than the item views
    return 426;
}
*/
- (BOOL)carouselShouldWrap:(iCarousel *)carousel
{
    //wrap all carousels
    return wrap;
}

- (void)carouselDidEndScrollingAnimation:(iCarousel *)aCarousel
{
    [label setText:[NSString stringWithFormat:@"%@", [tempText objectAtIndex:aCarousel.currentItemIndex]]];
}



- (void)carousel:(iCarousel *)carousel didSelectItemAtIndex:(NSInteger)index
{
    
    NSLog(@"tap %d", index);
    [_spining startAnimating];
    [_spining setHidden:NO];
    [self performSelector:@selector(threadStartAnimatingDetailHome:) withObject:nil afterDelay:0.1];
    //DetailHomeViewController *dvc = [self.storyboard instantiateViewControllerWithIdentifier:@"detailhome"];
    titulo          = [tempText objectAtIndex:index];
    titulo1           = [temp objectAtIndex:index];
    titulo2          = [textLarge objectAtIndex:index];
    titulo3    = [idinmueble objectAtIndex:index];
    titulo4         = [link objectAtIndex:index];
    
}
-(void)threadStartAnimatingDetailHome:(id)data
{
    DetailHomeViewController *dvc = [self.storyboard instantiateViewControllerWithIdentifier:@"detailhome"];
    [self.navigationController pushViewController:dvc animated:YES];
    
    dvc.texto = titulo;
    dvc.URL             = titulo1;
    dvc.textL           = titulo2;
    dvc.idinmuebleDH    = titulo3;
    dvc.linkDV          = titulo4;
}

// fin de metodos del carusel

// empezar con Tab Bar


- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    NSLog(@"didSelectItem: %d", item.tag);
    

    if (item.tag == 1) {
        [_spining startAnimating];
        [_spining setHidden:NO];
        [NSThread detachNewThreadSelector:@selector(threadStartAnimating:) toTarget:self withObject:nil];
        
        
    }
    if (item.tag == 2) {
        [_spining startAnimating];
        [_spining setHidden:NO];
        ViewController *newView = [self.storyboard instantiateViewControllerWithIdentifier:@"map"];
        [self.navigationController pushViewController:newView animated:YES];
    }
    if (item.tag == 3) {
        [_spining startAnimating];
        [_spining setHidden:NO];
        [NSThread detachNewThreadSelector:@selector(threadStartAnimatingTercero:) toTarget:self withObject:nil];

    }
    if (item.tag == 4) {

        [_spining startAnimating];
        [_spining setHidden:NO];
        [NSThread detachNewThreadSelector:@selector(threadStartAnimatingSegundo:) toTarget:self withObject:nil];
        
    }
}

-(void)threadStartAnimating:(id)data
{
    BusquedaViewController *newView = [self.storyboard instantiateViewControllerWithIdentifier:@"BusquedaIdentity"];
    [self.navigationController pushViewController:newView animated:YES];
}
-(void)threadStartAnimatingSegundo:(id)data
{
    if (success != 0) {
        FavoritosViewController *dvc = [self.storyboard instantiateViewControllerWithIdentifier:@"fav"];
        [self.navigationController pushViewController:dvc animated:YES];
    }else{
        ViewController *newView = [self.storyboard instantiateViewControllerWithIdentifier:@"signup"];
        [self.navigationController pushViewController:newView animated:YES];
        self.navigationController.navigationBarHidden = NO;
    }
}
-(void)threadStartAnimatingTercero:(id)data
{
    if (success != 0) {
        afterLoginViewController *dvc = [self.storyboard instantiateViewControllerWithIdentifier:@"logeado"];
        [self.navigationController pushViewController:dvc animated:YES];
    }else{
        ViewController *newView = [self.storyboard instantiateViewControllerWithIdentifier:@"signup"];
        [self.navigationController pushViewController:newView animated:YES];
    }
}
//fin tabs y metodos
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)goNextHelpScreen:(UIButton *)sender
{
    //[self performSegueWithIdentifier:@"goNextHelpScreen1" sender:nil];
    [helpView2 setHidden:NO];
    [helpView1 setHidden:YES];
}
- (IBAction)closeHelpScreen:(UIButton *)sender
{
    //[self performSegueWithIdentifier:@"goNextHelpScreen1" sender:nil];
    [helpView2 setHidden:YES];
    [helpView1 setHidden:YES];
}
@end
