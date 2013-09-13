//
//  MUS147Voice_Synth.m
//  Music147_2013
//
//  Created by Kojiro Umezaki on 4/26/13.
//  Copyright (c) 2013 Kojiro Umezaki. All rights reserved.
//

#import "MUS147Voice_Synth.h"

#import "MUS147AQPlayer.h"

@implementation MUS147Voice_Synth

-(void)addToAudioBuffer:(Float64*)buffer :(UInt32)num_samples
{
//    // compute normalized angular frequency
//    Float64 deltaNormPhase = freq / kSR;
//    
//    // iterate through each element in the buffer
//    for (UInt32 i = 0; i < num_samples; i++)
//    {
//        // assign value of sinusoid at phase position to buffer element
//		buffer[i] += amp * sin(normPhase * 2 * M_PI);
//        
//        // advance the phase position
//		normPhase += deltaNormPhase;
//        
//        
//    }
    
    // compute normalized angular frequency
    Float64 phase = (freq * 2 * M_PI)/ 22050.0f;
    
    // iterate through each element in the buffer
    for (UInt32 i = 0; i < num_samples; i++) {
        // assign value of sinusoid at phase position to buffer element
        
        buffer[i] += amp * sin(normPhase);   //Sine
        
        //buffer[i] += normPhase < M_PI ? amp : amp * -1.0;  //Square
        
        //buffer[i] += amp - (amp / M_PI * normPhase);     //Sawtooth
        
        //buffer[i] += normPhase < M_PI ? -1*amp + (2*amp/M_PI) * normPhase : 3*amp - (2*amp/M_PI) * normPhase;    //Triangle
        
        if(normPhase > (2 * M_PI))
            normPhase -= 2 * M_PI;
    
        normPhase += phase;
    }
}

@end
