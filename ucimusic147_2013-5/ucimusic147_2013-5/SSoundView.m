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
extern MUS147AQPlayer* aqp;

@implementation SSoundView

@synthesize voiceNum;

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
        playhead.sWidth = 400;
        playhead.sHeight = 5;
        [totalSoundShapes addObject:playhead]; // Add it into the NSMutableArray
        
        voiceNum = 0;
        added = 0;
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    [self drawSoundShape];
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
        
        // Add the shape Object to the Array
        [totalSoundShapes addObject:newSoundShape];
        [self setNeedsDisplay];
    }
}

-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    [self doTouchesOff:touches withEvent:event];
}

-(void)drawSoundShape {
    // Get the Graphics Context
    CGContextRef context = UIGraphicsGetCurrentContext();
    // Set the stroke width
    CGContextSetLineWidth(context, 3.0);
    
    // Reset playhead position
    if(playhead.sPoint.y > self.bounds.size.height) {
        playhead.sPoint = CGPointMake(playhead.sPoint.x, 0);
        [aqp.sequencer rewind];
    }
    
    // Loop through the shapes and draw each to the view
    for (SSoundShape *shape in totalSoundShapes) {
        // Draw shape
        CGRect shape1 = shape.makeShape;
        CGContextAddRect(context, shape1);
        [uciGoldColor set];
        CGContextStrokePath(context);
        [uciBlueColor set];
        CGContextFillRect(context, shape1);
        
        // Handle shape collision with playhead
        if(shape != playhead && CGRectIntersectsRect(shape1, playhead.makeShape)) {
            [[UIColor redColor] set];
            CGContextFillRect(context, shape1);
            
            // Add sound event for current shape if it's not currently active
            if(!shape.active) {
                float startTime = aqp.sequencer.scoreTime;
                float duration = shape.sHeight/self.bounds.size.height*6.75;
                int noteNum = [self noteCall:shape.sPoint.x];
                float amp = fabs(shape.sWidth / self.bounds.size.width);
        
                [aqp.sequencer addEventNote:startTime :duration :noteNum :amp];
                shape.active = YES; // Set shape to active to prevent it from being added multiple times
            }
        }
    }
}

-(void)shake {
    [totalSoundShapes removeAllObjects]; // Remove all objects from the NSMutableArray
    [totalSoundShapes addObject:playhead]; // Add playhead back
    [aqp.sequencer reset];
    [self setNeedsDisplay];
}

-(void)updatePlayhead {
    playhead.sPoint = CGPointMake(playhead.sPoint.x, playhead.sPoint.y + 1);
    [self setNeedsDisplay];
}
 
-(float)noteCall:(int)x {
    int position = x / (self.bounds.size.width / 12); // Divide screen into sections to select notes
    switch(position) {
        case 0:
            return 60;
        case 1:
            return 61;
        case 2:
            return 62;
        case 3:
            return 63;
        case 4:
            return 64;
        case 5:
            return 65;
        case 6:
            return 66;
        case 7:
            return 67;
        case 8:
            return 68;
        case 9:
            return 69;
        case 10:
            return 70;
        case 11:
            return 71;
        default:
            return 0;
    }
}

@end

