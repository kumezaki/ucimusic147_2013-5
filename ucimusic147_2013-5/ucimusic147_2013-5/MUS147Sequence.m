//
//  MUS147Sequence.m
//  Music147_2013
//
//  Created by Lab User on 5/8/13.
//  Copyright (c) 2013 Kojiro Umezaki. All rights reserved.
//

#import "MUS147Sequence.h"

#import "MUS147Event_Note.h"

@implementation MUS147Sequence

@synthesize numEvents;

-(id)init
{
    self = [super init];    
    return self;
}

-(MUS147Event*)getEvent:(UInt32)pos
{
    @autoreleasepool {
        return events[pos];
    }
}

-(void)addEvent:(MUS147Event*)event
{
    events[numEvents++] = event;
}

@end
