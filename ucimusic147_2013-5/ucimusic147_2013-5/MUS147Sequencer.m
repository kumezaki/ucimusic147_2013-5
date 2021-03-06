//
//  MUS147Sequencer.m
//  Music147_2013
//
//  Created by Lab User on 5/8/13.
//  Copyright (c) 2013 Kojiro Umezaki. All rights reserved.
//

#import "MUS147Sequencer.h"
#import "MUS147Event.h"
#import "MUS147Event_Note.h"
#import "MUS147Event_Touch.h"

@implementation MUS147Sequencer

@synthesize scoreTime;
@synthesize bpm;
@synthesize playing;
@synthesize recording;

-(id)init
{
    self = [super init];
    
    seq = [[MUS147Sequence alloc] init];
    scoreTime = 0.;
    bpm = 60.;
    playing = NO;
    recording = NO;
    
    return self;
}

-(void)advanceScoreTime:(Float64)elapsed_seconds
{
    if (!playing && !recording) return;
    
    Float64 elapsed_beats = bpm / 60. * elapsed_seconds;
    scoreTime += elapsed_beats;
    
    if (playing)
        for (UInt32 i = 0; i < seq.numEvents; i++)
        {
            MUS147Event* event = [seq getEvent:i];

            if (scoreTime < event.startTime)
            {
                // WAIT
                if (event.on)
                    [event doOff];
            }
            else if (scoreTime >= event.startTime + event.duration)
            {
                // DONE
                if (event.on)
                    [event doOff];
            }
            else
            {
                // PLAYING
                if (!event.on)
                    [event doOn];
                MUS147Event_Note* e = (MUS147Event*)event;
                //NSLog(@"Playing note: %d at time: %f for sec: %f", e.noteNum, e.startTime, e.duration);
            }
        }
}

-(void)play
{
    playing = YES;
    recording = NO;
}

-(void)stop
{
    playing = NO;
    recording = NO;

    [self allOnNotesOff];
}

-(void)rewind
{
    scoreTime = 0.;

    [self allOnNotesOff];
}

-(void)record
{
    playing = NO;
    recording = YES;
    
    // reset the number of events in the sequence
    seq.numEvents = 0;
}

-(void)allOnNotesOff
{
    for (UInt32 i = 0; i < seq.numEvents; i++)
    {
        MUS147Event* event = [seq getEvent:i];
        if (event.on)
            [event doOff];
    }
}

-(void)addTouchEvent:(Float64)x :(Float64)y :(BOOL)on :(UInt8)pos
{
    if (!recording) return;
    
    if (seq.numEvents > 0)
    {
        MUS147Event* prev_e = [seq getEvent:(seq.numEvents-1)];
        prev_e.duration = scoreTime - prev_e.startTime;
        
//      NSLog(@"%f %f %f %s PREV(%f,%f)",scoreTime,x,y,on?"YES":"NO",prev_e.startTime,prev_e.duration);
    }

    MUS147Event_Touch* e = [[MUS147Event_Touch alloc] init];
    e.startTime = scoreTime;
    e.duration = MAXFLOAT;
    e.x = x;
    e.y = y;
    e.type = on ? kMUS147Event_Touch_ON : kMUS147Event_Touch_OFF;
    e.pos = pos;
    
    [seq addEvent:e];
}

-(void)addEventNote:(Float64)startTime :(Float64)duration :(SInt16)noteNum :(Float64)amp :(NSInteger)voiceType {
    MUS147Event_Note* e = [[MUS147Event_Note alloc] init];
    e.startTime = startTime; // + 0.05;
    e.duration = duration;
    e.noteNum = noteNum;
    e.vType = voiceType;
    e.on = NO;
    
    // set amplitude with scalers
    switch (voiceType) {
        case kSine: e.amp = amp;
            break;
        case kSquare: e.amp = amp * 0.7f;
            break;
        case kSaw : e.amp = amp * 0.8f;
            break;
        case kTriangle: e.amp = amp * 0.9f;
            break;
        case kBlit: e.amp = amp;
            break;
        default:
            break;
    }
    
    [seq addEvent:e];
}

-(void)reset {
    seq.numEvents = 0;
}

@end
