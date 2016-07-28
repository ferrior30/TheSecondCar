//
//  CWAboutCheMaoViewController.m
//  TheSecondCar
//
//  Created by ChenWei on 16/7/27.
//  Copyright © 2016年 cw. All rights reserved.
//

#import "CWAboutCheMaoViewController.h"
#import "UIView+CWFrame.h"
#import "CWWebView.h"

@interface CWAboutCheMaoViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSURLSession *session;
@end

@implementation CWAboutCheMaoViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"关于车猫";
    
    // 背景颜色
    self.view.backgroundColor = [UIColor colorWithRed:232/255.0 green:232/255.0 blue:232/255.0 alpha:1.0];
    
    // 添加子控件
    [self setupUI];
    
}

- (void)setupUI {
    // 1.添加headView
    UIView *headView = [[UIView alloc] init];
    [self.view addSubview:headView];
    headView.frame = CGRectMake(0, 64, self.view.frame.size.width, 150);
    
    UIImageView *imageV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"iconChemao"]];
    [headView addSubview:imageV];
    imageV.centerX = headView.centerX;
    imageV.y = 30;
    
    UILabel *label = [[UILabel alloc] init];
    [headView addSubview:label];
    label.font = [UIFont systemFontOfSize:10];
    
    NSString *CFBundleShortVersionString = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    NSString *CFBundleVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
    label.text = [NSString stringWithFormat:@"version%@ build%@",CFBundleShortVersionString,CFBundleVersion];
    [label sizeToFit];
    label.centerX = headView.centerX;
    label.y = headView.height - 20 - label.height;
    
    // 2.添加tableView
    UITableView *tableView = [[UITableView alloc] init];
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    tableView.bounces = NO;
//    tableView.separatorStyle = UITableViewCellAccessoryNone;
    
    tableView.frame = CGRectMake(0, CGRectGetMaxY(headView.frame), self.view.width, 4 * 44 + 10);
    
    tableView.dataSource = self;
    tableView.delegate = self;
    
    // 3.添加底部label
    UILabel *copyRightLabel = [[UILabel alloc] init];
    [self.view addSubview:copyRightLabel];
    
    copyRightLabel.textColor = [UIColor lightGrayColor];
    copyRightLabel.font = [UIFont systemFontOfSize:10];
    copyRightLabel.text = @"Copyright@ 2012-2016 CheMao. All Rights Reserved.";
    
    [copyRightLabel sizeToFit];
    copyRightLabel.centerX = self.view.centerX;
    copyRightLabel.y = self.view.height - 20 - label.height;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"CWAboutCheMaoCellID"];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    cell.detailTextLabel.font = [UIFont systemFontOfSize:12];
    cell.detailTextLabel.textColor = [UIColor lightGrayColor];
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            cell.textLabel.text = @"车猫认证点";
            cell.detailTextLabel.text = nil;
        }else {
            cell.textLabel.text = @"1058项专业检测";
            cell.detailTextLabel.text = nil;
        }
    }else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            cell.textLabel.text = @"联系车猫";
            cell.detailTextLabel.text = @"4001-666-555";
        }else {
            cell.textLabel.text = @"售后服务";
            cell.detailTextLabel.text = @"0571-81020407";
        }
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 0) {
        return 10;
    }else return 0;
}

#pragma mark - delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // 取出当前选中的cell
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
        [self.navigationController setNavigationBarHidden:NO];
    
    //1. 根据cell加载对应的html文件（认证 和 专业检测）
    if (indexPath.section == 0) {
        // 创建webView
        NSString *path = nil;
        UIViewController *vc = [[UIViewController alloc] init];
        vc.navigationItem.title = cell.textLabel.text;
        self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];
        CWWebView *wk = [[CWWebView alloc] init];
        wk.frame = vc.view.bounds;
        
        [vc.view addSubview:wk];
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = [UIColor whiteColor];
        
        [wk.scrollView addSubview:view];

        if (indexPath.row == 0) {
            path = [[NSBundle mainBundle] pathForResource:@"certificationCenter.html" ofType:nil];
        }else if (indexPath.row == 1) {
            path = [[NSBundle mainBundle] pathForResource:@"zhuanyejianche.html" ofType:nil];
        }
        [wk loadFileURL:[NSURL fileURLWithPath:path] allowingReadAccessToURL:[NSURL fileURLWithPath:path]];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    // 2. 致电客服和售后
    if (indexPath.section == 1) {
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleAlert];
        
        // 1.添加”取消“action
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [alertVC dismissViewControllerAnimated:NO completion:nil];
        }];
        [alertVC addAction:cancel];
        
        // 2.添加”致电“action
        NSURL *url = nil;
        if (indexPath.row == 0) {
            alertVC.title = @"欢迎您致电400电话，我们的服务时间是9:00 - 22:00,请在此时段内致电。";
            url = [NSURL URLWithString:@"tel://10086"];
        }else if (indexPath.row == 1) { // 售后服务
            alertVC.title = @"感谢你致电售后，每一次真诚的反馈都在提高我们的服务。";
            url = [NSURL URLWithString:@"tel://10086"];
        }
        
        UIAlertAction *callAction = [UIAlertAction actionWithTitle:@"致电" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            // 打电话
            if([[UIApplication sharedApplication] canOpenURL:url]) {
                [[UIApplication sharedApplication] openURL:url];
            }
        }];
    
        [alertVC addAction:callAction];
        [self presentViewController:alertVC animated:NO completion:nil];
    }
    
    // 取消选中背景颜色变化
    cell.selected = NO;
}

@end
