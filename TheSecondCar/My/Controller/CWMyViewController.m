//
//  CWMyViewController.m
//  TheSecondCar
//
//  Created by ChenWei on 16/7/26.
//  Copyright © 2016年 cw. All rights reserved.
//

#import "CWMyViewController.h"
#import "CWMyTableViewCell0.h"
#import "CWMyTableViewCell1.h"
#import "CWWebView.h"
#import "UIView+CWFrame.h"
#import "CWAboutCheMaoViewController.h"

@import Masonry;
@import AFNetworking;

NSString *const CWMyTableViewCell0ID = @"CWMyTableViewCell0ID";
NSString *const CWMyTableViewCell1ID = @"CWMyTableViewCell1ID";

@interface CWMyViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) UITableView *tableView;
@end

@implementation CWMyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 添加子控件
    [self setupUI];
    
    // 隐藏导航条
//    [self.navigationController setNavigationBarHidden:YES];
    
}

- (void)setupUI {
    // 添加头部
    UIView *headView = [[UIView alloc] init];
    [self.view addSubview:headView];
    headView.frame = CGRectMake(0, 0, self.view.frame.size.width, 200);
    headView.backgroundColor = [UIColor redColor];
    
    UIButton *icon = [[UIButton alloc] init];
    [headView addSubview:icon];
    icon.frame = CGRectMake(0, 0, 65, 70);
    icon.center = headView.center;
    [icon setImage:[UIImage imageNamed:@"iconUnLogin"] forState:UIControlStateNormal];
    
    [icon addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *label = [[UILabel alloc] init];
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:12];
    label.text = @"免注册，手机直接登陆";
    [label sizeToFit];
    label.centerX = headView.centerX;
    label.y = CGRectGetMaxY(icon.frame) + 10;
    [headView addSubview:label];
    
    
    // 添加tableView
    UITableView *tableView = [[UITableView alloc] init];
    [self.view addSubview:tableView];
    self.tableView = tableView;
    tableView.backgroundColor = [UIColor colorWithRed:232/255.0 green:232/255.0  blue:232/255.0  alpha:1.0];
    tableView.frame = CGRectMake(0, CGRectGetMaxY(headView.frame), self.view.frame.size.width, self.view.frame.size.height - headView.frame.size.height - self.tabBarController.tabBar.frame.size.height);
    
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    tableView.dataSource = self;
    tableView.delegate = self;
    
//    tableView.rowHeight = 100;
    
    // 注册cell
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([CWMyTableViewCell0 class]) bundle:nil] forCellReuseIdentifier:CWMyTableViewCell0ID];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([CWMyTableViewCell1 class]) bundle:nil] forCellReuseIdentifier:CWMyTableViewCell1ID];
}

#pragma mark - 内部方法
- (void)login {
    
}

#pragma mark - dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }else if (section == 1) {
        return 3;
    }else return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        CWMyTableViewCell0 *cell = [tableView dequeueReusableCellWithIdentifier:CWMyTableViewCell0ID];
        
        return cell;
    }else {
        CWMyTableViewCell1 *cell = [tableView dequeueReusableCellWithIdentifier:CWMyTableViewCell1ID];
        
        if (indexPath.section == 1) {
            if (indexPath.row == 0) {
                cell.nameLabel.text = @"我的福利";
            }else if (indexPath.row == 1) {
                cell.nameLabel.text = @"现场看车记录";
                cell.icon.image = [UIImage imageNamed:@"aboutIcon"];
            }else if (indexPath.row == 2) {
                cell.nameLabel.text = @"关于车猫";
                cell.icon.image = [UIImage imageNamed:@"aboutIcon"];
            }
            return cell;
        }else {
            cell.nameLabel.text = @"推送通知";
            cell.icon.image = [UIImage imageNamed:@"aboutIcon"];
            UISwitch *switchBtn = [[UISwitch alloc] init];
            [cell.contentView addSubview:switchBtn];
            
            [switchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(cell.contentView);
                make.right.mas_offset(-20);
            }];
            
            return cell;
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == tableView.numberOfSections - 1) {
        return 0;
    }else return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CWMyTableViewCell0ID];
        
        return cell.frame.size.height;
    }else return 44;
}

#pragma mark - delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        
    }else if (indexPath.section == 1) {
        if (indexPath.row == 0) { // “我的福利”
            NSString *url = @"http://www.chemao.com.cn/wap/index.php?app=userIndexData&act=coupon";
            UIViewController *vc = [[UIViewController alloc] init];
            vc.navigationItem.title = @"我的福利";
            self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];
            CWWebView *wk = [[CWWebView alloc] init];
            wk.frame = vc.view.bounds;
//
            [vc.view addSubview:wk];
            UIView *view = [[UIView alloc] init];
            view.backgroundColor = [UIColor whiteColor];
            view.frame = CGRectMake(0, 0, 375, 46);
            wk.progressView.y = 46;
            [wk.scrollView addSubview:view];
//
            [wk loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
            vc.automaticallyAdjustsScrollViewInsets = NO;
            wk.scrollView.contentInset = UIEdgeInsetsMake(64 - 46, 0, 49, 0);
            
            
            
            [self.navigationController setNavigationBarHidden:NO];
            [self.navigationController pushViewController:vc animated:YES];
            
//            NSString *path = [[NSBundle mainBundle] pathForResource:@"wodeFuli.html" ofType:nil];
//            NSString *string = [[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
//            
//            UIViewController *vc = [[UIViewController alloc] init];
//            vc.navigationItem.title = @"现场看车记录";
//            self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];
//            CWWebView *wk = [[CWWebView alloc] init];
//            wk.frame = vc.view.bounds;
//            
//            [vc.view addSubview:wk];
//            UIView *view = [[UIView alloc] init];
//            view.backgroundColor = [UIColor whiteColor];
//            
//            [wk.scrollView addSubview:view];
//            
//            [wk loadHTMLString:string baseURL:[NSURL fileURLWithPath:path]];
//            [self.navigationController setNavigationBarHidden:NO];
//            [self.navigationController pushViewController:vc animated:YES];
        }else if (indexPath.row == 1) { // "现场看车记录"
            NSString *path = [[NSBundle mainBundle] pathForResource:@"kanchejilu.html" ofType:nil];
            NSString *string = [[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
            
            UIViewController *vc = [[UIViewController alloc] init];
            vc.navigationItem.title = @"现场看车记录";
            self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];
            CWWebView *wk = [[CWWebView alloc] init];
            wk.frame = vc.view.bounds;
            
            [vc.view addSubview:wk];
            UIView *view = [[UIView alloc] init];
            view.backgroundColor = [UIColor whiteColor];
            
            [wk.scrollView addSubview:view];
            
            [wk loadHTMLString:string baseURL:[NSURL fileURLWithPath:path]];
            [self.navigationController setNavigationBarHidden:NO];
            [self.navigationController pushViewController:vc animated:YES];
        }else if (indexPath.row == 2) { // 关于车猫
            CWAboutCheMaoViewController *aboutCheMaoVC = [[CWAboutCheMaoViewController alloc] init];
            aboutCheMaoVC.navigationItem.title = @"关于车猫";
            self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];
            // 隐藏导航条
            [self.navigationController setNavigationBarHidden:NO];
            aboutCheMaoVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:aboutCheMaoVC animated:YES];
        }
        
    }
    
    // 取消cell的选中变灰状态
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [cell setSelected:NO];

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES];
}

@end
