//
//  LinkViewController.h
//  Real Property
//
//  Created by Anibal Rodriguez on 18/03/14.
//  Copyright (c) 2014 Moviloft. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MJSecondPopupDelegate;


@interface LinkViewController : UIViewController
@property (assign, nonatomic) id <MJSecondPopupDelegate>delegate;
@property (strong, nonatomic) NSString * link;
@property (strong, nonatomic) IBOutlet UIWebView *LinkWB;
@end

@protocol MJSecondPopupDelegate<NSObject>
@optional
- (void)cancelButtonClicked:(LinkViewController*)linkViewController;
@end