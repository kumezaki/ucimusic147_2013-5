//
//  SSoundViewController.m
//  ucimusic147_2013-5
//
//  Created by Lab User on 5/22/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "SSoundViewController.h"
#import "MUS147AQPlayer.h"
extern MUS147AQPlayer* aqp;

@implementation SSoundViewController
@synthesize sView;
@synthesize settingsController;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [self setSView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self becomeFirstResponder];
    
    // Create update timer connected to the aqp sequencer
    updateTimer = [NSTimer scheduledTimerWithTimeInterval: 1.0 / aqp.sequencer.bpm target:sView selector:@selector(updatePlayhead) userInfo:nil repeats:YES];
    [aqp.sequencer play];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
    [self resignFirstResponder];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

-(BOOL)canBecomeFirstResponder {
    return YES;
}

//Shake method detect
-(void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    if (motion == UIEventSubtypeMotionShake) {
        [sView shake];
    }
}

- (IBAction)BPM:(UISlider *)sender {
    if(aqp.sequencer.playing) {
        [updateTimer invalidate];
        updateTimer = [NSTimer scheduledTimerWithTimeInterval: 1.0 / aqp.sequencer.bpm target:sView selector:@selector(updatePlayhead) userInfo:nil repeats:YES];
        [aqp.sequencer setBpm:sender.value];
    }
}

- (IBAction)Pause:(UIButton *)sender {
    [self sequencePause];
}

- (void)sequencePause {
    if(aqp.sequencer.playing) {
        [aqp.sequencer stop];
    }
    else {
        [aqp.sequencer play];
    }
}

- (IBAction)switchToSettings:(id)sender {
    if (settingsController == nil) {
        SSoundSettingsController *newSettingsController =
        [[SSoundSettingsController alloc]
         initWithNibName:@"NewViewController"
         bundle:[NSBundle mainBundle]];
        
        self.settingsController = newSettingsController;
    }
    
    // How you reference your navigation controller will
    // probably be a little different
    [self.navigationController
     pushViewController:self.settingsController
     animated:YES];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    [self sequencePause];
}
@end
