//
//  MUS147Event.m
//  Music147_2013
//
//  Created by Lab User on 5/8/13.
//  Copyright (c) 2013 Kojiro Umezaki. All rights reserved.
//

#import "MUS147Event.h"

#import "MUS147AQPlayer.h"
extern MUS147AQPlayer* aqp;

@implementation MUS147Event

@synthesize startTime;
@synthesize duration;
@synthesize on;
@synthesize voiceNum;

-(void)doOn
{
    
    if (voice == nil) {
        //voice = [aqp getSynthVoice];
        
        if (voiceNum < 2) voiceNum = 2;
        voice = [aqp getVoice:voiceNum++];
        NSLog(@"EVENT: playing voiceNum = %ld", (long)voiceNum);
        if (voiceNum > 4)
            voiceNum = 2;
    }
    
    

    on = YES;
}

-(void)doOff
{
    voice = nil;

    on = NO;
}

@end
