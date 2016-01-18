//
//  GaleriaViewController.m
//  Real Property
//
//  Created by Anibal Rodriguez on 05/03/14.
//  Copyright (c) 2014 Moviloft. All rights reserved.
//

#import "GaleriaViewController.h"
#import "AsyncImageView.h"
#import "AppDelegate.h"
@interface GaleriaViewController ()

@end

@implementation GaleriaViewController


@synthesize imagenes, imagenesF;


- (void)viewDidLoad
{
    
    [super viewDidLoad];
	_carousel.type = iCarouselTypeLinear;
    self.view.transform = CGAffineTransformMakeRotation(M_PI/2);
    imagenesF = imagenes;
    NSLog(@"%@",imagenesF);
    self.navigationController.navigationBarHidden= YES;
}

-(void)viewDidAppear:(BOOL)animated{

    [super viewDidAppear:animated];
    [self.carousel setCurrentItemIndex:0];
    [self.carousel reloadData];
    
    NSString *cantidad = [NSString stringWithFormat:@"%i",[imagenesF count]];
    
    _cantidadFotos.text = cantidad;
    NSLog(@"%i",[imagenesF count]);

}
- (BOOL)prefersStatusBarHidden
{
    return YES;
}
- (NSUInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    return [imagenesF count];
}
- (void)carouselDidEndScrollingAnimation:(iCarousel *)aCarousel
{
    [_indexFotos setText:[NSString stringWithFormat:@"%i", aCarousel.currentItemIndex+1]];
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSUInteger)index reusingView:(AsyncImageView *)view
{
    

    if (view == nil) {
        view = [[AsyncImageView alloc]initWithFrame:CGRectMake(0, 0, 568, 320)];
    }
    // dont forget stop previous loading -cancelLoadingURL:target:
    NSString    * strinTemp     = [imagenesF objectAtIndex:index];
    NSURL       * urlImageTemp  = [[NSURL alloc] initWithString:strinTemp];
    view.image =[UIImage imageNamed:@"placeholderficha.png"];
    view.imageURL = urlImageTemp;
    
    
	return view;
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)atrasAccion:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
    self.navigationController.navigationBarHidden = NO;
}
-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    NSLog(@"resive response %@", response);
    spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [spinner setCenter:CGPointMake(320/2.0, 568/2.0)];
    spinner.color = [UIColor greenColor];
    spinner.hidden = NO;
    [spinner startAnimating];
    [self.view addSubview:spinner];
}
-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
    NSLog(@"carga de conexion finalizada");
    [spinner stopAnimating];
    spinner.hidden = YES;
}
@end
