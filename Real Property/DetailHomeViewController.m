//
//  DetailHomeViewController.m
//  Real Property
//
//  Created by Anibal Rodriguez on 05/03/14.
//  Copyright (c) 2014 Moviloft. All rights reserved.
//

#import "DetailHomeViewController.h"
#import "DetailViewController.h"
#import "LinkViewController.h"
#import "UIViewController+MJPopupViewController.h"
#import "HomeViewController.h"

@interface DetailHomeViewController () <MJSecondPopupDelegate>

@property (strong, nonatomic) NSString * idinm ;
@property (strong, nonatomic) NSString * linkm ;
@property (strong, nonatomic) UIActivityIndicatorView *spinner;

@end

@implementation DetailHomeViewController


@synthesize texto, URL;

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
    if ([ [ UIScreen mainScreen ] bounds ].size.height == 568){
        NSLog(@"iPhone 5 pantalla");
        
    }else{
        _textoDescription.frame = CGRectMake(20, 157, 280, 250);
        _buttonLinkIB.frame = CGRectMake(20, 415, 72, 30);
        _buttonDetail.frame = CGRectMake(211, 415, 89, 30);
    }
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = NO;

    _buttonDetail.hidden = YES;
    _buttonLinkIB.hidden = YES;
    NSString * textoI  = texto;
    NSString * URLI    = URL;
    NSString * textpLi = self.textL;
    self.idinm   = self.idinmuebleDH;
    self.linkm = self.linkDV;
    
    NSLog(@"enlace: %@",self.linkm);
    
    _textLabel.text        = textoI;
    _textoDescription.text = textpLi;
    
    
    NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:URLI]];
    //NSLog(@"%@ %@",textoI, URLI);
    
    _imageBack.image = [UIImage imageWithData:imageData];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    NSLog(@"id %@",self.idinm);
    if (self.idinm != (NSString *)[NSNull null] && ![self.idinm isEqualToString:@"0"] && ![self.idinm isEqualToString:@""]) {
        _buttonDetail.hidden = NO;
    }else{
        _buttonDetail.hidden = YES;
    }
    if ([self.linkm isEqualToString:@""]) {
        _buttonLinkIB.hidden = YES;
    }else{
        _buttonLinkIB.hidden = NO;
    }

    _spinner.hidden = YES;
}




//popup

-(void)cancelButtonClicked:(LinkViewController *)aLinkViewController
{

    [self dismissPopupViewControllerWithanimationType:MJPopupViewAnimationFade];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)iraFicha:(id)sender {
    
    _spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [_spinner setCenter:CGPointMake(320/2.0, 568/2.0)];
    [self.view addSubview:_spinner];
    [_spinner startAnimating];
    _spinner.hidden = NO;
    [self performSelector:@selector(threadStartAnimating:) withObject:nil afterDelay:0.1];
    /*
    DetailViewController *dvc = [self.storyboard instantiateViewControllerWithIdentifier:@"fichaMaster"];
    [self.navigationController pushViewController:dvc animated:YES];
    dvc.IDInmueble = self.idinm;
    */

    
}
-(void)threadStartAnimating:(id)data
{
    DetailViewController *dvc = [self.storyboard instantiateViewControllerWithIdentifier:@"fichaMaster"];
    [self.navigationController pushViewController:dvc animated:YES];
    dvc.IDInmueble = self.idinm;
}

- (IBAction)iraEnlace:(id)sender {
    LinkViewController *linkDetail =[[LinkViewController alloc] initWithNibName:@"LinkViewController" bundle:nil];
    linkDetail.delegate = self;
    linkDetail.link = self.linkm;
    [self presentPopupViewController:linkDetail animationType:MJPopupViewAnimationFade];
}
@end
