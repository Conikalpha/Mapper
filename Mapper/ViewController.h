//
//  ViewController.h
//  Mapper
//
//  Created by Conikalpha on 02/05/16.
//  Copyright © 2016 flypocket. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>


@interface ViewController : UIViewController <MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end

