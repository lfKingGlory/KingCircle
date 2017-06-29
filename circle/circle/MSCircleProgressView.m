//
//  MSCircleProgressView.m
//  circle
//
//  Created by msj on 2017/6/6.
//  Copyright © 2017年 msj. All rights reserved.
//

#import "MSCircleProgressView.h"
#import <POP.h>
#define RGB(R,G,B,A) [UIColor colorWithRed:(R)/255.0f green:(G)/255.0f blue:(B)/255.0f alpha:(A)]

@interface MSCircleProgressView ()
@property(nonatomic,strong)CAShapeLayer * circleLayer;
@property(nonatomic,strong)UILabel * lbProgress;
@end

@implementation MSCircleProgressView
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self configCircle];
        [self configLabel];
    }
    return self;
}

#pragma mark - Private
- (void)configLabel {
    self.lbProgress = [[UILabel alloc] init];
    self.lbProgress.text = @"0.0%";
    self.lbProgress.frame = self.bounds;
    self.lbProgress.textColor = [UIColor blackColor];
    self.lbProgress.center = self.center;
    self.lbProgress.font = [UIFont systemFontOfSize:10];
    self.lbProgress.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.lbProgress];
}

- (void)configCircle {
    
    CGFloat lineWidth = 2.5;
    CGFloat radius = self.bounds.size.width / 2.0 - lineWidth;
    CGRect rect = CGRectMake(lineWidth/2, lineWidth/2, radius*2, radius*2);
    
    //UIBezierPath勾勒轮廓
    UIBezierPath * path = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:radius];
    
    NSArray *lineDashPattern = @[@12, @2];//6,1  12,2  14，4.5  11,3.5

    CAShapeLayer * bgCircleLayer = [CAShapeLayer layer];
    bgCircleLayer.lineWidth = lineWidth;
    bgCircleLayer.strokeStart = 0.0f;
    bgCircleLayer.strokeEnd = 1.0f;
    bgCircleLayer.opacity = 0.25;
    bgCircleLayer.strokeColor = [UIColor colorWithWhite:0.8 alpha:1].CGColor;
    bgCircleLayer.path = path.CGPath;
    bgCircleLayer.fillColor = [UIColor clearColor].CGColor;
    bgCircleLayer.lineDashPattern = lineDashPattern;
    [self.layer addSublayer:bgCircleLayer];
    
    //CAShapeLayer按照轮廓画出形状
    self.circleLayer = [CAShapeLayer layer];
    self.circleLayer.strokeColor = [UIColor whiteColor].CGColor;
    self.circleLayer.path = path.CGPath;
    self.circleLayer.fillColor = [UIColor clearColor].CGColor;
    self.circleLayer.lineWidth = lineWidth;
    self.circleLayer.lineDashPattern = lineDashPattern;
    
    //CAGradientLayer做颜色渐变
    CAGradientLayer *gradientLayer =  [CAGradientLayer layer];
    gradientLayer.frame = self.bounds;
//    gradientLayer.colors = @[(id)RGB(245, 74, 129, 1.0).CGColor,(id)RGB(105, 152, 241, 1.0).CGColor];
//    gradientLayer.colors = @[(id)RGB(105, 152, 241, 1.0).CGColor,(id)RGB(245, 74, 129, 1.0).CGColor];
    gradientLayer.colors = @[(id)RGB(48, 30, 129, 1.0).CGColor,(id)RGB(194, 6, 39, 1.0).CGColor];
//    gradientLayer.colors = @[(id)RGB(178, 19, 82, 1.0).CGColor,(id)RGB(243, 9, 28, 1.0).CGColor];
    gradientLayer.locations = @[@0.25,@0.75];
    gradientLayer.startPoint = CGPointMake(1, 0);
    gradientLayer.endPoint = CGPointMake(0, 1);
    
    //让CAShapeLayer做CAGradientLayer的遮罩mask
    gradientLayer.mask = self.circleLayer;
    
    [self.layer addSublayer:gradientLayer];
    
}

- (void)updateCircleStrokeEnd:(CGFloat)strokeEnd animated:(BOOL)animated{
    if (animated) {
        [self animationWithStrokeEnd:strokeEnd];
    } else {
        self.circleLayer.strokeEnd = floor(strokeEnd*10)/1000;
        if (strokeEnd == 100) {
            self.lbProgress.text = @"100%";
        } else {
            self.lbProgress.text = [NSString stringWithFormat:@"%.1f%%",floor(strokeEnd*10)/10];
        }
    }
}

- (void)animationWithStrokeEnd:(CGFloat)strokeEnd{
    
    POPBasicAnimation * bAni = [POPBasicAnimation animationWithPropertyNamed:kPOPShapeLayerStrokeEnd];
    bAni.fromValue = @0;
    bAni.toValue = @(floor(strokeEnd*10)/1000);
    bAni.duration = 1;
    bAni.removedOnCompletion = NO;
    [self.circleLayer pop_addAnimation:bAni forKey:@"circle"];
    
    
    POPBasicAnimation *labelBani = [POPBasicAnimation animation];
    labelBani.duration = 1;
    POPAnimatableProperty * prop = [POPAnimatableProperty propertyWithName:@"count" initializer:^(POPMutableAnimatableProperty *prop) {
        [prop setReadBlock:^(id obj, CGFloat values[]) {
            values[0] = [[obj description] floatValue];
        }];
        [prop setWriteBlock:^(id obj, const CGFloat values[]) {
            NSString * str;
            if (strokeEnd == 100) {
                str = [NSString stringWithFormat:@"%.0f",values[0]];
            } else {
                str = [NSString stringWithFormat:@"%.1f",values[0]];
            }
            [obj setText:[NSString stringWithFormat:@"%@%%",str]];
        }];
        prop.threshold = 0.01;
    }];
    
    labelBani.property = prop;
    labelBani.fromValue = @(0.0);
    labelBani.toValue = @(floor(strokeEnd*10)/10);
    [self.lbProgress pop_addAnimation:labelBani forKey:@"circle"];
    
}
@end
