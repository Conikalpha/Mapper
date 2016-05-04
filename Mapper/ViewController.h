//
//  ViewController.h
//  Mapper
//
//  Created by Conikalpha on 02/05/16.
//  Copyright © 2016 flypocket. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "NotificarePushLib.h"
#import <CoreLocation/CoreLocation.h>

@interface ViewController : UIViewController <MKMapViewDelegate, CLLocationManagerDelegate>{
    CLLocationManager *locationManager;
}

@property (nonatomic, retain) CLLocationManager *locationManager;

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (nonatomic, strong) NSMutableArray * circles;
@property (nonatomic, strong) NSMutableArray * markers;
@property (strong, nonatomic) NSArray *locations;



@end

