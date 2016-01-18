//
//  HelpViewController3.m
//  Real Property
//
//  Created by Hexi Zhang on 5/3/14.
//  Copyright (c) 2014 Moviloft. All rights reserved.
//

#import "HelpViewController3.h"

@interface HelpViewController3 ()

@end

@implementation HelpViewController3

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillAppear:animated];
    NSLog(@"de vuelta");
}
- (IBAction)goNextScreen:(UIButton *)sender
{
    [self performSegueWithIdentifier:@"goNextHelpScreen4" sender:nil];
    
}

@end
