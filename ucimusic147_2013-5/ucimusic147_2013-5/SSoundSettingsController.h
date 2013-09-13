//
//  SSoundSettingsController.h
//  ucimusic147_2013-5
//
//  Created by Greg Jeckell on 7/27/13.
//
//

#import <UIKit/UIKit.h>

@interface SSoundSettingsController : UIViewController {
    IBOutlet UISlider* ampSlider;
    IBOutlet UISlider* delaySlider;
    IBOutlet UISegmentedControl* waveSegmentedControl;
    IBOutlet UISegmentedControl* filterSegmentedControl;
    NSInteger filterType;
}

- (IBAction)setAmp:(id)sender;
- (IBAction)setDelay:(id)sender;
- (IBAction)setWaveType:(id)sender;
- (IBAction)setFilterType:(id)sender;

@end
