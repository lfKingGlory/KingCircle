//
//  MSCircleCell.m
//  circle
//
//  Created by msj on 2017/6/6.
//  Copyright © 2017年 msj. All rights reserved.
//

#import "MSCircleCell.h"
#import "MSCircleProgressView.h"
#import "UIView+FrameUtil.h"

@interface MSCircleCell ()
@property (strong, nonatomic) MSCircleProgressView *progressView;
@property (strong, nonatomic) UIView *line;
@property (strong, nonatomic) UILabel *lbTitle;
@property (strong, nonatomic) UILabel *lbTitle1;
@end

@implementation MSCircleCell
+ (MSCircleCell *)cellWithTableView:(UITableView *)tableView {
    MSCircleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MSCircleCell"];
    if (!cell) {
        cell = [[MSCircleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MSCircleCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.progressView = [[MSCircleProgressView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
        [self.contentView addSubview:self.progressView];
        
        self.line = [[UIView alloc] init];
        self.line.backgroundColor = [UIColor colorWithWhite:0.9 alpha:0.8];
        [self.contentView addSubview:self.line];
        
//        self.lbTitle = [[UILabel alloc] init];
//        self.lbTitle.text = @"发今晚如果发果发今晚如果发果发今晚如果发果发今晚如果发果发今晚如果发果发今晚如果发果发今晚如果发果发今晚如果发果发今晚如果发果发今晚如果发果发今晚如果发果发今晚如果";
//        self.lbTitle.font = [UIFont systemFontOfSize:16];
//        [self.contentView addSubview:self.lbTitle];
//        self.lbTitle.backgroundColor = [UIColor redColor];
//        self.lbTitle.numberOfLines = 0;
//        
//        
//        self.lbTitle1 = [[UILabel alloc] init];
//        self.lbTitle1.text = @"发今晚如果发果发今晚如果";
//        self.lbTitle1.font = [UIFont systemFontOfSize:12];
//        [self.contentView addSubview:self.lbTitle1];
//        self.lbTitle1.backgroundColor = [UIColor blueColor];
//        
//        self.lbTitle1.numberOfLines = 0;
    }
    return self;
}

- (void)setProgress:(CGFloat)progress {
    _progress = progress;
    [self.progressView updateCircleStrokeEnd:progress animated:YES];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.progressView.center = self.contentView.center;
    self.line.frame = CGRectMake(0, self.frame.size.height - 0.5, self.frame.size.width, 0.5);
    
    CGSize size = [self.lbTitle.text boundingRectWithSize:CGSizeMake(self.contentView.width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:16]} context:nil].size;
    
    self.lbTitle.frame = CGRectMake(0, 0, size.width, size.height);
    
    
    CGSize size1 = [self.lbTitle1.text boundingRectWithSize:CGSizeMake(self.contentView.width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:12]} context:nil].size;
    self.lbTitle1.frame = CGRectMake(0, CGRectGetMaxY(self.lbTitle.frame), size1.width, size1.height);
    
}
@end
