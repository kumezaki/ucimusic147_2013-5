//
//  SSoundViewController.h
//  ucimusic147_2013-5
//
//  Created by Lab User on 5/22/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SSoundView.h"

@interface SSoundViewController : UIViewController {
    NSTimer* updateTimer;
}

@property (strong, nonatomic) IBOutlet SSoundView *sView;

- (IBAction)BPM:(UISlider *)sender;
- (IBAction)Pause:(UIButton *)sender;


@end
