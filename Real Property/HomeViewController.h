//
//  HomeViewController.h
//  Real Property
//
//  Created by Anibal Rodriguez on 28/12/13.
//  Copyright (c) 2013 Moviloft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iCarousel.h"

@interface HomeViewController : UIViewController <iCarouselDataSource, iCarouselDelegate, UITabBarDelegate>

{
    NSMutableArray  * tempText;
    NSArray         * textLarge;
    NSData          * dataImageBanner;
    NSMutableArray  * temp;
    NSArray         * idinmueble;
    NSArray         * link;
 
    NSString *titulo;
    NSString *titulo1;
    NSString *titulo2;
    NSString *titulo3;
    NSString *titulo4;
    NSInteger success;

}

@property (strong, nonatomic) IBOutlet iCarousel *carousel;
@property (strong, nonatomic) IBOutlet UILabel *label;
@property (strong,nonatomic) NSMutableArray *propiedades;
@property (strong,nonatomic) NSMutableArray *descripcion;
@property (strong,nonatomic) NSMutableArray *jsonBanner;
@property (nonatomic) BOOL wrap;
@property (strong, nonatomic) IBOutlet UITabBar *favoritosItem;
@property (strong, nonatomic) IBOutlet UITabBarItem *favoritesIB;

@property (strong, nonatomic) NSString *mensajeB;

@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *spining;

@property (strong, nonatomic) IBOutlet UIView *helpView1;
@property (strong, nonatomic) IBOutlet UIView *helpView2;

@property (assign, nonatomic) BOOL *isHelpViewed;

- (IBAction)goNextHelpScreen:(UIButton*)sender;
- (IBAction)closeHelpScreen:(UIButton*)sender;
@end
