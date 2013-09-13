//
//  MUS147Event.h
//  Music147_2013
//
//  Created by Lab User on 5/8/13.
//  Copyright (c) 2013 Kojiro Umezaki. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MUS147Voice.h"

typedef NS_ENUM(NSUInteger, voiceType) {
    kSine,
    kSquare,
    kSaw,
    kTriangle,
    kBlit
};

@interface MUS147Event : NSObject {
    Float64 startTime;
    Float64 duration;
    BOOL on;
    MUS147Voice* voice;    
}

@property (readwrite) Float64 startTime;
@property (readwrite) Float64 duration;
@property (readwrite) BOOL on;
@property (nonatomic, readwrite) NSInteger vType;

-(void)doOn;
-(void)doOff;

@end
