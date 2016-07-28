//
//  CWNavigationBar.m
//  TheSecondCar
//
//  Created by ChenWei on 16/6/22.
//  Copyright © 2016年 cw. All rights reserved.
//

#import "CWNavigationBar.h"

@import Masonry;

/** 与父控件左右间距 */
static CGFloat leftRigthMargin = 5;

@implementation CWNavigationBar

- (void)awakeFromNib {
    [super awakeFromNib];
    
    // 添加子控件
//    NSLog(@"%@", self.frame);
    [self setupUI];
}

- (void)setupUI {
    // 1. 添加子控件
    //1.1添加【位置】按钮
    UIButton *positionBtn = [[UIButton alloc] init];
    [positionBtn setTitle:@"江浙沪" forState:UIControlStateNormal];
    [positionBtn setImage:[UIImage imageNamed:@"iconLocationWhite"] forState:UIControlStateNormal];
    positionBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 5);
    positionBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    positionBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [positionBtn sizeToFit];
    [self addSubview:positionBtn];
    self.positionButton = positionBtn;

    
    // 1.2添加中间搜索view
    UISearchBar *bar = [[UISearchBar alloc] init];
    [self addSubview:bar];
    self.searchBar = bar;
    
    bar.placeholder = @"探索 品牌/车型";
    
    // 1.3添加【订阅】按钮
    UIButton *subscribeBtn = [[UIButton alloc] init];
    [subscribeBtn setTitle:@"订阅" forState:UIControlStateNormal];
    [subscribeBtn setImage:[UIImage imageNamed:@"iconSubscription"] forState:UIControlStateNormal];
    subscribeBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 5);
    subscribeBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    subscribeBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [subscribeBtn sizeToFit];
    [self addSubview:subscribeBtn];
    self.subscribeButton = subscribeBtn;
    
    // 2.布局
    //2.1 定位按钮
    [positionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(leftRigthMargin);
        make.right.equalTo(bar.mas_left).offset(-leftRigthMargin);
        make.centerY.mas_offset(0);
        make.size.mas_equalTo(CGSizeMake(positionBtn.bounds.size.width + 10, positionBtn.bounds.size.height));
    }];

    // 2.2 订阅按钮
    [subscribeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bar.mas_right).offset(leftRigthMargin);
        make.right.mas_offset(-leftRigthMargin);
        make.centerY.mas_offset(0);
        make.size.mas_equalTo(CGSizeMake(subscribeBtn.bounds.size.width + 10, subscribeBtn.bounds.size.height));
    }];
    
    // 2.3 搜索框
    [bar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_offset(0);
    }];
    
}



@end
