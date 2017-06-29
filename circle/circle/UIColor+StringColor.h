//
//  UIView+FrameUtil.h
//  刘飞
//
//  Created by BBM on 15/7/10.
//  Copyright (c) 2015年 刘飞. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (StringColor)
+ (UIColor *)ms_colorWithHexString:(NSString *)hexString;
+ (UIColor *)ms_colorWithHexStringAndAlpha:(NSString *)hexString;
+ (UIColor *)ms_colorWithHexString:(NSString *)hexString withAlpha:(CGFloat)alpha;
@end
