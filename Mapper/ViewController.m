//
//  ViewController.m
//  Mapper
//
//  Created by Conikalpha on 02/05/16.
//  Copyright © 2016 flypocket. All rights reserved.
//

#import "ViewController.h"

#define IS_OS_8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)


@interface ViewController ()

@property (strong, nonatomic)CLLocation *currentLocation;

@end

@implementation ViewController

@synthesize locationManager;


- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.locationManager == nil)
    {
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.desiredAccuracy =  kCLLocationAccuracyNearestTenMeters;
        self.locationManager.delegate = self;
    }
    
    if(IS_OS_8_OR_LATER) {
        [self.locationManager requestAlwaysAuthorization];
        
    }
    
    [self.locationManager startUpdatingLocation];
    
    self.locations = [[[[NotificarePushLib shared] locationManager] monitoredRegions]allObjects];
  
    self.mapView.delegate = self;

}


- (void) viewDidAppear:(BOOL)animated{
    for (int i = 0; i < self.locations.count; i++) {
        
        CLCircularRegion *region = self.locations[i];
        
        [self.mapView addOverlay:[MKCircle circleWithCenterCoordinate:region.center radius:region.radius]];
        
    }

}

- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay {
    MKCircleRenderer *circleRenderer = [[MKCircleRenderer alloc] initWithCircle:overlay];
    circleRenderer.fillColor = [UIColor redColor];
    circleRenderer.alpha = 0.3f;
    return circleRenderer;
}


-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    // Assigning the last object as the current location of the device
    
    self.currentLocation = [locations lastObject];
    
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(self.currentLocation.coordinate, 800, 800);
    [self.mapView setRegion:[self.mapView regionThatFits:region]
                   animated:YES];

    
    
}
- (void) locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    NSLog(@"%@", @"Core location has a position.");
}

- (void) locationManager:(CLLocationManager *)manager
        didFailWithError:(NSError *)error
{
    NSLog(@"%@", @"Core location can't get a fix.");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)mapView:(MKMapView *)mapView
didSelectAnnotationView:(MKAnnotationView *)view
{
    
}


@end
