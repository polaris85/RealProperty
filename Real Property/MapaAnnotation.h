//
//  MapaAnnotation.h
//  Real Property
//
//  Created by Anibal Rodriguez on 24/02/14.
//  Copyright (c) 2014 Moviloft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface MapaAnnotation : NSObject

@property CLLocationCoordinate2D coordinate;

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *subtitle;
@property (strong, nonatomic) NSString *cost;

@end
