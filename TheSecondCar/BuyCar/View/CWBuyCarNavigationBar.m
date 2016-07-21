//
//  CWBuyCarNavigationBar.m
//  TheSecondCar
//
//  Created by ChenWei on 16/7/3.
//  Copyright © 2016年 cw. All rights reserved.
//

#import "CWBuyCarNavigationBar.h"

@import Masonry;

/** 与父控件左右间距 */
static CGFloat leftRigthMargin = 5;

@implementation CWBuyCarNavigationBar
- (void)awakeFromNib {
    [super awakeFromNib];
    
    // 背景颜色
    self.barTintColor = [UIColor orangeColor];
   
    // 添加子控件
    [self setupUI];
}

- (void)setupUI {
        
    // 1. 添加子控件
    // 1.1添加搜索view
    UISearchBar *bar = [[UISearchBar alloc] init];
     // 占位文字
    bar.placeholder = @"请输入品牌/车型";
    bar.tintColor = [UIColor redColor];
    
    [self addSubview:bar];
    self.searchBar = bar;
    
    // 1.2添加【筛选】按钮
    UIButton *filterBtn = [[UIButton alloc] init];
    [filterBtn setTitle:@"筛选" forState:UIControlStateNormal];
    [filterBtn setImage:[UIImage imageNamed:@"iconFilter"] forState:UIControlStateNormal];
    filterBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 5);
    filterBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    filterBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [filterBtn sizeToFit];
    [self addSubview:filterBtn];
    self.subscribeButton = filterBtn;
    
    // 2.布局
    //2.1 搜索按钮
    [bar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(leftRigthMargin);
        make.right.equalTo(filterBtn.mas_left).mas_offset(-leftRigthMargin);
        make.centerY.mas_offset(0);

    }];
    
    // 2.2 筛选
    [filterBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_offset(0);
        make.right.mas_offset(-leftRigthMargin);
        make.size.mas_equalTo(CGSizeMake(filterBtn.bounds.size.width + 10, filterBtn.bounds.size.height));
    }];
    
}
@end
