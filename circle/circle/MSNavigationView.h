//
//  MSNavigationView.h
//  circle
//
//  Created by msj on 2017/6/7.
//  Copyright © 2017年 msj. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, NavigationType) {
    NavigationType_Mine,
    NavigationType_Message
};

@interface MSNavigationView : UIView
@property (assign, nonatomic) CGFloat backgroundColorAlpha;
@property (copy, nonatomic) void (^actionBlock)(NavigationType type);
@end
