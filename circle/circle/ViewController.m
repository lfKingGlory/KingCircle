//
//  ViewController.m
//  circle
//
//  Created by msj on 2017/6/6.
//  Copyright © 2017年 msj. All rights reserved.
//

#import "ViewController.h"
#import "MSCircleCell.h"
#import "MSRefreshHeader.h"
#import "NSDate+Add.h"
#import "MSHeaderView.h"
#import "MSNavigationView.h"
#import "MSNewCell.h"
#import "UIView+FrameUtil.h"
#import "ViewController1.h"

typedef NS_ENUM(NSInteger, Type) {
    TypeNew,          // regular table view
    TypeRegular         // preferences style table view
};

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *datas;
@property (strong, nonatomic) MSHeaderView *headerView;
@property (strong, nonatomic) MSNavigationView *navView;
@property (strong, nonatomic) UILabel *footView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.datas = [NSMutableArray array];
    [self.datas addObject:@{@"type":@(TypeNew), @"datas":@[@54.98, @100, @50, @0, @2.98, @99.88]}];
    [self.datas addObject:@{@"type":@(TypeRegular), @"datas":@[@99.99, @100, @50, @0, @2.98, @99.88, @49.86, @59.84, @34.98, @69.84, @99.88, @46.98, @58.64, @37.54, @65.64, @96.48, @43.56, @53.54, @36.54, @64.34, @99.78, @47.66, @54.78, @39.74, @65.54]}];
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    
    __weak typeof(self) weakSelf = self;
    MSRefreshHeader *header =[MSRefreshHeader headerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            if (self.datas.count == 2) {
                [self.datas removeObjectAtIndex:0];
            } else {
                [self.datas insertObject:@{@"type":@(TypeNew), @"datas":@[@54.98, @100, @50, @99.88]} atIndex:0];
            }
            
            
            [weakSelf.tableView reloadData];
            [weakSelf.tableView.mj_header endRefreshing];
        });
    }];
    self.tableView.mj_header = header;
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 49, 0);
    
    self.headerView = [[MSHeaderView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 250)];
//    self.headerView.backgroundColor = [UIColor blueColor];
    self.tableView.tableHeaderView = self.headerView;
    
    self.footView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40)];
    self.footView.font = [UIFont systemFontOfSize:12];
    self.footView.text = @"迄今为止交易无风险，担保公司担保";
    self.footView.textAlignment = NSTextAlignmentCenter;
    self.footView.textColor = [UIColor colorWithWhite:0.5 alpha:0.5];
    self.tableView.tableFooterView = self.footView;
    
    self.navView = [[MSNavigationView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
    self.navView.backgroundColorAlpha = 0;
    self.navView.actionBlock = ^(NavigationType type) {
        NSLog(@"%ld",type);
    };
    [self.view addSubview:self.navView];

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (self.tabBarController.selectedIndex == 0) {
        [self.navigationController setNavigationBarHidden:YES animated:YES];
    }else{
        [self.navigationController setNavigationBarHidden:YES animated:NO];
    }
    self.edgesForExtendedLayout = UIRectEdgeNone;
    NSLog(@"%s",__func__);
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    if (self.tabBarController.selectedIndex == 0) {
        [self.navigationController setNavigationBarHidden:NO animated:NO];
    }else{
        [self.navigationController setNavigationBarHidden:NO animated:YES];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (scrollView.contentOffset.y <= 0) {
        self.navView.backgroundColorAlpha = 0;
        [self.headerView addSubview:self.navView];
    } else {
        self.navView.backgroundColorAlpha = scrollView.contentOffset.y / 150;
        [self.view addSubview:self.navView];
    }
    [self setNeedsStatusBarAppearanceUpdate];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    if (self.tableView.contentOffset.y <= 0) {
        return UIStatusBarStyleLightContent;
    }
    return UIStatusBarStyleDefault;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.datas.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSDictionary *dic = self.datas[section];
    Type type = (Type)[dic[@"type"] integerValue];
    
    if (type == TypeNew) {
        return 1;
    } else if (type == TypeRegular) {
        return [dic[@"datas"] count];
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    NSDictionary *dic = self.datas[section];
    Type type = (Type)[dic[@"type"] integerValue];
    
    if (type == TypeRegular) {
        UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 46)];
        header.backgroundColor = [UIColor whiteColor];
        UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, header.width, 8)];
        bgView.backgroundColor = [UIColor colorWithWhite:0.8 alpha:0.1];
        [header addSubview:bgView];
        UILabel *lbTitle = [[UILabel alloc] initWithFrame:CGRectMake(20, 8, 150, 38)];
        lbTitle.textAlignment = NSTextAlignmentLeft;
        lbTitle.text = @"正在抢购";
        lbTitle.font = [UIFont boldSystemFontOfSize:15];
        [header addSubview:lbTitle];
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, header.height - 0.5, header.width, 0.5)];
        line.backgroundColor = [UIColor colorWithWhite:0.9 alpha:0.8];
        [header addSubview:line];
        
        
        return header;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    NSDictionary *dic = self.datas[section];
    Type type = (Type)[dic[@"type"] integerValue];
    
    if (type == TypeRegular) {
        return 46;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *dic = self.datas[indexPath.section];
    Type type = (Type)[dic[@"type"] integerValue];
    
    if (type == TypeNew) {
        return 200;
    } else if (type == TypeRegular) {
        return 100;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSDictionary *dic = self.datas[indexPath.section];
    Type type = (Type)[dic[@"type"] integerValue];
    
    if (type == TypeNew) {
        MSNewCell *cell = [MSNewCell cellWithTableView:tableView];
        cell.datas =  self.datas[indexPath.section][@"datas"];
        return cell;
    } else if (type == TypeRegular) {
        MSCircleCell *cell = [MSCircleCell cellWithTableView:tableView];
        NSNumber *progress = self.datas[indexPath.section][@"datas"][indexPath.row];
        cell.progress = progress.doubleValue;
        return cell;
    }
    return nil;
}

@end
