//
//  MSRefreshHeader.m
//  showTime
//
//  Created by msj on 2017/1/12.
//  Copyright © 2017年 msj. All rights reserved.
//

#import "MSRefreshHeader.h"
#import "UIColor+StringColor.h"

@interface MSRefreshHeader ()
@property (strong, nonatomic) UIView *bgView;
@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) UILabel *lbTips;
@end

@implementation MSRefreshHeader

- (void)prepare
{
    [super prepare];
    
    self.bgView = [[UIView alloc] init];
    self.bgView.backgroundColor = [UIColor clearColor];
    [self addSubview:self.bgView];
    
    self.imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"circle"]];
    [self.bgView addSubview:self.imageView];
    
    self.lbTips = [[UILabel alloc] init];
    self.lbTips.font = [UIFont systemFontOfSize:13];
    self.lbTips.textAlignment = NSTextAlignmentCenter;
    self.lbTips.textColor = [UIColor ms_colorWithHexString:@"#333333"];
    [self addSubview:self.lbTips];
   
}

- (void)placeSubviews
{
    [super placeSubviews];
    self.lbTips.frame = CGRectMake(0, self.mj_h - 16, self.mj_w, 14);
    self.bgView.frame = CGRectMake((self.mj_w - 17)/2.0, (self.lbTips.mj_y - 17)/2.0, 17, 17);
    self.imageView.bounds = self.bgView.bounds;
}

- (void)setState:(MJRefreshState)state
{
    MJRefreshCheckState;
    
    switch (state) {
        case MJRefreshStateIdle:
            self.lbTips.text = @"下拉可以刷新";
            [self stopRotation];
            break;
        case MJRefreshStatePulling:
            self.lbTips.text = @"松开立即刷新";
            [self stopRotation];
            break;
        case MJRefreshStateRefreshing:
            self.lbTips.text = @"正在刷新中...";
            [self startRotation];
            break;
        default:
            break;
    }
}

- (void)setPullingPercent:(CGFloat)pullingPercent
{
    [super setPullingPercent:pullingPercent];
    self.imageView.transform = CGAffineTransformMakeRotation(pullingPercent * M_PI);
}

- (void)stopRotation
{
    [self.imageView.layer removeAnimationForKey:@"ms_rotation"];
}
- (void)startRotation
{
    CABasicAnimation *ani = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    ani.fromValue = @0;
    ani.toValue = @(2 * M_PI);
    ani.duration = 0.6;
    ani.fillMode = kCAFillModeForwards;
    ani.removedOnCompletion = NO;
    ani.repeatCount = MAXFLOAT;
    [self.imageView.layer addAnimation:ani forKey:@"ms_rotation"];
}
@end
