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
    int pX; // initial point
    int pY; // initial point
    int dpX; // end point
    int dpY; // end point
    
    NSMutableArray *totalSoundShapes; // Dynamically changing array that stores our shapes
    SSoundShape *playhead; 
    
    UIColor *uciBlueColor;
    UIColor *uciGoldColor;
    
}

//Touch Methods

-(void)doTouchesOn:(NSSet *)touches withEvent:(UIEvent *)event;
-(void)doTouchesOff:(NSSet *)touches withEvent:(UIEvent *)event;
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event;
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event;
-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event;
-(void)drawSoundShape;
-(void)Shake;



@end
