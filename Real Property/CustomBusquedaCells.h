//
//  CustomBusquedaCells.h
//  Real Property
//
//  Created by Anibal Rodriguez on 03/02/14.
//  Copyright (c) 2014 Moviloft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomBusquedaCells : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel    *TitleLabel;
@property (weak, nonatomic) IBOutlet UILabel    *SubtitleLabel;

@property (strong,nonatomic) IBOutlet UILabel   *direccion;

@property (strong, nonatomic) IBOutlet UILabel  *habitaciones;
@property (strong, nonatomic) IBOutlet UILabel  *banos;
@property (strong, nonatomic) IBOutlet UILabel  *estacionamiento2;
@property (strong, nonatomic) IBOutlet UIImageView *thumbImageView;


@property (strong, nonatomic) IBOutlet UILabel *destacado2;
@property (strong, nonatomic) IBOutlet UILabel *tipodeoperacion2;



@property (strong, nonatomic) IBOutlet UIView *vistaDHE;
@property (strong, nonatomic) IBOutlet UILabel *servicios;

@property (strong, nonatomic) IBOutlet UILabel *dormitoriosE;
@property (strong, nonatomic) IBOutlet UILabel *estacionamientosE;
@property (strong, nonatomic) IBOutlet UILabel *banosE;

@property (strong, nonatomic) IBOutlet UILabel *unidadPrec;


@end
