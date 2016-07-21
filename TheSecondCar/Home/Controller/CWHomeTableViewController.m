//
//  CWHomeTableViewController.m
//  TheSecondCar
//
//  Created by ChenWei on 16/6/22.
//  Copyright © 2016年 cw. All rights reserved.
//

#import "CWHomeTableViewController.h"
#import "CWNavigationBar.h"
#import "CWInfiniteScrollView.h"
#import "CWHTTPSessionManager.h"
#import "Reachability.h"
#import "CWHeadView.h"
#import "UIView+CWFrame.h"
#import "Banner.h"
#import "CWHomeCellSytle1.h"
#import "CWHomeCellStyle2.h"
#import "CWHomeCertificationCell.h"
#import "CWRecommendSourceCell.h"
#import "CWCarCategory.h"

@import Masonry;
@import MJRefresh;
@import MJExtension;
@import SDWebImage;
@import MBProgressHUD;

/** 【快速通道】按钮高度 */
extern CGFloat const ButtonHeight;

/** hotCarViewHeight */
CGFloat const hotCarViewHeight = 80;
/** hotModelCarViewHeight */
CGFloat const hotModelCarViewHeight = 114;

@interface CWHomeTableViewController ()
@property (weak, nonatomic) CWInfiniteScrollView *infiniteScrollView;
@property (strong, nonatomic) CWHeadView *headVeiw;
/** banner模型数组 */
@property (strong, nonatomic) NSArray<Banner *> *banners;
/** shortcut快速通道:存储有价格和车标 */
@property (strong, nonatomic) NSMutableArray<NSArray *> *shortcutsAndPrice;
/** 最热carTypeHot数组*/
@property (strong, nonatomic) NSArray *carTypeHot;
/** 最热carModelHot数组*/
@property (strong, nonatomic) NSArray *carModelHot;
/** 认证和推荐数组 */
@property (strong, nonatomic) NSArray *certificationAndRecommendCars;
@end

@implementation CWHomeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置[位置]button的文字并调整frame
//    CWNavigationBar *navBar = (CWNavigationBar *)self.navigationController.navigationBar;
//    [navBar.positionButton setTitle:@"江浙沪" forState:UIControlStateNormal];
//
//    [navBar.positionButton sizeToFit];
//    [navBar.positionButton mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.size.mas_equalTo(CGSizeMake(navBar.positionButton.bounds.size.width + 10, navBar.positionButton.bounds.size.height));
//    }];
    
    // tableView的背景颜色
    self.tableView.backgroundColor = [UIColor lightGrayColor];
    
    // 设置tableView的头部视图
    [self setupHeadView];
    
    // 添加刷新控件
    [self setupRefreshUI];
}

- (void)setupHeadView {
    // 1.创建头部View
    CWHeadView *headerView = [[CWHeadView alloc] init];
  
    self.headVeiw = headerView;
    self.tableView.tableHeaderView = headerView;
    
    // 设置section的高度
//    self.tableView.sectionHeaderHeight = 50;
    self.tableView.tintColor = [UIColor yellowColor];
//    self.tableView.sectionFooterHeight = 20;
}

#pragma mark - 刷新控件
- (void)setupRefreshUI {
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self pullDownData];
    }];
    [header beginRefreshing];
    self.tableView.mj_header = header;
    
    
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
    }];
    self.tableView.mj_footer = footer;
    footer.hidden = YES;
}

/** 下拉加载数据 */
- (void)pullDownData {
    // 0.获取JSON格式数据
    NSString *path = [[NSBundle mainBundle] pathForResource:@"home1.json" ofType:nil];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSError *error;
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
    
    // 1.下载广告imageView
    NSDictionary *resultDict = dict[@"result"];
    NSArray *bannerDic = resultDict[@"banner"];

    NSMutableArray<UIImage *> *imagesArray = [NSMutableArray array];
    for (int i = 0; i < bannerDic.count; i++) {
        [imagesArray addObject:[[UIImage alloc] init]];
    }
    
    dispatch_group_t group = dispatch_group_create();
    
        for (int i = 0; i < bannerDic.count; i ++){
            NSURL *URL = [NSURL URLWithString:bannerDic[i][@"image_path"]];
            
            dispatch_group_enter(group);
            
            [[SDWebImageManager sharedManager] downloadImageWithURL:URL options:kNilOptions progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                [imagesArray setObject:image atIndexedSubscript:i];
                dispatch_group_leave(group);
            }];
        }
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        self.headVeiw.images = imagesArray;

        [self.headVeiw layoutIfNeeded];
        
        self.tableView.tableHeaderView = self.headVeiw;
    });
    
    // 2. 价格和车标快速通道数组
    NSString *shortcutPath = [[NSBundle mainBundle] pathForResource:@"shortcut.json" ofType:nil];
    NSData *shortcutData = [NSData dataWithContentsOfFile:shortcutPath];
    NSError *shortcutError;
    
        
        NSDictionary *shortcutDict = [NSJSONSerialization JSONObjectWithData:shortcutData options:NSJSONReadingMutableContainers error:&shortcutError];
        
        self.shortcutsAndPrice = [NSMutableArray array];
        
        [self.shortcutsAndPrice addObject:shortcutDict[@"result"][@"shortcut"][@"brands"]];
        [self.shortcutsAndPrice addObject:shortcutDict[@"result"][@"shortcut"][@"price"]];
    [self.shortcutsAndPrice writeToFile:@"/User/cw/Desktop/price.plist" atomically:YES];
//        NSLog(@"shortcutsAndPrice = %@", self.shortcutsAndPrice);
    
    
    
    // 3. 最热carTypeHot数组
    NSArray *carTypeHot = shortcutDict[@"result"][@"hot"][@"carTypeHot"];
    self.carTypeHot = [CWCarCategory mj_objectArrayWithKeyValuesArray:carTypeHot];
    
    // 4. 最热carModelHot数组
    NSArray *carModelHot = shortcutDict[@"result"][@"hot"][@"carModelHot"];
    self.carModelHot = [CWCarCategory mj_objectArrayWithKeyValuesArray:carModelHot];
    
      // 5. 认证和推荐Car
    self.certificationAndRecommendCars = shortcutDict[@"result"][@"poster"];
    
    
    [self.tableView.mj_header endRefreshing];
    [self.tableView reloadData];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 5;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

/** cell */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        CWHomeCellSytle1 *cell = [[CWHomeCellSytle1 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell1"];
        cell.brands = self.shortcutsAndPrice.firstObject;
        cell.prices = self.shortcutsAndPrice.lastObject;
        return cell;
    }else if (indexPath.section == 1) {
        CWHomeCellStyle2 *cell = [[CWHomeCellStyle2 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell2"];
        
        cell.carTypeHot = self.carTypeHot;
        cell.carModelHot = self.carModelHot;

        return cell;
    }else if (indexPath.section == 2) {
        CWHomeCertificationCell *cell = [[CWHomeCertificationCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CWHomeCertificationCell"];
        
        cell.imageUrl = self.certificationAndRecommendCars.firstObject[@"imageUrl"];
        cell.linkUrl = self.certificationAndRecommendCars.firstObject[@"linkUrl"];
        
        return cell;
    }else if (indexPath.section == 3) {
        CWRecommendSourceCell *cell = [[CWRecommendSourceCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CWRecommendSourceCell"];
        
        return cell;
    }else {
        CWHomeCertificationCell *cell = [[CWHomeCertificationCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CWHomeCertificationCell"];
        cell.imageUrl = self.certificationAndRecommendCars.lastObject[@"imageUrl"];
        cell.linkUrl = self.certificationAndRecommendCars.lastObject[@"linkUrl"];
        
        return cell;
    }
}

/** section headerView */
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    if (section == 2 || section == 4) { // "认证"section 和 "二手车体验"section
        return nil;
    }
    
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor whiteColor];
//    view.height = 40;
    
    UILabel *label = [[UILabel alloc] init];
    label.textColor = [UIColor blackColor];
    NSString *text;
    if (section == 0) { // "快速通道"cell
        text = @"快速通道";
    }else if (section == 1) { // "大家都在找"cell
        text = @"大家都在找";
    }else text = @"为您推荐的车源:";
    label.text = text;
    [label sizeToFit];
    [view addSubview:label];
    

    
    UIView *redView = [[UIView alloc] init];
    redView.backgroundColor  = [UIColor redColor];
     [view addSubview:redView];
    
    //    label.x = 10;
    //    label.centerY = tableView.sectionHeaderHeight * 0.5;
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view.mas_left).mas_offset(10);
        make.centerY.mas_equalTo(view.mas_centerY);
    }];
//
////    redView.width = 3;
////    redView.height = tableView.sectionHeaderHeight;
    [redView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view.mas_left).mas_offset(0);
        make.width.mas_equalTo(3);
        make.height.equalTo(view.mas_height).mas_offset(0);
         make.centerY.mas_equalTo(view.mas_centerY);
    }];
   
    
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return  [self heightOfPriceAndBrandCell:self.shortcutsAndPrice];
    }else if (indexPath.section == 1) {
        return  hotCarViewHeight + hotModelCarViewHeight;
    }else if (indexPath.section == 2) {
        return  90;
    }else if (indexPath.section == 3) {
        return  50;
    }else return 90;

}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 2 || section == 4) { // "认证"section 和 "二手车体验"section
        return 0;
    }else return 40; // 其它
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    UIImage *image = [UIImage imageNamed:@"arrowBackRed"];
//    NSLog(@"%@", image);
//    self.infiniteScrollView.images = @[image];
//    self.infiniteScrollView.frame = CGRectMake(0, 0, 375, 100);
//    self.tableView.tableinfiniteScrollView = self.infiniteScrollView;
    
//    self.navigationController.navigationBar.
    CWNavigationBar *navBar = (CWNavigationBar *)self.navigationController.navigationBar;
    
    if (indexPath.section == 1) {
        [navBar.positionButton setTitle:@"江浙沪" forState:UIControlStateNormal];
    }else [navBar.positionButton setTitle:@"江浙沪你好" forState:UIControlStateNormal];
//    [navBar mas_updateConstraints:^(MASConstraintMaker *make) {
//        [navBar.superview updateConstraints];
//    }];
//        [navBar.positionButton masup];
    [navBar.positionButton sizeToFit];
//    CGSize size = [navBar.positionButton.titleLabel.text sizeWithAttributes:@{NSFontAttributeName:navBar.positionButton.titleLabel.font}];
        [navBar.positionButton mas_updateConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(navBar.positionButton.bounds.size.width + 0 + 10, navBar.positionButton.bounds.size.height));
            
            [navBar setNeedsUpdateConstraints];
        }];
}

/** 计算【快速通道】cell的高度 */
- (CGFloat)heightOfPriceAndBrandCell:(NSArray<NSArray *> *)priceAndbrands {
    CGFloat height = (priceAndbrands.firstObject.count + priceAndbrands.lastObject.count + 3) / 4  * ButtonHeight;
    
    return height + 10;
}


@end