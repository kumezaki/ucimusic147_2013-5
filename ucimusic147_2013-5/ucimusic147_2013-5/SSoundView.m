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
extern MUS147AQPlayer* aqp;

@implementation SSoundView


-(id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        // Initialization code
        totalSoundShapes = [[NSMutableArray alloc] init]; // initialized array
        self.backgroundColor = [UIColor blackColor];
        uciBlueColor = [UIColor colorWithRed:0./255. green:34./255. blue:68./255. alpha:1.];
        uciGoldColor = [UIColor colorWithRed:255./255. green:222./255. blue:108./255. alpha:1.];
        
        // Create the playhead
        playhead = [[SSoundShape alloc] init]; 
        playhead.sPoint = CGPointMake(0, 0);
        playhead.sWidth = 400;
        playhead.sHeight = 5;
        [totalSoundShapes addObject:playhead]; // pushing it into the array
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
    
    // Reset playhead position (currently the playhead isn't driven by the sequencer just clicks)
    if(playhead.sPoint.y > self.bounds.size.height) {
        playhead.sPoint = CGPointMake(playhead.sPoint.x, 0);
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
            [aqp getSynthVoice].amp = [MUS147Event_Touch yToAmp:shape.sHeight/self.bounds.size.height];
            [aqp getSynthVoice].freq = [MUS147Event_Touch xToFreq:shape.sWidth/self.bounds.size.width];
        }
    }
}

// Remove all the shape objects on phone shake 
-(void)shake {
    [totalSoundShapes removeAllObjects];
    [totalSoundShapes addObject:playhead]; // adds the playhead back, because it gets deleted in the removeAllObjects
    [self setNeedsDisplay];
}

-(void)updatePlayhead {
    playhead.sPoint = CGPointMake(playhead.sPoint.x, playhead.sPoint.y + 1);
    [self setNeedsDisplay];
}
    


@end

