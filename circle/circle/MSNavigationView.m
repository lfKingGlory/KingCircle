//
//  MSNavigationView.m
//  circle
//
//  Created by msj on 2017/6/7.
//  Copyright © 2017年 msj. All rights reserved.
//

#import "MSNavigationView.h"
#define RGB(R,G,B,A) [UIColor colorWithRed:(R)/255.0f green:(G)/255.0f blue:(B)/255.0f alpha:(A)]

@interface MSNavigationView ()
@property (strong, nonatomic) UIView *bottomLine;
@property (strong, nonatomic) CAGradientLayer *gradientLayer;
@end

@implementation MSNavigationView

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
        self.gradientLayer = gradientLayer;
        [self.layer addSublayer:gradientLayer];
        
        UIImageView *mine = [[UIImageView alloc] initWithFrame:CGRectMake(20, 27, 30, 30)];
        mine.backgroundColor = [UIColor yellowColor];
        mine.layer.cornerRadius = 15;
        mine.layer.masksToBounds = YES;
        mine.userInteractionEnabled = YES;
        mine.tag = NavigationType_Mine;
        [self addSubview:mine];
        [mine addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)]];
        
        UIImageView *message = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width - 50, 27, 30, 30)];
        message.backgroundColor = [UIColor grayColor];
        message.layer.cornerRadius = 15;
        message.layer.masksToBounds = YES;
        message.userInteractionEnabled = YES;
        message.tag = NavigationType_Message;
        [self addSubview:message];
        [message addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)]];
        
//        self.bottomLine = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height - 0.5, self.frame.size.width, 0.5)];
//        [self addSubview:self.bottomLine];
        
        self.backgroundColorAlpha = 0;
        
    }
    return self;
}

- (void)setBackgroundColorAlpha:(CGFloat)backgroundColorAlpha {
    self.gradientLayer.opacity = backgroundColorAlpha;
    self.backgroundColor = [UIColor colorWithWhite:1 alpha:backgroundColorAlpha];
//    self.bottomLine.backgroundColor = [UIColor colorWithWhite:0.9 alpha:backgroundColorAlpha];
}

- (void)tapAction:(UITapGestureRecognizer *)tap {
    UIImageView *imageView = (UIImageView *)tap.view;
    if (self.actionBlock) {
        self.actionBlock((NavigationType)imageView.tag);
    }
}

@end
