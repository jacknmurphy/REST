//
//  ViewController.h
//  REST
//
//  Created by Jack Murphy on 02/12/2013.
//  Copyright (c) 2013 Jack Murphy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (nonatomic, readwrite, weak) IBOutlet UIButton *button;
@property (nonatomic, readwrite, weak) IBOutlet UILabel *label;

- (IBAction)go:(id)sender;

@end
