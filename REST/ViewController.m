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

- (IBAction)go:(id)sender
{
    self.label.text = @"Working";
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
