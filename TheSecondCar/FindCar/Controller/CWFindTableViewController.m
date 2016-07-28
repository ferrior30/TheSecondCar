//
//  CWFindTableViewController.m
//  TheSecondCar
//
//  Created by ChenWei on 16/7/26.
//  Copyright © 2016年 cw. All rights reserved.
//

#import "CWFindTableViewController.h"
#import "CWFindTableViewCell.h"
@import WebKit;
#import "CWHTTPSessionManager.h"
@import MJRefresh;
#import "CWWebView.h"

static NSString *const CWFindCellReuseId = @"CWFindCellReuseId";

@interface CWFindTableViewController ()
@property (strong, nonatomic) AFHTTPSessionManager *manager;
@property (strong, nonatomic) NSDictionary *dict;
@end

@implementation CWFindTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 1.设置导航条
    self.navigationItem.title = @"发现";
    
    // 2.设置背景、取消分隔线
    self.tableView.backgroundColor = [UIColor colorWithRed:232/255.0 green:232/255.0 blue:232/255.0 alpha:1];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    // 3.刷新控件
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self pullDownData];
    }];
    [header beginRefreshing];
    self.tableView.mj_header = header;
}

/** 下拉请求数据 */
- (void)pullDownData {
    
    NSDictionary *paras = @{@"funcNo": @1049,
                            @"type": @3,
                            @"dss_uuid": @"20391471-7364-f316-b56f-38dc9386828c",
                            @"uuid": @"09279715-7AB4-4630-97B3-8C6B3DE352B0"
                            };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    self.manager = manager;
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    __weak typeof(self) weakSelf = self;
    [manager GET:@"http://www.chemao.com.cn/api/index.php" parameters:paras progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSStringEncoding GBEncoding  = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
        
        NSString *string = [[NSString alloc] initWithData:responseObject encoding:GBEncoding];
        
        NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:NO];
        
        NSError *error;
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        
        weakSelf.dict = dict;
        
        // 隐藏刷新控
        [weakSelf.tableView.mj_header endRefreshing];
        
        // 刷新表格
        [weakSelf.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // 隐藏刷新控
        [weakSelf.tableView.mj_header endRefreshing];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }else if (section == 1) {
        return 2;
    }else return [self.dict[@"data"] count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 100;
    }else return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 2) {
        return 0;
    }else return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    
    if (indexPath.section == 0) {
        // 创建cell
         UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CWFindCell0"];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CWFindCell0"];
            
        }
        // 设置cell内容
        cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"iconDiscoveryIntroduce"]];
        return cell;
    }
    
    // 创建cell
    CWFindTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CWFindTableViewCell"];
    if (cell == nil) {
        cell = [[CWFindTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"CWFindTableViewCell"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:12];
    }
    
    if (indexPath.section == 1) {
        // 设置cell内容
        if (indexPath.row == 0) {
            cell.textLabel.text = @"车辆估价";
            cell.detailTextLabel.text = @"您身边的车辆计算器";
        }if (indexPath.row == 1) {
            cell.textLabel.text = @"我要卖车";
            cell.detailTextLabel.text = @"卖车，我只选择车猫";
        }
        return cell;
    }else {
        cell.detailTextLabel.text = nil;
        cell.textLabel.text = self.dict[@"data"][indexPath.row][@"name"];
        return cell;
    }
}

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        UIViewController *vc = [[UIViewController alloc] init];
        vc.navigationItem.title = self.dict[@"data"][indexPath.row][@"name"];
        self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];
        WKWebView *wk = [[WKWebView alloc] init];
        wk.frame = vc.view.bounds;
        [vc.view addSubview:wk];
        
        [wk loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.chemao.com.cn/webapp/certified.html"]]];
        
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.section == 1){
        NSString *url = nil;
        if (indexPath.row == 0) {
            url = @"http://www.chemao.com.cn/wap/index.php?app=estimateprice&noheader=1";
        }else url = @"http://www.chemao.com.cn/wap/sell.html";
        UIViewController *vc = [[UIViewController alloc] init];
        vc.navigationItem.title = @"车猫";
        self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];
        WKWebView *wk = [[WKWebView alloc] init];
        wk.frame = vc.view.bounds;
        [vc.view addSubview:wk];
        
        [wk loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
        
        [self.navigationController pushViewController:vc animated:YES];
    }else {
        NSString *url = self.dict[@"data"][indexPath.row][@"url"];
        UIViewController *vc = [[UIViewController alloc] init];
        vc.navigationItem.title = @"车猫";
        self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];
        CWWebView *wk = [[CWWebView alloc] init];
        wk.frame = vc.view.bounds;
        
        [vc.view addSubview:wk];
        
        [wk loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
        
        [self.navigationController pushViewController:vc animated:YES];
    }

}


@end
