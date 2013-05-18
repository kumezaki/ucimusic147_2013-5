//
//  SSoundView.m
//  ucimusic147-5
//
//  Created by Greg Jeckell on 5/17/13.
//  Copyright (c) 2013 UCI Music 147. All rights reserved.
//

#import "SSoundView.h"

@implementation SSoundView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        totalSoundShapes = [[NSMutableArray alloc] init];
        self.backgroundColor = [UIColor blackColor];
        uciBlueColor = [UIColor colorWithRed:0./255. green:34./255. blue:68./255. alpha:1.];
        uciGoldColor = [UIColor colorWithRed:255./255. green:222./255. blue:108./255. alpha:1.];
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
        // Set the top left point of the shape
        newSoundShape.sPoint = CGPointMake(pX, pY);
        // Set shape width and height
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
    
    // Loop through the shapes and Draw each to the view
    for (SSoundShape *shape in totalSoundShapes) {
        // Create shape
        CGContextAddRect(context, shape.makeShape);
        // Draw
        [uciGoldColor set];
        CGContextStrokePath(context);
        [uciBlueColor set];
        // Handle simple collision
        CGContextFillRect(context, shape.makeShape);
        for (SSoundShape *s in totalSoundShapes) {
            CGRect shape1 = s.makeShape;
            CGRect shape2 = shape.makeShape;
            if(shape1.size.width != shape2.size.width && CGRectIntersectsRect(shape1, shape2)) {
                [[UIColor redColor] set];
                CGContextFillRect(context, shape2);
            }
        }
    }
}


@end
