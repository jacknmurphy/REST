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

@synthesize mapView=_mapView; //Synthesizing the MKMapview property from .h file.

NSArray *array; //Array for holding tweet data sent from ViewController class.

- (void)place:(NSArray *)tweetData //Place method called from ViewController class. Accepts NSArray as input parameter.
{
    array = tweetData; //Store tweet data that was sent over in array declared above.
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil //Stock class initialisation methods for view.
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad //Is called after the MapViewController view is loaded.
{
    [super viewDidLoad];
    self.mapView.delegate = self; //Assigning mapView delgate to self.
}

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation  //Method that is called when user location is updated.
{
    NSMutableArray *annotationArray = [[NSMutableArray alloc] init]; //Array for holding annotations.
    
    NSUInteger i; //Variable for iterating through array.
    
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(userLocation.coordinate, 1200, 1200); //Created region to focus on around user location in mapview
    [self.mapView setRegion:[self.mapView regionThatFits:region] animated:YES]; //Applies the above region to the map view.
    
    for (i = 0; i < array.count; i++) { //Loop for iterating through array of JSON objects
        
        NSDictionary *dict = [array objectAtIndex:i]; //Places current JSON object in NSdictionary so its attributes can be accessed.
        
        
        NSString *lat = [dict objectForKey:@"lat"]; //Extracts latitude from object and stores as string.
        NSString *lon = [dict objectForKey:@"lon"]; //The same function but for longitude.
        
        double lat2 = [lat doubleValue]; //Converts latitude to double for use with CLLocation
        double lon2 = [lon doubleValue]; //The same function but for longitude.
        
        NSLog(@"String %@, %@", lat, lon);
        NSLog(@"Double %.8f, %.8f", lat2, lon2);
         
        CLLocation *loc = [[CLLocation alloc] initWithLatitude:lat2 longitude:lon2]; //Creates CLLocation object using latitude an logitude doubles.
        
        MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init]; //Creates MKPoint annotation object.
        annotation.coordinate = loc.coordinate; //Assigns the annoation a coordinate on the map.
        annotation.title = [dict objectForKey:@"userName"]; //Assigns the twitter user name as title.
        annotation.subtitle = [dict objectForKey:@"text"]; //Assigns the tweet text as subtitles.
        
        [annotationArray addObject:annotation]; //Adds annotation objec to array of annotation objects.
    }
    NSLog(@"_mapView = %@", _mapView);
    NSLog(@"annotation array: %@", annotationArray);
    [self.mapView addAnnotations:annotationArray]; //Adds array of annotations to map.

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
