//
//  SSoundAppDelegate.h
//  ucimusic147_2013-5
//
//  Created by Lab User on 5/22/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SSoundViewController;

@interface SSoundAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) SSoundViewController *viewController;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;

@end
