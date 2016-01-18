//
//  FavoritosViewController.h
//  Real Property
//
//  Created by Anibal Rodriguez on 07/03/14.
//  Copyright (c) 2014 Moviloft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FavoritosViewController : UITableViewController <NSURLConnectionDataDelegate, NSURLConnectionDelegate>
{
    NSInteger success;
}

@property (strong, nonatomic) UIActivityIndicatorView * spinner;
@property (strong, nonatomic) NSMutableArray * temp;
@property (strong, nonatomic) NSMutableArray * temp2;
@property (strong, nonatomic) NSMutableString * dataDes;

@end
