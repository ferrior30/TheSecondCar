//
//  CWCarInfoTableViewController.m
//  TheSecondCar
//
//  Created by ChenWei on 16/7/10.
//  Copyright © 2016年 cw. All rights reserved.
//

#import "CWCarInfoTableViewController.h"
#import "CWCarInfoCell0.h"
#import "CWCarInfoCell1.h"
#import "CWCarInfoCell2.h"
#import "CWCar.h"
#import "CWBuyCarCell.h"
#import "CWCar.h"
#import "CWCarInfoCell3.h"
#import "CWShowImageViewController.h"


@import MBProgressHUD;
@import MJExtension;
@import SDWebImage;
@import Masonry;

@interface CWCarInfoTableViewController ()<CWCarInfoCell0ImageViewDidClickDelegate>
@property (strong, nonatomic) CWCarInfo *carInfo;
@end

@implementation CWCarInfoTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.tableView.backgroundColor = [UIColor colorWithRed:253/255.0 green:240/255.0 blue:240/255.0 alpha:1];;
   
    // 1.注册cell
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([CWCarInfoCell0 class])  bundle:nil] forCellReuseIdentifier:@"CarInfoCell0"];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"reuseIdentifier"];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([CWCarInfoCell1 class])  bundle:nil] forCellReuseIdentifier:@"CarInfoCell1"];
    
    [self.tableView registerClass:[CWCarInfoCell2 class] forCellReuseIdentifier:@"CWCarInfoCell2"];
    
    // 1.5 recommand_car cell
     [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([CWBuyCarCell class]) bundle:nil] forCellReuseIdentifier:@"CWBuyCarCellID"];
    
    // 1.6 "查看更多" cell
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([CWCarInfoCell3 class]) bundle:nil] forCellReuseIdentifier:@"CWCarInfoCell3"];
    // 1、显示hud
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    NSString *url = [NSString stringWithFormat:@"http://www.chemao.com.cn/api/index.php?funcNo=1122&dss_uuid=20391471-7364-f316-b56f-38dc9386828c&trade_id=%@&uid=&uuid=09279715-7AB4-4630-97B3-8C6B3DE352B0", self.trade_id];
    
    // AFN方式
    //    [self downloadWithAFN:url];
    
    // 2、NSURLSession方式
    // 2.1、创建一个NSURLSession
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    // 2.2、利用NSURLSession创建一个任务(task)
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        NSHTTPURLResponse *res  = (NSHTTPURLResponse *)response;
        if (res.statusCode == 200) { // 请求成功，有数据。
            NSStringEncoding GBEncoding  = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
            
            NSString *str = [[NSString alloc] initWithData:data encoding:GBEncoding];
            
            NSData *dataUTF8 = [str dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:NO];
            
            NSDictionary *dictUTF8 = [NSJSONSerialization JSONObjectWithData:dataUTF8 options:kNilOptions error:nil];
            
            // 字典转模型
            CWCarInfo *carInfo = [CWCarInfo mj_objectWithKeyValues:dictUTF8[@"data"][@"base_info"]];
            carInfo.desc = dictUTF8[@"data"][@"half_price_service"][@"desc"];
            carInfo.url = dictUTF8[@"data"][@"half_price_service"][@"url"];
            carInfo.cheShangName = dictUTF8[@"data"][@"base_info"][@"user_b"][@"name"];
            carInfo.cheShangAddress = dictUTF8[@"data"][@"base_info"][@"user_b"][@"address"];
            
            carInfo.total_num = dictUTF8[@"data"][@"recommend_car"][@"total_num"];
//            for (NSDictionary *carDict in  dictUTF8[@"data"][@"recommend_car"][@"cars"]) {
//                NSMutableArray *cars = [CWCar mj_objectArrayWithKeyValuesArray:carInfo]
//            }
            NSMutableArray *recommend_cars = [CWCar mj_objectArrayWithKeyValuesArray:dictUTF8[@"data"][@"recommend_car"][@"cars"]];
            carInfo.recommend_cars = recommend_cars;

            
            self.carInfo = carInfo;
            
            dispatch_group_t group = dispatch_group_create();
            dispatch_group_enter(group);
            // 下载第一张图片
            [[SDWebImageManager sharedManager] downloadImageWithURL:[NSURL URLWithString:self.carInfo.images.firstObject]  options:kNilOptions progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                
                self.carInfo.imageHeight = [UIScreen mainScreen].bounds.size.width * image.size.height / image.size.width;
                dispatch_group_leave(group);
            }];
            
            dispatch_group_notify(group, dispatch_get_main_queue(), ^{
                // 计算cell的高度
                [self.carInfo cell0height];
                
                [hud hide:YES afterDelay:0];
                
                [self.tableView reloadData];
                
            });
            
            hud.mode = MBProgressHUDModeText;
            hud.labelText = @"成功";
        }else { // 请求失败，没有数据
            // 回到主线程，hide hud
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                hud.mode = MBProgressHUDModeText;
                hud.labelText = @"请求数据失败";
                [hud hide:YES afterDelay:1];
            }];
        }
    }];
    // 2.3、执行任务
    [task resume];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.carInfo == nil) return 0;
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.carInfo == nil) return 0;
    if (section == 0) { //  车辆简介和商家信息
        if (self.carInfo.desc.length > 0) {
             return 2;
        }else  return 1;
    }else if (section == 1 || section == 2) {  // 车辆档案
        return 1;
    }else if (section == 3) {  // 同款推荐
        return self.carInfo.recommend_cars.count;
    }else  { // 查看更多
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            CWCarInfoCell0 *cell = [tableView dequeueReusableCellWithIdentifier: @"CarInfoCell0"];
            cell.carInfo = self.carInfo;
            cell.delegate = self;
            return cell;
        }else {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"carInfocellDefault"];
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"carInfocellDefault"];
                cell.backgroundColor = [UIColor colorWithRed:253/255.0 green:240/255.0 blue:240/255.0 alpha:1];
                cell.textLabel.textColor =  [UIColor colorWithRed:198/255.0 green:20/255.0 blue:28/255.0 alpha:1];
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
                // 分隔线
                UIView *separateLine = [[UIView alloc] init];
                separateLine.backgroundColor = [UIColor lightGrayColor];
                [cell.contentView addSubview:separateLine];
                [separateLine mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(cell.contentView);
                    make.bottom.equalTo(cell.contentView).mas_offset(-1);
                    make.right.mas_equalTo(cell);
                    make.height.mas_equalTo(1);
                }];

            }
            cell.textLabel.text = self.carInfo.desc;
            return cell;
        } 
    }else if (indexPath.section == 1) {
        CWCarInfoCell1 *cell = [tableView dequeueReusableCellWithIdentifier: @"CarInfoCell1"];
        cell.carInfo = self.carInfo;
        return cell;
    }else if (indexPath.section == 2) {
        CWCarInfoCell2 *cell = [tableView dequeueReusableCellWithIdentifier: @"CWCarInfoCell2"];
        return cell;
    }else if (indexPath.section == 3) {
        CWBuyCarCell *cell = [tableView dequeueReusableCellWithIdentifier: @"CWBuyCarCellID"];
        cell.car = self.carInfo.recommend_cars[indexPath.row];
        return cell;
    }else {
        CWCarInfoCell3 *cell = [tableView dequeueReusableCellWithIdentifier:@"CWCarInfoCell3" forIndexPath:indexPath];
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return self.carInfo.cell0height;
        }else return 44;
    }else if (indexPath.section == 1) {
        return 88;
    }else if (indexPath.section == 2) {
        return 40 * 3 + 44;
    }else if (indexPath.section == 3) {
        return 100;
    }else {
        return  64;//[super tableView:tableView heightForRowAtIndexPath:indexPath];
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0 || section == 4) {
        return 0;
    }
    return 40;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0 || section == 4) {
        return nil;
    }else {
        UITableViewHeaderFooterView *headView = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:@"headView"];
        headView.contentView.backgroundColor = [UIColor whiteColor];
        UIView *redView = [[UIView alloc] init];
        redView.backgroundColor = [UIColor redColor];
        [headView.contentView addSubview:redView];
        [redView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(headView.contentView);
            make.left.equalTo(headView.contentView);
            make.bottom.equalTo(headView.contentView);
            make.width.mas_equalTo(3);
        }];
        
        // 分隔线
        UIView *separateLine = [[UIView alloc] init];
        separateLine.backgroundColor = [UIColor lightGrayColor];
        [headView.contentView addSubview:separateLine];
        [separateLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(headView.contentView);
            make.bottom.equalTo(headView.contentView).mas_offset(-0.5);
            make.right.mas_equalTo(headView.contentView);
            make.height.mas_equalTo(1);
        }];
        
        
        headView.textLabel.font = [UIFont systemFontOfSize:18];
        if (section == 1) {
            headView.textLabel.text = @"商家信息";
        }else if (section == 2) {
            headView.textLabel.text = @"车辆档案";
        }else {
            headView.textLabel.text = [NSString stringWithFormat:@"同款推荐(%zd)", self.carInfo.recommend_cars.count];
        }
        return headView;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 3) { // “推荐车辆”section
        return 0;
    }else return 20;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
}

#pragma mark - delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];
    
    if (indexPath.section == 1) {
        
        UIViewController *v = [[UIViewController alloc] init];
        
        v.view.backgroundColor = [UIColor redColor];
        
//        self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];
        
        [self.navigationController pushViewController:v animated:YES];
    }else if (indexPath.section == 3) { // ”同款推荐“
        CWCar *car = self.carInfo.recommend_cars[indexPath.row];
        NSString *trade_id = car.trade_id;
        
        // 显示该汽车详情界面
        CWCarInfoTableViewController *carInfoVc = [[CWCarInfoTableViewController alloc] init];
//        self.navBar.searchBar.hidden = YES;
//        self.navBar.subscribeButton.hidden = YES;
        NSArray *stringsArr = [car.name componentsSeparatedByString:@" "];
        
        carInfoVc.navigationItem.title = [NSString stringWithFormat:@"%@ %@ %@", stringsArr[0], stringsArr[1], stringsArr[2]];
        carInfoVc.trade_id = trade_id;
        
        [self.navigationController pushViewController:carInfoVc animated:YES];

    }
    
}
- (void)carInfoCell0ImageViewDidClick:(NSInteger)selectedImageViewIndex {
    CWShowImageViewController *vc = [[CWShowImageViewController alloc] initWith:self.carInfo selectedImageViewIndex:selectedImageViewIndex];
    
    [self.navigationController presentViewController:vc animated:NO completion:nil];
    
}

@end
