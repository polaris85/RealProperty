//
//  GaleriaViewController.h
//  Real Property
//
//  Created by Anibal Rodriguez on 05/03/14.
//  Copyright (c) 2014 Moviloft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iCarousel.h"

@interface GaleriaViewController : UIViewController <iCarouselDataSource, iCarouselDelegate>
{
    UIActivityIndicatorView * spinner;
}

@property (strong, nonatomic) NSArray * imagenes;
@property (strong, nonatomic) IBOutlet iCarousel *carousel;
@property (strong, nonatomic) NSArray * imagenesF;
@property (strong, nonatomic) IBOutlet UIButton *atrasDetail;

@property (strong, nonatomic) IBOutlet UILabel *cantidadFotos;
@property (strong, nonatomic) IBOutlet UILabel *indexFotos;

- (IBAction)atrasAccion:(id)sender;
@end
