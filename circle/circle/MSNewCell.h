//
//  MSNewCell.h
//  circle
//
//  Created by msj on 2017/6/9.
//  Copyright © 2017年 msj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MSNewCell : UITableViewCell
+ (MSNewCell *)cellWithTableView:(UITableView *)tableView;
@property (strong, nonatomic) NSArray *datas;
@end
