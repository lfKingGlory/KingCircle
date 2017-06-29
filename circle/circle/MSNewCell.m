//
//  MSNewCell.m
//  circle
//
//  Created by msj on 2017/6/9.
//  Copyright © 2017年 msj. All rights reserved.
//

#import "MSNewCell.h"
#import "MSCircleProgressView.h"
#import "UIView+FrameUtil.h"
#import "MSLineFlowLayout.h"
#define RGB(R,G,B,A) [UIColor colorWithRed:(R)/255.0f green:(G)/255.0f blue:(B)/255.0f alpha:(A)]

#pragma mark - MSNewSubCell
@interface MSNewSubCell : UICollectionViewCell
@property (assign, nonatomic) CGFloat progress;
@end

@interface MSNewSubCell ()
@property (strong, nonatomic) MSCircleProgressView *progressView;
@property (strong, nonatomic) UIButton *btn;

@end

@implementation MSNewSubCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.progressView = [[MSCircleProgressView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
        [self.contentView addSubview:self.progressView];
        
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(65, 0, [UIScreen mainScreen].bounds.size.width - 130, 40)];
        btn.layer.masksToBounds = YES;
        btn.layer.cornerRadius = 20;
        self.btn = btn;
        
        CAGradientLayer *gradientLayer =  [CAGradientLayer layer];
        gradientLayer.frame = self.bounds;
        gradientLayer.colors = @[(id)RGB(245, 74, 129, 1.0).CGColor,(id)RGB(105, 152, 241, 1.0).CGColor];
        gradientLayer.locations = @[@0.25,@0.75];
        gradientLayer.startPoint = CGPointMake(1, 0);
        gradientLayer.endPoint = CGPointMake(0, 1);
        [self.btn.layer addSublayer:gradientLayer];
        
        [self.contentView addSubview:btn];
        
        UISwitch *s = [UISwitch new];
        s.x = 100;
        s.y = 20;
        s.onTintColor = RGB(245, 74, 129, 1.0);
        [self.contentView addSubview:s];
    }
    return self;
}
- (void)setProgress:(CGFloat)progress {
    _progress = progress;
    [self.progressView updateCircleStrokeEnd:progress animated:YES];
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.progressView.centerX = self.contentView.centerX;
    self.progressView.centerY = self.contentView.centerY - 20;
    self.btn.y = CGRectGetMaxY(self.progressView.frame) + 10;
}
@end


#pragma mark - MSNewCell
@interface MSNewCell ()<UICollectionViewDelegate, UICollectionViewDataSource>
@property (strong, nonatomic) UICollectionView *collectionView;
@end

@implementation MSNewCell
+ (MSNewCell *)cellWithTableView:(UITableView *)tableView {
    MSNewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MSNewCell"];
    if (!cell) {
        cell = [[MSNewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MSNewCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.itemSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, 200);
        layout.minimumLineSpacing = 10;
        layout.sectionInset = UIEdgeInsetsMake(15, 0, 0, 0);
        self.collectionView = [[UICollectionView alloc] initWithFrame:self.contentView.bounds collectionViewLayout:layout];
        self.collectionView.backgroundColor = [UIColor colorWithWhite:0.8 alpha:0.1];
        self.collectionView.alwaysBounceHorizontal = YES;
        self.collectionView.showsVerticalScrollIndicator = NO;
        self.collectionView.showsHorizontalScrollIndicator= NO;
        [self.collectionView registerClass:[MSNewSubCell class] forCellWithReuseIdentifier:@"MSNewSubCell"];
        self.collectionView.delegate = self;
        self.collectionView.dataSource = self;
        [self.contentView addSubview:self.collectionView];
        
    }
    return self;
}

- (void)setDatas:(NSArray *)datas {
    _datas = datas;
    [self.collectionView reloadData];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.datas.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MSNewSubCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MSNewSubCell" forIndexPath:indexPath];
    NSNumber *progress = (NSNumber *)self.datas[indexPath.item];
    cell.progress = progress.doubleValue;
    return cell;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.collectionView.frame = self.contentView.bounds;
}
@end
