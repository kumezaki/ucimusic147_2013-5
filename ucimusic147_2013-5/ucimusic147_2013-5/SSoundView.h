//
//  SSoundView.h
//  ucimusic147-5
//
//  Created by Greg Jeckell on 5/17/13.
//  Copyright (c) 2013 UCI Music 147. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SSoundShape.h"

@interface SSoundView : UIView {
    UITouch* touch;
    int pX;
    int pY;
    int dpX;
    int dpY;
    
    NSMutableArray *totalSoundShapes;
    SSoundShape *playhead;
    
    UIColor *uciBlueColor;
    UIColor *uciGoldColor;
    
}

-(void)doTouchesOn:(NSSet *)touches withEvent:(UIEvent *)event;
-(void)doTouchesOff:(NSSet *)touches withEvent:(UIEvent *)event;
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event;
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event;
-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event;

-(void)drawSoundShape;


@end
