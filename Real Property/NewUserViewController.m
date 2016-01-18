//
//  NewUserViewController.m
//  Real Property
//
//  Created by Anibal Rodriguez on 16/01/14.
//  Copyright (c) 2014 Moviloft. All rights reserved.
//

#import "NewUserViewController.h"
#import "HomeViewController.h"

@interface NewUserViewController ()

@end

@implementation NewUserViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    //self.navigationController.navigationBarHidden = NO;
    self.navigationController.topViewController.title = @"Nuevo Registro";
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [emailTextFieldRegistro resignFirstResponder];
    [passtextFieldRegistro resignFirstResponder];
    [passConfim resignFirstResponder];
    return YES;
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (BOOL) validateEmail: (NSString *) candidate {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    return [emailTest evaluateWithObject:candidate];
    NSLog(@"%@",emailTest);
}
- (IBAction)setRegistro:(id)sender {
    
    NSString *emailRegEx = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegEx];
    
    if ([emailTest evaluateWithObject:emailTextFieldRegistro.text] == NO) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"¡Atención!" message:@"Por favor agrege un email valido" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        return;
    }else{
    if ([passConfim.text isEqualToString:passtextFieldRegistro.text]) {
        NSMutableString * urlString = [[NSMutableString alloc] initWithString:@"http://www.realproperty.cl/mobilData.php?functName=setRegistro&"];
        [urlString appendString:@"email="];
        [urlString appendString:emailTextFieldRegistro.text];
        [urlString appendString:@"&password="];
        [urlString appendString:passtextFieldRegistro.text];
        NSLog(@"%@",urlString);
        NSURL * url = [[NSURL alloc] initWithString:urlString];
        NSString * datos = [NSString stringWithFormat:@"&email=%@",@"example@example.com"];
        NSMutableURLRequest * req = [NSMutableURLRequest requestWithURL:url];
        NSString * longitud = [NSString stringWithFormat:@"%d", [datos length]];
        [req addValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        [req addValue:longitud forHTTPHeaderField:@"Content-length"];
        [req setHTTPMethod:@"POST"];
        [req setHTTPBody:[datos dataUsingEncoding:NSUTF8StringEncoding]];
        con = [[NSURLConnection alloc] initWithRequest:req delegate:self];
        if (con)
            datosEnviarR=[NSMutableData data];
    }else{
        UIAlertView *alertaConfirm = [[UIAlertView alloc] initWithTitle:@"¡Alerta!" message:@"Las contraseñas no son iguales." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alertaConfirm show];
    }
    }

    
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    NSLog(@"error de la conexion %@",error);
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    [datosEnviarR appendData:data];
    
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    [datosEnviarR setLength:0];
}


-(void) connectionDidFinishLoading:(NSURLConnection *)connection{
    
    NSString * jsonSetRegistro = [NSJSONSerialization JSONObjectWithData:datosEnviarR options:kNilOptions error:NULL];
    NSString * mensajeRegistro = [jsonSetRegistro valueForKey:@"message"];
    
    UIAlertView * alertaRegistroUser = [[UIAlertView alloc] initWithTitle:@"Registro de nuevo usuario"
                                                            message:mensajeRegistro delegate:self cancelButtonTitle:@"OK" otherButtonTitles:NULL, nil];
    [alertaRegistroUser show];
    
    NSLog(@"mensaje es %@",mensajeRegistro);
    
    if ([mensajeRegistro isEqualToString:@"User registered successfully"]) {
        
        NSMutableString *urlC = [[NSMutableString alloc] initWithString:@"https://www.realproperty.cl/mobilData.php?functName=getRegistro&"];
        [urlC appendString:@"email="];
        [urlC appendString:emailTextFieldRegistro.text];
        [urlC appendString:@"&password="];
        [urlC appendString:passtextFieldRegistro.text];
        
        NSURL *userURL = [NSURL URLWithString:urlC];
        NSData *dataURlUser = [NSData dataWithContentsOfURL:userURL];
        NSArray *jsonUser = [NSJSONSerialization JSONObjectWithData:dataURlUser options:kNilOptions error:nil];
        NSString *idUsuario = [jsonUser valueForKey:@"registroID"];
        
        NSString *guardarId = idUsuario;
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:guardarId forKey:@"guardarid"];
        [defaults synchronize];
        
        HomeViewController *vcf = [self.storyboard instantiateViewControllerWithIdentifier:@"NavCotrHome"];
        //vcf.mensajeB = @"Bienvenido a Real Property";
        [self presentViewController:vcf animated:YES completion:nil];
    }
    
 
    
}
@end
