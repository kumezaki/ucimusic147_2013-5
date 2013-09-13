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

@implementation MUS147Event {
    int count;
}

@synthesize startTime;
@synthesize duration;
@synthesize on;
@synthesize vType;

-(void)doOn
{
    on = YES;
    if (voice == nil)
        voice = [aqp getSynthVoiceOfType:vType];
}

-(void)doOff
{
    on = NO;
    voice.amp = 0;
    voice = nil;
}

@end
