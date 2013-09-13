//
//  SSoundShape.h
//  ucimusic147-5
//
//  Created by Greg Jeckell on 5/17/13.
//  Copyright (c) 2013 UCI Music 147. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SSoundShape : UIView

@property (nonatomic) CGPoint sPoint;
@property (nonatomic) int sWidth;
@property (nonatomic) int sHeight;
@property (nonatomic) BOOL active;
@property (nonatomic) UIColor *color;

-(CGRect)makeShape;

@end
