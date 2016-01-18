//
//  CustomBusquedaCells.m
//  Real Property
//
//  Created by Anibal Rodriguez on 03/02/14.
//  Copyright (c) 2014 Moviloft. All rights reserved.
//

#import "CustomBusquedaCells.h"
#import <QuartzCore/QuartzCore.h>
@interface CustomBusquedaCells ()

@end

@implementation CustomBusquedaCells

-(void)awakeFromNib{
    _vistaDHE.layer.cornerRadius = 5;
    _vistaDHE.layer.masksToBounds = YES;

}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code

    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}


@end
