//
//  CWBuyCarViewController.m
//  TheSecondCar
//
//  Created by ChenWei on 16/7/2.
//  Copyright © 2016年 cw. All rights reserved.
//

#import "CWBuyCarViewController.h"
#import "CWBuyCarNavigationBar.h"
#import "CWBuyCarCell.h"
#import "CWBrandTableViewController.h"
#import "CWModelCategoryViewController.h"
#import "UIView+CWFrame.h"
#import "CWCar.h"
#import "CWCarInfoTableViewController.h"

#import "CWHTTPSessionManager.h"
@import MJExtension;
@import MBProgressHUD;

/** 通知名称 */
extern NSString * const CWHotBrandButtonDidClickedNotification;
extern NSString *const ModelCategoryDidSelectedNotification;

/** 屏幕尺寸 */
#define CWScreenW [UIScreen mainScreen].bounds.size.width
#define CWScreenH [UIScreen mainScreen].bounds.size.height


@interface CWBuyCarViewController ()<UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate>
/** 用于当前展示条件的所有车辆信息 */
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) CWBuyCarNavigationBar *navBar;
/** tableView的dataSource */
@property (strong, nonatomic) NSArray *cars;

@property (strong, nonatomic) CWBrandTableViewController *brandTableViewController;
/** 内部有4个搜索分类按钮 */
@property (weak, nonatomic) IBOutlet UIView *filterView;

@property (assign, nonatomic) CGPoint touchBeginPoint;

@property (strong, nonatomic) CWModelCategoryViewController *modelCategoryViewController;
/** 具体类别显示视图：tableView */
@end

@implementation CWBuyCarViewController

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navBar resignFirstResponder];
    
    
    // 设置导航栏
    CWBuyCarNavigationBar *navBar = (CWBuyCarNavigationBar *)self.navigationController.navigationBar;
    navBar.searchBar.delegate = self;
    self.navBar = navBar;
    
    
    // 加载数据
    NSString *path = [[NSBundle mainBundle] pathForResource:@"BuyCar.json" ofType:nil];
    NSData *data = [NSData dataWithContentsOfFile:path];
    
    NSError *error;
   NSDictionary *buyCarDict = [NSJSONSerialization  JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
    
    NSArray *carsDictArray = buyCarDict[@"result"][@"data"];
    NSMutableArray<CWCar *> *carsArray = [NSMutableArray array];
    for (NSDictionary *dict in carsDictArray) {
        CWCar *car = [CWCar mj_objectWithKeyValues:dict[@"car"]];
        car.trade_id = dict[@"trade"][@"id"];
        car.trade_mode = dict[@"trade"][@"mode"];
        [carsArray addObject:car];
    }
    self.cars = carsArray;
    // 注册cell
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([CWBuyCarCell class]) bundle:nil] forCellReuseIdentifier:@"CWBuyCarCellID"];
    
    self.tableView.rowHeight = 100;
    
    // 监听【最热品牌按钮选中通知】
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hotBrandButtonDidClicked:) name:CWHotBrandButtonDidClickedNotification object:nil];
    
    // 监听【搜索具体车型cell选中通知】
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(modelCategoryDidSelected:) name:ModelCategoryDidSelectedNotification object:nil];
    
    // 具体分类控制器
    CWModelCategoryViewController *modelCategoryVC = [[CWModelCategoryViewController alloc] init];
//    [self addChildViewController:modelCategoryVC];
    self.modelCategoryViewController = modelCategoryVC;
    
    
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navBar.searchBar.hidden = NO;
    self.navBar.subscribeButton.hidden = NO;
    [self.navBar resignFirstResponder];
    self.modelCategoryViewController.view.frame = CGRectMake(CWScreenW, CGRectGetMaxY(self.filterView.frame), CWScreenW - 40, self.brandTableViewController.view.frame.size.height);
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.navBar resignFirstResponder];
}


- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - 通知
/** 弹出【详细分类选择视图】通知 */
- (void)hotBrandButtonDidClicked:(NSNotification *)notification {
    // 1.已经在屏幕内
    if (self.modelCategoryViewController.view.x < CWScreenW && self.modelCategoryViewController.view.x > 0) {
        return;
    }
    // 2.在屏幕外
    self.modelCategoryViewController.view.frame = CGRectMake(CWScreenW, CGRectGetMaxY(self.filterView.frame), CWScreenW - 60, self.brandTableViewController.view.frame.size.height);
    [self.brandTableViewController.view addSubview:self.modelCategoryViewController.view];
    
    [UIView animateWithDuration:0.25 animations:^{
        self.modelCategoryViewController.view.frame = CGRectMake(60, CGRectGetMaxY(self.filterView.frame), CWScreenW - 60, self.brandTableViewController.view.frame.size.height);
    }];
}

/** 显示【详细分类选择后】视图通知 */
- (void)modelCategoryDidSelected:(NSNotification *)notification {
    self.brandTableViewController.view.height = 0;
        NSString *path = [[NSBundle mainBundle] pathForResource:@"buxianchexing" ofType:@"json"];
        NSData *data = [NSData dataWithContentsOfFile:path];
        NSError *error;
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
    NSArray *carData = dict[@"result"][@"data"];
    
    NSMutableArray *cars = [NSMutableArray array];
    for (NSDictionary *dict in carData) {
        CWCar *car = [CWCar mj_objectWithKeyValues:dict[@"car"]];
        car.trade_id = dict[@"trade"][@"id"];
        car.trade_mode = dict[@"trade"][@"mode"];
        [cars addObject:car];
    }
    
    self.cars = cars;
    
    [self.tableView reloadData];
}



#pragma mark - 监听按钮点击- > 显示【搜索条件】视图
- (IBAction)brandButtonClicked:(UIButton *)button {
    button.selected = YES;
    
    self.modelCategoryViewController.view.frame = CGRectMake(CWScreenW, CGRectGetMaxY(self.filterView.frame), CWScreenW - 60, self.brandTableViewController.view.frame.size.height);
    
    if (self.brandTableViewController.navigationController != nil) {
        return;
    }else [self.navigationController pushViewController:self.brandTableViewController animated:NO]; //[self.view addSubview:self.brandTableViewController.view];
    
}
- (IBAction)priceButtonClicked:(UIButton *)button {
     button.selected = YES;
}
- (IBAction)carYearButtonClicked:(UIButton *)button {
     button.selected = YES;
}
- (IBAction)paiXuButtonClicked:(UIButton *)button {
     button.selected = YES;
}

#pragma mark - 懒加载
- (CWBrandTableViewController *)brandTableViewController {
    if (_brandTableViewController == nil) {
        _brandTableViewController = [[CWBrandTableViewController alloc] init];
        _brandTableViewController.view.frame = CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 49 - CGRectGetMaxY(self.filterView.frame));
        
//        [self addChildViewController:_brandTableViewController];

    }
    return _brandTableViewController;
}


#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.cars.count > 0 ? self.cars.count: 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CWBuyCarCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CWBuyCarCellID"];
    cell.car = self.cars[indexPath.row];
    return cell;
}

#pragma mark - tableView delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    CWCar *car = self.cars[indexPath.row];
    NSString *trade_id = car.trade_id;
    
    // 显示该汽车详情界面
    CWCarInfoTableViewController *carInfoVc = [[CWCarInfoTableViewController alloc] init];
    self.navBar.searchBar.hidden = YES;
    self.navBar.subscribeButton.hidden = YES;
    NSArray *stringsArr = [car.name componentsSeparatedByString:@" "];
    
    carInfoVc.navigationItem.title = [NSString stringWithFormat:@"%@ %@ %@", stringsArr[0], stringsArr[1], stringsArr[2]];
    carInfoVc.trade_id = trade_id;
    
    [self.navigationController pushViewController:carInfoVc animated:YES];
}

#pragma mark - UISearchBarDelegate
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    UIViewController *vc = [[UIViewController alloc] init];
    vc.view.backgroundColor = [UIColor yellowColor];
    
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:[[UIView alloc] init]];
    vc.navigationItem.leftBarButtonItem = item;
    vc.hidesBottomBarWhenPushed= YES;
    [self.navigationController pushViewController:vc animated:YES];
    vc.view.frame = CGRectMake(0, 100, 300, 200);
}

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
    return YES;
}

#pragma mark AFN方式下载【GBK格式】数据，本处采用胡NSURLSessionDataTask的方式。
- (void)downloadWithAFN:(NSString *)url {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                NSStringEncoding GBEncoding  = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
        
                NSString *str = [[NSString alloc] initWithData:responseObject encoding:GBEncoding];
        
                NSData *dataUTF8 = [str dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:NO];
        
                NSDictionary *dictUTF8 = [NSJSONSerialization JSONObjectWithData:dataUTF8 options:kNilOptions error:nil];
                NSLog(@"dictUTF8 AFN = %@", dictUTF8);
                [dictUTF8 writeToFile:@"/Users/cw/Desktop/abcAFN.plist" atomically:YES];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

@end
