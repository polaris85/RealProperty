//
//  ViewController.h
//  Real Property
//
//  Created by Anibal Rodriguez on 17/12/13.
//  Copyright (c) 2013 Moviloft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITextFieldDelegate>
{

    NSInteger success;
    NSString * mensajeRegistro;

}
@property (strong, nonatomic) IBOutlet UIButton *registrar;
@property (weak, nonatomic) NSString * idUsuario;
@property (strong, nonatomic) IBOutlet UITextField *txtEmail;
@property (strong, nonatomic) IBOutlet UITextField *txtPass;
- (IBAction)tapLogear:(id)sender;
- (IBAction)backgroungTap:(id)sender;
- (IBAction)pasarRegistrar:(id)sender;
@property (strong, nonatomic) IBOutlet UIImageView *imagenLogo;

//olvido contraseña

@property (strong, nonatomic) IBOutlet UIView *cautionView;
@property (strong, nonatomic) IBOutlet UITextField *olvideContrasen;
@property (strong, nonatomic) IBOutlet UIButton *btnToggle;

- (IBAction)enviar:(id)sender;
- (IBAction)cerrar:(id)sender;
- (IBAction)btnToggleClick:(id)sender;

@property (strong, nonatomic) IBOutlet NSString *idInmuebleDesdeDettale;
@end
