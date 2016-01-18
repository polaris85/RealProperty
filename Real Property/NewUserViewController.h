//
//  NewUserViewController.h
//  Real Property
//
//  Created by Anibal Rodriguez on 16/01/14.
//  Copyright (c) 2014 Moviloft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewUserViewController : UIViewController <UITextFieldDelegate>
{

    IBOutlet UITextField *emailTextFieldRegistro;
    IBOutlet UITextField *passtextFieldRegistro;
    IBOutlet UITextField *passConfim;
    NSURLConnection * con;
    NSMutableData * datosEnviarR;

}
- (IBAction)setRegistro:(id)sender;

@end
