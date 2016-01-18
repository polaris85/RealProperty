//
//  MapKViewController.h
//  Real Property
//
//  Created by Anibal Rodriguez on 24/02/14.
//  Copyright (c) 2014 Moviloft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
@interface MapKViewController : UIViewController <MKMapViewDelegate>
{
    float lat;
    float lon;
    
}
@property (strong, nonatomic) IBOutlet MKMapView *map;
@property (strong, nonatomic) NSArray *inmuebles;
@property (strong, nonatomic) NSArray *jsonGeo;
@property BOOL userLocationUpdated;

@property (strong, nonatomic) IBOutlet UIView *helpView4;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *spinner;
@end
