//
//  SSoundShape.m
//  ucimusic147-5
//
//  Created by Greg Jeckell on 5/17/13.
//  Copyright (c) 2013 UCI Music 147. All rights reserved.
//

#import "SSoundShape.h"

@implementation SSoundShape

@synthesize sPoint;
@synthesize sWidth;
@synthesize sHeight;

-(CGRect)makeShape {
    return CGRectMake(self.sPoint.x, self.sPoint.y, self.sWidth, self.sHeight);
}

@end