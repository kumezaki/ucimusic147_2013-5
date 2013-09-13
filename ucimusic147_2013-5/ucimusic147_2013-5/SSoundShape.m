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
@synthesize active;
@synthesize color;
@synthesize voiceType;

-(id)init {
    if (self = [super init]) {
        active = NO;
        
        uciBlueColor = [UIColor colorWithRed:0./255. green:34./255. blue:68./255. alpha:1.];
        uciGoldColor = [UIColor colorWithRed:255./255. green:222./255. blue:108./255. alpha:1.];
    }
    return self;
}

-(CGRect)makeShape {
    return CGRectMake(self.sPoint.x, self.sPoint.y, self.sWidth, self.sHeight); //returns a rectangle
}

-(UIColor*)colorByNumber:(NSInteger)number {
    UIColor *c;
    switch (number) {
        case 0: c = uciBlueColor;
            break;
        case 1: c = [UIColor orangeColor];
            break;
        case 2: c = [UIColor purpleColor];
            break;
        case 3: c = [UIColor yellowColor];
            break;
        case 4: c = [UIColor greenColor];
            break;
        default: c = [UIColor grayColor];
            break;
    }
    color = c;
    return c;
}

@end
