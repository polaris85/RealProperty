//
//  DetailHomeViewController.h
//  Real Property
//
//  Created by Anibal Rodriguez on 05/03/14.
//  Copyright (c) 2014 Moviloft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailHomeViewController : UIViewController 

@property (strong, nonatomic) NSString * texto;
@property (strong, nonatomic) NSString * URL;
@property (strong, nonatomic) NSString * buttonInmueble;
@property (strong, nonatomic) NSString * idinmuebleDH;
@property (strong, nonatomic) NSString * linkDV;
@property (strong, nonatomic) IBOutlet UIImageView *imageBack;
@property (strong, nonatomic) NSString * textL;
@property (strong, nonatomic) IBOutlet UILabel *textLabel;
@property (strong, nonatomic) IBOutlet UITextView *textoDescription;
@property (strong, nonatomic) IBOutlet UIButton *buttonDetail;
@property (strong, nonatomic) IBOutlet UIButton *buttonLinkIB;



- (IBAction)iraFicha:(id)sender;
- (IBAction)iraEnlace:(id)sender;


@end
