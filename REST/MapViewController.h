//
//  MapViewController.h
//  REST
//
//  Created by Jack Murphy on 28/03/2014.
//  Copyright (c) 2014 Jack Murphy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface MapViewController : UIViewController <MKMapViewDelegate>

@property (nonatomic, strong) IBOutlet MKMapView *mapView;

- (void)place:(NSArray *)tweetData;

@end
