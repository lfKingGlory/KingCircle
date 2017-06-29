//
//  MSCircleCell.h
//  circle
//
//  Created by msj on 2017/6/6.
//  Copyright © 2017年 msj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MSCircleCell : UITableViewCell
+ (MSCircleCell *)cellWithTableView:(UITableView *)tableView;
@property (assign, nonatomic) CGFloat progress;

@end
