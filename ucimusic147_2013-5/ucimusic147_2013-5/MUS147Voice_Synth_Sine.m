//
//  MUS147Voice_Synth_Sine.m
//  ucimusic147_2013-5
//
//  Created by Greg Jeckell on 9/13/13.
//
//

#import "MUS147Voice_Synth_Sine.h"
#import "MUS147AQPlayer.h"

@implementation MUS147Voice_Synth_Sine

-(void)addToAudioBuffer:(Float64*)buffer :(UInt32)num_samples
{
    // compute normalized angular frequency
    Float64 phase = (freq * 2 * M_PI)/ kSR;
    
    // iterate through each element in the buffer
    for (UInt32 i = 0; i < num_samples; i++) {
        // assign value of sinusoid at phase position to buffer element
        
        buffer[i] += amp * sin(normPhase);
        
        if(normPhase > (2 * M_PI))
            normPhase -= 2 * M_PI;
        
        normPhase += phase;
    }
}

@end
