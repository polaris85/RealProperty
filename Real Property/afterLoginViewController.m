//
//  afterLoginViewController.m
//  Real Property
//
//  Created by Anibal Rodriguez on 13/02/14.
//  Copyright (c) 2014 Moviloft. All rights reserved.
//

#import "afterLoginViewController.h"
#import "HomeViewController.h"


@interface afterLoginViewController ()

@end

@implementation afterLoginViewController

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
    self.navigationController.navigationBarHidden = NO;
    NSUserDefaults * defaults2 = [NSUserDefaults standardUserDefaults];
    NSString * load = [defaults2 objectForKey:@"guardarid"];
    NSLog(@"almacenado localmente: ID - %@",load);
    self.navigationController.navigationBarHidden = NO;
    self.navigationController.topViewController.title = @"Perfil de Usuario";
    //self.idRegistro.text = load;
    _LogoPerfil.image = [UIImage imageNamed:@"logoPerfil.png"];
    NSMutableString * urlPerfilInfo = [[NSMutableString alloc] initWithString:@"https://www.realproperty.cl/mobilData.php?functName=getRegistroData&registroID="];
    [urlPerfilInfo appendString:load];
    [urlPerfilInfo appendString:@"&keyRP=J77suiBaa12H"];
    
    NSURL *urlNS = [NSURL URLWithString:urlPerfilInfo];
    NSData *urlInfoData = [NSData dataWithContentsOfURL:urlNS];
    NSArray *json = [NSJSONSerialization JSONObjectWithData:urlInfoData options:kNilOptions error:nil];
    NSLog(@"%@",json);
    
    NSString *emailUser = [json valueForKey:@"email"];
    NSString *nameUser = [json valueForKey:@"nombre"];
    NSString *apellido = [json valueForKey:@"apellido"];
    

    
    if ([json valueForKey:@"apellido"] == [NSNull null] && [json valueForKey:@"nombre"] == [NSNull null] ) {
        NSLog(@"es nulo man");
        self.NameLastename.hidden = YES;
    }else{
        NSMutableString *fullName = [[NSMutableString alloc] init];
        [fullName appendString:nameUser];
        [fullName appendString:@" "];
        [fullName appendString:apellido];
        self.NameLastename.text = fullName;
        self.NameLastename.hidden = NO;
    }
    //self.NameLastename.text = fullName;
    
    self.idRegistro.text = emailUser;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
   
}


- (IBAction)logoutAction:(id)sender {
    NSString *guardarId = 0;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:guardarId forKey:@"guardarid"];
    [defaults synchronize];
    HomeViewController *dvc = [self.storyboard instantiateViewControllerWithIdentifier:@"NavCotrHome"];
    //[self.navigationController pushViewController:dvc animated:YES];
    [self presentViewController:dvc animated:YES completion:nil];
    
    
    
}
@end
