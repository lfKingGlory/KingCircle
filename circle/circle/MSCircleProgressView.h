//
//  MSCircleProgressView.h
//  circle
//
//  Created by msj on 2017/6/6.
//  Copyright © 2017年 msj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MSCircleProgressView : UIView
// strokeEnd  为 0 到 100 之间的值
- (void)updateCircleStrokeEnd:(CGFloat)strokeEnd animated:(BOOL)animated;
@end
