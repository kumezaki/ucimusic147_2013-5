//
//  MUS147Voice_Synth_Saw.m
//  ucimusic147_2013-5
//
//  Created by Greg Jeckell on 9/13/13.
//
//

#import "MUS147Voice_Synth_Saw.h"
#import "MUS147AQPlayer.h"

@implementation MUS147Voice_Synth_Saw

-(void)addToAudioBuffer:(Float64*)buffer :(UInt32)num_samples
{
    // compute normalized angular frequency
    Float64 phase = (freq * 2 * M_PI)/ kSR;
    
    // iterate through each element in the buffer
    for (UInt32 i = 0; i < num_samples; i++) {
        
        buffer[i] += amp - (amp / M_PI * normPhase);
        
        if(normPhase > (2 * M_PI))
            normPhase -= 2 * M_PI;
        
        normPhase += phase;
    }
    
}

@end
