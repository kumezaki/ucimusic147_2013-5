//
//  SSoundViewController.m
//  ucimusic147_2013-5
//
//  Created by Greg Jeckell on 5/17/13.
//  Copyright (c) 2013 Group 5 MUS147. All rights reserved.
//

#import "SSoundViewController.h"

@interface SSoundViewController ()

@end

@implementation SSoundViewController

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

- (void)loadView {
    // Create a view
    CGRect frame = [UIScreen mainScreen].bounds;
    SSoundView *v = [[SSoundView alloc] initWithFrame:frame];
    
    self.view = v;
}

@end
