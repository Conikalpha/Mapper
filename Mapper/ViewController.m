//
//  ViewController.m
//  Mapper
//
//  Created by Conikalpha on 02/05/16.
//  Copyright © 2016 flypocket. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
/*
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(self.focus, 800, 800);
    [self.mapView setRegion:[self.mapView regionThatFits:region]
                   animated:YES];
    
    for (int i = 0; i < self.locations.count; i++) {
        
        Store *store = self.locations[i];
        
        
        MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
        
        point.coordinate = CLLocationCoordinate2DMake([store.lat doubleValue], [store.lng doubleValue]);
        point.title = store.name;
        point.subtitle = store.address;
        
        [self.mapView addAnnotation:point];
    }

*/

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
