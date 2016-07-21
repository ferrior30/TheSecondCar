//
//  CWModelCategoryViewController.m
//  TheSecondCar
//
//  Created by ChenWei on 16/7/8.
//  Copyright © 2016年 cw. All rights reserved.
//

#import "CWModelCategoryViewController.h"
#import "UIView+CWFrame.h"
#import "CWCar.h"

//@import AFNetworking;
#import "CWHTTPSessionManager.h"
@import MJExtension;

NSString *const ModelCategoryDidSelectedNotification = @"ModelCategoryDidSelectedNotification";

@interface CWModelCategoryViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *models;
@end

@implementation CWModelCategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 背景颜色
    self.view.backgroundColor = [UIColor purpleColor];
    
    // 添加scrollView
    UITableView *tableView = [[UITableView alloc] init];
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    tableView.frame = self.view.bounds;
    tableView.delegate = self;
    tableView.dataSource = self;
    
    // 添加pan手势
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [self.view addGestureRecognizer:pan];
    
    // 加载数据
    [self laodData];

}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    self.tableView.frame = self.view.bounds;
}

#pragma makr - 加载数据
- (void)laodData {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"baoma" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSError *error;
    NSMutableDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
//    self.models = dict[@"result"][@"factory"];
    self.models = [NSMutableArray arrayWithArray:dict[@"result"][@"factory"]];
    NSDictionary *dictItem0 = @{@"model_list" : @[@{@"name": @"不限车型"}],
                                @"factory_name": @"#"};
    [self.models insertObject:dictItem0 atIndex:0];
    
    [dict writeToFile:@"/Users/cw/Desktop/baoma.plist" atomically:YES];
}

#pragma mark - pan手势
- (void)pan:(UIPanGestureRecognizer *)pan {
    CGPoint point = [pan locationInView:self.view.superview];
    self.view.x = point.x;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return  self.models.count ;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [self.models[section][@"model_list"] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = self.models[indexPath.section][@"model_list"][indexPath.row][@"name"];
//    cell.imageView.image = [UIImage imageNamed:@"ico_Adviser"];
    

    cell.hidden = NO;
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
//    if (section == 0) {
//        return @"不限车型";
//    }
    
    return self.models[section][@"factory_name"];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    [UIView animateWithDuration:0.5 animations:^{
        self.view.x = [UIScreen mainScreen].bounds.size.width;
    }];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ModelCategoryDidSelectedNotification" object:nil];
}



@end
