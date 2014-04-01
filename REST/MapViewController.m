//
//  MapViewController.m
//  REST
//
//  Created by Jack Murphy on 28/03/2014.
//  Copyright (c) 2014 Jack Murphy. All rights reserved.
//

#import "MapViewController.h"

@interface MapViewController ()

@end

@implementation MapViewController

@synthesize mapView=_mapView;


- (void)place:(NSArray *)tweetData
{
    _mapView = [[MKMapView alloc] init];
    
    NSArray *array = tweetData;
    
    NSDictionary *dict = [array objectAtIndex:0];
    
    
    NSString *lat = [dict objectForKey:@"lat"];
    NSString *lon = [dict objectForKey:@"lon"];
    
    double lat2 = [lat doubleValue];
    double lon2 = [lon doubleValue];
    
    NSLog(@"String %@, %@", lat, lon);
    NSLog(@"Double %.8f, %.8f", lat2, lon2);
    
    CLLocationCoordinate2D position = CLLocationCoordinate2DMake(lat2, lon2);

    MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
    annotation.coordinate = position;
    annotation.title = @"working";
    annotation.subtitle = @"working";
    
    NSLog(@"_mapView = %@", _mapView);
    [_mapView addAnnotation:annotation];
    
    //NSLog(@"Working %@", array);
    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.mapView.delegate = self;
}

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
//    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(userLocation.coordinate, 800, 800);
//    [self.mapView setRegion:[self.mapView regionThatFits:region] animated:YES];
//    
//    MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
//    point.coordinate = userLocation.coordinate;
//    point.title = @"Where am I?";
//    point.subtitle = @"I'm here!!!";
//    
//    NSLog(@"%f", userLocation.coordinate.latitude);
//    
//    [self.mapView addAnnotation:point];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
