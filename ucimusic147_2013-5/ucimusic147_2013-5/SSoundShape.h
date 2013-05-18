//
//  SSoundShape.h
//  ucimusic147-5
//
//  Created by Greg Jeckell on 5/17/13.
//  Copyright (c) 2013 UCI Music 147. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SSoundShape : NSObject

@property (nonatomic) CGPoint sPoint;
@property (nonatomic) float sWidth;
@property (nonatomic) float sHeight;

-(CGRect)makeShape;

@end
