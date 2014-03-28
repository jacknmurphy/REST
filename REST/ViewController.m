//
//  ViewController.m
//  REST
//
//  Created by Jack Murphy on 02/12/2013.
//  Copyright (c) 2013 Jack Murphy. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController

@synthesize button=_button;
@synthesize label=_label;
@synthesize tweetId=_tweetId;
@synthesize tweetContent=_tweetContent;
@synthesize connection=_connection;

NSString *tweet;

- (IBAction)fetchTweet
{
    NSURL *url = [NSURL URLWithString:@"http://127.0.0.1:8080/Jersey/rest/hello"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:60.0];
    
    [request setValue:@"text/html" forHTTPHeaderField: @"Content-Type"];

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
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end