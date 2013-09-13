//
//  MUS147Event_Touch.m
//  Music147_2013
//
//  Created by Kojiro Umezaki on 5/17/13.
//  Copyright (c) 2013 Kojiro Umezaki. All rights reserved.
//

#import "MUS147Event_Touch.h"

#import "MUS147AQPlayer.h"
extern MUS147AQPlayer* aqp;

@implementation MUS147Event_Touch

@synthesize x;
@synthesize y;
@synthesize type;
@synthesize pos;

-(void)doOn
{
//    NSLog(@"%f %f %f %s %f touch %s",startTime,x,y,"doOn",duration,type?"on":"off");

    on = YES;
    if (voice == nil)
        voice = [aqp getSynthVoiceWithPos:pos];

    if (type == kMUS147Event_Touch_ON)
    {
        voice.amp = [MUS147Event_Touch yToAmp:y];
        voice.freq = [MUS147Event_Touch xToFreq:x];
        [voice on];
    }
    else
        [voice off];
}

-(void)doOff
{
//    NSLog(@"%f %f %f %s %f touch %s",startTime,x,y,"doOff",duration,type?"on":"off");

    on = NO;
    voice = nil;
}

+(Float64)xToFreq:(Float64)x
{
    return x * 2000.;
}

+(Float64)yToAmp:(Float64)y
{
    return 1. - y;
}

@end
