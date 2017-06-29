//
//  MSHeaderView.m
//  circle
//
//  Created by msj on 2017/6/7.
//  Copyright © 2017年 msj. All rights reserved.
//

#import "MSHeaderView.h"
#define RGB(R,G,B,A) [UIColor colorWithRed:(R)/255.0f green:(G)/255.0f blue:(B)/255.0f alpha:(A)]

@implementation MSHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        CAGradientLayer *gradientLayer =  [CAGradientLayer layer];
        gradientLayer.frame = self.bounds;
        gradientLayer.colors = @[(id)RGB(48, 30, 129, 1.0).CGColor,(id)RGB(194, 6, 39, 1.0).CGColor];
        gradientLayer.locations = @[@0.25,@0.75];
        gradientLayer.startPoint = CGPointMake(0, 0.5);
        gradientLayer.endPoint = CGPointMake(1, 0.5);
        [self.layer addSublayer:gradientLayer];
    }
    return self;
}
@end
