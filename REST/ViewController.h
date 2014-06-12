//
//  ViewController.h
//  REST
//
//  Created by Jack Murphy on 02/12/2013.
//  Copyright (c) 2013 Jack Murphy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "MapViewController.h"


@interface ViewController : UIViewController<NSURLConnectionDelegate, CLLocationManagerDelegate>
{
    CLLocationManager *locationManager;
}

@property (nonatomic, readwrite, weak) IBOutlet UIButton *button;
@property (nonatomic, readwrite, weak) IBOutlet UILabel *label;

@property (nonatomic, strong) IBOutlet UILabel *tweetId;
@property (nonatomic, strong) IBOutlet UILabel *tweetContent;

@property (nonatomic) NSURLConnection *connection;

@property (nonatomic, strong) MapViewController *mapViewController;

- (IBAction)go:(id)sender;
- (IBAction)fetchTweet;


@end
