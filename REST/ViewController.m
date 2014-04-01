//
//  ViewController.m
//  REST
//
//  Created by Jack Murphy on 02/12/2013.
//  Copyright (c) 2013 Jack Murphy. All rights reserved.
//

#import "ViewController.h"
#import "MapViewController.h"
#import <CoreLocation/CoreLocation.h>


@implementation ViewController

@synthesize button=_button;
@synthesize label=_label;
@synthesize tweetId=_tweetId;
@synthesize tweetContent=_tweetContent;
@synthesize connection=_connection;
@synthesize mapView=_mapView;

NSString *tweet;
NSMutableArray *locationArray;

- (IBAction)fetchTweet
{
    
    NSString *sendCo = [[locationArray valueForKey:@"description"] componentsJoinedByString:@","];
    
    NSLog(@"sendCo: %@", sendCo);
    
    NSURL *url = [NSURL URLWithString:@"http://127.0.0.1:8080/Jersey/rest/hello"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:60.0];
    [request setHTTPMethod:@"POST"];
    
    [request setValue:@"text/html" forHTTPHeaderField: @"Content-Type"];
    
    [request setHTTPBody:[sendCo dataUsingEncoding:NSUTF8StringEncoding]];

    NSData *urlData;
    NSURLResponse *response;
    NSError *error;
    
    urlData = [NSURLConnection sendSynchronousRequest:request
                                    returningResponse:&response
                                                error:&error];
    
    tweet = [[NSString alloc] initWithData:urlData encoding:NSUTF8StringEncoding];
    
    NSArray *jsonData = [NSJSONSerialization JSONObjectWithData:[tweet dataUsingEncoding:NSUTF8StringEncoding]
                                                        options:0 error:NULL];
    
    //NSArray *data = [jsonData valueForKey:@"coordinates"];
    
    NSLog(@"%@", jsonData);
    
    _mapView = [[MapViewController alloc] init];
    [_mapView place:jsonData];
    
    //NSLog(@"%@", tweet);
}


- (void)connection:(NSURLConnection*)connection didReceiveResponse:(NSURLResponse *)response
{
    NSLog(@"Did Receive Response %@", response);
}
- (void)connection:(NSURLConnection*)connection didReceiveData:(NSData*)data
{
    //NSLog(@"Did Receive Data %@", data);

}
- (void)connection:(NSURLConnection*)connection didFailWithError:(NSError*)error
{
    NSLog(@"Did Fail");
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSLog(@"Did Finish");
}

- (IBAction)go:(id)sender
{
    [self fetchTweet];
    self.label.text = tweet;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    [locationManager startUpdatingLocation];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)locationManager:(CLLocationManager *)locationManager didFailWithError:(NSError *)error
{
    NSLog(@"Location manager failed");
}

- (void)locationManager:(CLLocationManager *)locationManager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    [locationManager stopUpdatingLocation];
    NSLog(@"newLocation %@", newLocation);
    CLLocation *location = newLocation;
    NSLog(@"location %@", location);
    double lat = location.coordinate.latitude;
    double lon = location.coordinate.longitude;
    
    NSString *lat2 = [NSString stringWithFormat:@"%.8f", lat];
    NSString *lon2 = [NSString stringWithFormat:@"%.8f", lon];
    
    NSLog(@"lat:%f, lat2:%@", lat, lat2);
    
    locationArray = [[NSMutableArray alloc] init];
    [locationArray addObject:lat2];
    [locationArray addObject:lon2];
    
    NSLog(@" array %@", locationArray);

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end