//
//  SSoundView.m
//  ucimusic147-5
//
//  Created by Greg Jeckell on 5/17/13.
//  Copyright (c) 2013 UCI Music 147. All rights reserved.
//

#import "SSoundView.h"
#import "MUS147Event_Touch.h"
#import "MUS147AQPlayer.h"
#import "MUS147Event_note.h"
#import <QuartzCore/QuartzCore.h>
extern MUS147AQPlayer* aqp;

@implementation SSoundView

static NSInteger voiceTypeID;

-(id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        // Initialization code
        totalSoundShapes = [[NSMutableArray alloc] init];
        uciBlueColor = [UIColor colorWithRed:0./255. green:34./255. blue:68./255. alpha:1.];
        uciGoldColor = [UIColor colorWithRed:255./255. green:222./255. blue:108./255. alpha:1.];
        
        // Create the playhead
        playhead = [[SSoundShape alloc] init]; 
        playhead.sPoint = CGPointMake(0, 0);
        playhead.sWidth = self.frame.size.width;
        playhead.sHeight = 5;
        playhead.color = uciBlueColor;
        [playhead setFrame:playhead.makeShape];
        [playhead setBackgroundColor:playhead.color];
        [playhead.layer setBorderColor:uciGoldColor.CGColor];
        [playhead.layer setBorderWidth:1.0f];
        [totalSoundShapes addObject:playhead]; // Add it into the NSMutableArray
        [self addSubview:playhead];
    }
    return self;
}

-(void)doTouchesOn:(NSSet *)touches withEvent:(UIEvent *)event {}

-(void)doTouchesOff:(NSSet *)touches withEvent:(UIEvent *)event {}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self doTouchesOn:touches withEvent:event];
    for (UITouch* t in touches) {
        CGPoint pt = [t locationInView:self];
        pX = pt.x;
        pY = pt.y;
        touch = t;
        dpX = 0;
        dpY = 0;
    }
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    [self doTouchesOn:touches withEvent:event];
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [self doTouchesOff:touches withEvent:event];
    for(UITouch* t in touches) {
        CGPoint pt = [t locationInView:self];
        dpX = pt.x - pX;
        dpY = pt.y - pY;
        touch = t;
        
        // Create a new SSoundShape Object
        SSoundShape *newSoundShape = [[SSoundShape alloc] init];
        newSoundShape.sPoint = CGPointMake(pX, pY);
        newSoundShape.sWidth = dpX;
        newSoundShape.sHeight = dpY;
        newSoundShape.color = uciBlueColor;
        newSoundShape.voiceType = voiceTypeID;
        [newSoundShape setFrame:newSoundShape.makeShape];
        [newSoundShape setBackgroundColor:newSoundShape.color];
        [newSoundShape.layer setBorderColor:uciGoldColor.CGColor];
        [newSoundShape.layer setBorderWidth:1.0f];
        
        // Add the shape Object to the Array
        [totalSoundShapes addObject:newSoundShape];
        [self addSubview:newSoundShape];
    }
}

-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    [self doTouchesOff:touches withEvent:event];
}

-(void)drawSoundShapes {
    // Reset playhead position
    if(playhead.frame.origin.y+playhead.frame.size.height >= self.bounds.size.height) {
        playhead.sPoint = CGPointMake(playhead.sPoint.x, 0);
        [aqp.sequencer rewind];
    }
    
    // Loop through the shapes and draw each to the view
    for (SSoundShape *shape in totalSoundShapes) {
        // Handle shape collision with playhead
        if(shape != playhead && CGRectIntersectsRect(shape.makeShape, playhead.makeShape)) {
            [shape setBackgroundColor:[UIColor redColor]];
            
            // Add sound event for current shape if it's not currently active
            if(!shape.active) {
                float startTime = aqp.sequencer.scoreTime;
                float duration = fabs(shape.sHeight/self.bounds.size.height*6.75);
                int noteNum = [self noteCall:shape.sPoint.x];
                float amp = fabs(shape.sWidth / self.bounds.size.width);
        
                [aqp.sequencer addEventNote:startTime :duration :noteNum :amp :shape.voiceType];
                shape.active = YES; // Set shape to active to prevent it from being added multiple times
            }
        } else {
            [shape setBackgroundColor:shape.color];
        }
    }
}

-(void)shake {
    [aqp.sequencer allOnNotesOff];
    [aqp.sequencer reset];
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [totalSoundShapes removeAllObjects]; // Remove all objects from the NSMutableArray
    [totalSoundShapes addObject:playhead]; // Add playhead back
    [self addSubview:playhead];
}

-(void)updatePlayhead {
    if(aqp.sequencer.playing) {
        playhead.sPoint = CGPointMake(playhead.sPoint.x, playhead.sPoint.y + 1);
        [playhead setFrame:playhead.makeShape];
        [self drawSoundShapes];
    }
}
 
-(float)noteCall:(int)x {
    int position = x / (self.bounds.size.width / 8); // Divide screen into sections to select notes (C Major)
    switch(position) {
        case 0:
            return 60; //C
        case 1:
            return 62; //D
        case 2:
            return 64; //E
        case 3:
            return 65; //F
        case 4:
            return 67; //G
        case 5:
            return 69; //A
        case 6:
            return 71; //B
        case 7:
            return 72; //C (Octave Above)
        default:
            return 0;
    }
}

+(void)setVoiceTypeID:(NSInteger)voiceType {
    voiceTypeID = voiceType;
    NSLog(@"voiceTypeID = %ld", (long)voiceTypeID);
}

@end

