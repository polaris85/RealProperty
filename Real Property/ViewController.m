//
//  ViewController.m
//  Real Property
//
//  Created by Anibal Rodriguez on 17/12/13.
//  Copyright (c) 2013 Moviloft. All rights reserved.
//

#import "ViewController.h"
#import "afterLoginViewController.h"
#import "HomeViewController.h"
#import "DetailViewController.h"

@interface ViewController ()
@property (strong, nonatomic) NSString *idDesdelaficha;
@end

@implementation ViewController

@synthesize idUsuario;

bool isShown = false;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    if (self.idInmuebleDesdeDettale) {
        _idDesdelaficha = self.idInmuebleDesdeDettale;
        NSLog(@"id desde la ficha %@",_idDesdelaficha);
    }
    
    self.navigationController.navigationBarHidden = NO;
    self.navigationController.topViewController.title = @"Acceso Real Property";
  
    _imagenLogo.image = [UIImage imageNamed:@"logoPerfil.png"];
   
    
    NSUserDefaults * defaults2 = [NSUserDefaults standardUserDefaults];
    NSString * load = [defaults2 objectForKey:@"guardarid"];
    success = [load integerValue];
    if (success != 0) {
        _txtEmail.hidden = YES;
        _txtPass.hidden = YES;
        
    }
}

//olvido contraseña

- (IBAction)enviar:(id)sender {
    NSString *contrasena = _olvideContrasen.text;
    //olvido contraseña
    
    @try {
        
        if([[self.olvideContrasen text] isEqualToString:@""]) {
            
            [self alertStatus:@"Por favor ingrese su email." :@"¡Alerta!" :0];
            
        } else {
            NSString *post =[[NSString alloc] initWithFormat:@"&email=%@",[self.olvideContrasen text]];
            NSLog(@"PostData: %@",post);
            NSMutableString *urlC = [[NSMutableString alloc] initWithString:@"https://www.realproperty.cl/mobilData.php?functName=recoveryPassword&email="];
            [urlC appendString:contrasena];

            
            NSURL *url=[NSURL URLWithString:urlC];
            
            NSData *postData = [post dataUsingEncoding:NSUTF8StringEncoding];
            
            NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
            
            
            
            NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
            [request setURL:url];
            [request setHTTPMethod:@"POST"];
            [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
            //[request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
            [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
            [request setHTTPBody:postData];
            
            //[NSURLRequest setAllowsAnyHTTPSCertificate:YES forHost:[url host]];
            
            NSError *error = [[NSError alloc] init];
            NSHTTPURLResponse *response = nil;
            NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
            
            NSLog(@"Response code: %ld", (long)[response statusCode]);
            
            if ([response statusCode] >= 200 && [response statusCode] < 300)
            {
                NSString *responseData = [[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];
                NSLog(@"Response ==> %@", responseData);
                
                NSError *error = nil;
                NSDictionary *jsonData = [NSJSONSerialization
                                          JSONObjectWithData:urlData
                                          options:NSJSONReadingMutableContainers
                                          error:&error];
                
                success = [jsonData[@"registroID"] integerValue];
                idUsuario = jsonData[@"registroID"];
                mensajeRegistro = jsonData[@"message"];
                NSLog(@"Success: %ld",(long)success);
                
                if(success > 0)
                {
                    NSLog(@"Recuperacion de password ok!");
                } else {
                    
                    NSString *error_msg = (NSString *) jsonData[@"message"];
                    [self alertStatus:error_msg :@"Recuperacion de clave fallido!" :0];
                }
                
            } else {
                //if (error) NSLog(@"Error: %@", error);
                [self alertStatus:@"Connection Failed" :@"Recuperacion de clave fallido!" :0];
            }
        }
    }
    @catch (NSException * e) {
        NSLog(@"Exception: %@", e);
        [self alertStatus:@"Recuperacion fallida" :@"Error!" :0];
    }
    if (success) {

        
        UIAlertView * alertaRegistroUser = [[UIAlertView alloc] initWithTitle:self.txtEmail.text
                                                                      message:@"Su clave ha sido enviada a su Email." delegate:self cancelButtonTitle:@"Aceptar" otherButtonTitles:NULL, nil];
        [alertaRegistroUser show];
        [UIView animateWithDuration:0.25 animations:^{
            _cautionView.frame =  CGRectMake(0 , 930, 320, 150);
        }];
        isShown = false;
        [_olvideContrasen resignFirstResponder];
        
        
        
    }
    
}

- (IBAction)cerrar:(id)sender {
    [UIView animateWithDuration:0.25 animations:^{
        _cautionView.frame =  CGRectMake(0 , 930, 320, 150);
    }];
    isShown = false;
}

- (IBAction)btnToggleClick:(id)sender {
    if (!isShown) {
        [UIView animateWithDuration:0.25 animations:^{
            _cautionView.frame =  CGRectMake(0, 142, 320, 150);
        }];
        isShown = true;
    } else {
        [UIView animateWithDuration:0.25 animations:^{
            _cautionView.frame =  CGRectMake(0 , 930, 320, 150);
        }];
        isShown = false;
    }
}

//end olvido contraseña

-(void)viewDidAppear:(BOOL)animated
{

    [super viewDidAppear:animated];
    NSUserDefaults * defaults2 = [NSUserDefaults standardUserDefaults];
    NSString * load = [defaults2 objectForKey:@"guardarid"];
    success = [load integerValue];
    if (success != 0) {
        [self performSegueWithIdentifier:@"logincorrecto" sender:self];
    }


}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)tapLogear:(id)sender {
    
    success = 0;
    @try {
        
        if([[self.txtEmail text] isEqualToString:@""] || [[self.txtPass text] isEqualToString:@""] ) {
            
            [self alertStatus:@"Por favor ingrese Email y/o Clave" :@"¡Logeo Incorrecto!" :0];
            
        } else {
            NSString *post =[[NSString alloc] initWithFormat:@"%@&password=%@",[self.txtEmail text],[self.txtPass text]];
            NSLog(@"PostData: %@",post);
            NSMutableString *urlC = [[NSMutableString alloc] initWithString:@"https://www.realproperty.cl/mobilData.php?functName=getRegistro&"];
            [urlC appendString:@"email="];
            [urlC appendString:self.txtEmail.text];
            [urlC appendString:@"&password="];
            [urlC appendString:self.txtPass.text];
            
            NSURL *url=[NSURL URLWithString:urlC];
            
            NSData *postData = [post dataUsingEncoding:NSUTF8StringEncoding];
            
            NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
            
            
            
            NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
            [request setURL:url];
            [request setHTTPMethod:@"POST"];
            [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
            //[request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
            [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
            [request setHTTPBody:postData];
            
            //[NSURLRequest setAllowsAnyHTTPSCertificate:YES forHost:[url host]];
            
            NSError *error = [[NSError alloc] init];
            NSHTTPURLResponse *response = nil;
            NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
            
            NSLog(@"Response code: %ld", (long)[response statusCode]);
            
            if ([response statusCode] >= 200 && [response statusCode] < 300)
            {
                NSString *responseData = [[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];
                NSLog(@"Response ==> %@", responseData);
                
                NSError *error = nil;
                NSDictionary *jsonData = [NSJSONSerialization
                                          JSONObjectWithData:urlData
                                          options:NSJSONReadingMutableContainers
                                          error:&error];
                
                success = [jsonData[@"registroID"] integerValue];
                idUsuario = jsonData[@"registroID"];
                mensajeRegistro = jsonData[@"message"];
                NSLog(@"Success: %ld",(long)success);
                
                if(success > 0)
                {
                    NSLog(@"Login SUCCESS");
                } else {
                    
                    NSString *error_msg = (NSString *) jsonData[@"message"];
                    [self alertStatus:error_msg :@"Login fallido!" :0];
                }
                
            } else {
                //if (error) NSLog(@"Error: %@", error);
                [self alertStatus:@"Connection Failed" :@"Login fallido!" :0];
            }
        }
    }
    @catch (NSException * e) {
        NSLog(@"Exception: %@", e);
        [self alertStatus:@"Sign in Failed." :@"Error!" :0];
    }
    if (success) {
        NSString *guardarId = idUsuario;
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:guardarId forKey:@"guardarid"];
        [defaults synchronize];
        
        if (_idDesdelaficha) {
            [self.navigationController popViewControllerAnimated:YES];
        }else{
        
        HomeViewController *vcf = [self.storyboard instantiateViewControllerWithIdentifier:@"NavCotrHome"];
        //vcf.mensajeB = @"Bienvenido a Real Property";
        [self presentViewController:vcf animated:YES completion:nil];
            UIAlertView * alertaRegistroUser = [[UIAlertView alloc] initWithTitle:self.txtEmail.text
                                                                          message:@"Inicio exitoso, bienvenido a RealProperty" delegate:self cancelButtonTitle:@"Aceptar" otherButtonTitles:NULL, nil];
            [alertaRegistroUser show];
        }
        
        
    }
}

- (IBAction)backgroungTap:(id)sender {
    [self.view endEditing:YES];
}

- (IBAction)pasarRegistrar:(id)sender {
    
    afterLoginViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"NewUserId"];
    [self.navigationController pushViewController:vc animated:YES];
    
}
- (void) alertStatus:(NSString *)msg :(NSString *)title :(int) tag
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title
                                                        message:msg
                                                       delegate:self
                                              cancelButtonTitle:@"Ok"
                                              otherButtonTitles:nil, nil];
    alertView.tag = tag;
    [alertView show];
    
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

@end
