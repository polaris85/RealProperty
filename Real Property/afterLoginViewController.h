//
//  afterLoginViewController.h
//  Real Property
//
//  Created by Anibal Rodriguez on 13/02/14.
//  Copyright (c) 2014 Moviloft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface afterLoginViewController : UIViewController <UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UIButton *logout;
@property (strong, nonatomic) IBOutlet UILabel *idRegistro;

- (IBAction)logoutAction:(id)sender;

@property (strong, nonatomic) IBOutlet UIImageView *LogoPerfil;
@property (strong, nonatomic) IBOutlet UILabel *NameLastename;

@end
