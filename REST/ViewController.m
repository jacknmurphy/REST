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

//Synthesizing object for the ViewController view
@synthesize button=_button;
@synthesize label=_label;
@synthesize tweetId=_tweetId;
@synthesize tweetContent=_tweetContent;
@synthesize connection=_connection;
@synthesize mapViewController=_mapViewController;

NSString *tweet; //String to hold received tweet data.
NSMutableArray *locationArray; //Array for holding the devices location.



- (IBAction)fetchTweet
{
    
    NSString *sendCo = [[locationArray valueForKey:@"description"] componentsJoinedByString:@","]; //Storing the lat an lon of devices location in a single string.
    
    NSLog(@"sendCo: %@", sendCo);
    
    NSURL *url = [NSURL URLWithString:@"http://127.0.0.1:8080/Jersey/rest/tweet"]; //URL of server application.
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:60.0];  //Creating request object
    [request setHTTPMethod:@"POST"]; //Specifying request as POST request.
    
    [request setValue:@"text/html" forHTTPHeaderField: @"Content-Type"]; //Assigning content type.
    
    [request setHTTPBody:[sendCo dataUsingEncoding:NSUTF8StringEncoding]]; //Attaching devices location to request.

    NSData *urlData; //Variable for holding returned data from server
    NSURLResponse *response; //Holds response message.
    NSError *error; //Holds error message, if one exists.
    
    urlData = [NSURLConnection sendSynchronousRequest:request
                                    returningResponse:&response
                                                error:&error]; //Sending the POST request
    
    tweet = [[NSString alloc] initWithData:urlData encoding:NSUTF8StringEncoding]; //Converting the returned data to a string.
    
    NSArray *jsonData = [NSJSONSerialization JSONObjectWithData:[tweet dataUsingEncoding:NSUTF8StringEncoding]
                                                        options:0 error:NULL]; //Converting the String to an array of JSONObjects.
    
    
    //NSLog(@"%@", jsonData);
    
    NSLog(@"These are tweets");
    
    
    _mapViewController = [[MapViewController alloc] init];
    [_mapViewController place:jsonData]; //Calling the place method in MapViewController.
    
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
    
    locationManager = [[CLLocationManager alloc] init]; //Creating the location manager to capture devices location.
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest; //Stting accuracy at best.
    
    [locationManager startUpdatingLocation]; //Capture location.
}

- (void)locationManager:(CLLocationManager *)locationManager didFailWithError:(NSError *)error
{
    NSLog(@"Location manager failed");
}

- (void)locationManager:(CLLocationManager *)locationManager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    [locationManager stopUpdatingLocation]; //Stop capturing location.
    NSLog(@"newLocation %@", newLocation);
    CLLocation *location = newLocation; //Store location.
    NSLog(@"location %@", location);
    double lat = location.coordinate.latitude; //Get latitude.
    double lon = location.coordinate.longitude; //Get longitutde.
    
    NSString *lat2 = [NSString stringWithFormat:@"%.8f", lat]; //Convert to string.
    NSString *lon2 = [NSString stringWithFormat:@"%.8f", lon]; //Convert to string.
    
    NSLog(@"lat:%f, lat2:%@", lat, lat2);
    
    locationArray = [[NSMutableArray alloc] init];
    [locationArray addObject:lat2]; //Store latitude as objec in array.
    [locationArray addObject:lon2]; //The same function with longitude.
    
    NSLog(@" array %@", locationArray);

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end