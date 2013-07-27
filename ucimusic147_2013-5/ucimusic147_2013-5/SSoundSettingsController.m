//
//  SSoundSettingsController.m
//  ucimusic147_2013-5
//
//  Created by Greg Jeckell on 7/27/13.
//
//

#import "SSoundSettingsController.h"
#import "MUS147AQPlayer.h"
#import "MUS147Effect_Delay.h"
extern MUS147AQPlayer* aqp;

@interface SSoundSettingsController ()

@end

@implementation SSoundSettingsController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:@"SSoundSettingsController" bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [super viewWillDisappear:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)setAmp:(id)sender {
    [aqp getVoice:0].freq = ampSlider.value;
}

- (IBAction)setDelay:(id)sender {
    [aqp getEffect:1].delayAmp = delaySlider.value;
}

@end