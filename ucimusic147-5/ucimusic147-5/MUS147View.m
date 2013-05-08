//
//  MUS147View.m
//  Music147_2013
//
//  Created by Lab User on 5/1/13.
//  Copyright (c) 2013 Kojiro Umezaki. All rights reserved.
//

#import "MUS147View.h"

#import "MUS147AQPlayer.h"
extern MUS147AQPlayer* aqp;

@implementation MUS147View

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    
    // DRAWING RECTANGLE
    
    CGPoint center = CGPointMake(self.frame.size.width / 2.0, self.frame.size.height / 2.0);
    
    float rectangleWidth = 100.0;
    
    float rectangleHeight = 100.0;
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGContextAddRect(ctx,CGRectMake(center.x - (0.5 * rectangleWidth), center.y - (0.5 * rectangleHeight), rectangleWidth, rectangleHeight));
    
    CGContextSetLineWidth(ctx, 10);
    
    CGContextSetStrokeColorWithColor(ctx, [[UIColor grayColor] CGColor]);
    
    CGContextStrokePath(ctx);
    
    CGContextSetFillColorWithColor(ctx, [[UIColor greenColor] CGColor]);
    
    CGContextAddRect(ctx,CGRectMake(center.x - (0.5 * rectangleWidth), center.y - (0.5 * rectangleHeight), rectangleWidth, rectangleHeight));
    
    CGContextFillPath(ctx);
    
    
    // DRAWING CIRCLE
    
    // CGPoint center = CGPointMake(self.frame.size.width / 2.0, self.frame.size.height / 2.0);
    
    // CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    //  CGContextBeginPath(ctx);
    
    //  CGContextSetLineWidth(ctx, 5);
    
    //  CGContextAddArc(ctx, center.x, center.y, 100.0, 0, 2*M_PI, 0);
    
    //  CGContextStrokePath(ctx);
    
    
    // DRAWING LINES
    
    // CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // CGContextBeginPath(ctx);
    
    // CGContextMoveToPoint(ctx, 20.0, 20.0);
    
    // CGContextAddLineToPoint(ctx, 250.0, 100.0);
    
    // CGContextAddLineToPoint(ctx, 100.0f, 200.0f);
    
    // CGContextSetLineWidth(ctx, 5);
    
    
    // CGContextClosePath(ctx);
    
    // CGContextStrokePath(ctx);
}


-(void)doTouches:(NSSet *)touches withEvent:(UIEvent *)event
{
    for (UITouch* t in touches)
    {
        CGPoint pt = [t locationInView:self];
        Float64 x = pt.x/self.bounds.size.width;
        Float64 y = pt.y/self.bounds.size.height;
        
        [aqp getVoice:1].freq = x * 2000.;
        [aqp getVoice:1].amp = 1. - y;
    }
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self doTouches:touches withEvent:event];
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self doTouches:touches withEvent:event];
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self doTouches:touches withEvent:event];
    [aqp getVoice:1].amp = 0.;
}

-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self doTouches:touches withEvent:event];
}

@end
