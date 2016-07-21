//
//  CWHeadView.m
//  TheSecondCar
//
//  Created by ChenWei on 16/6/24.
//  Copyright © 2016年 cw. All rights reserved.
//

#import "CWHeadView.h"
#import "UIView+CWFrame.h"

CGFloat const topBottomMargin = 10;
CGFloat const leftRightMargin = 10;
CGFloat btnHeight = 40;

@implementation CWHeadView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        // 添加子控件
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    CWInfiniteScrollView *scrollView =[[CWInfiniteScrollView alloc] init];
    [self addSubview:scrollView];
    self.scrollView = scrollView;
    
    UIButton *positionBtn = [[UIButton alloc] init];
    [positionBtn setTitle:@"我要买车" forState:UIControlStateNormal];
    positionBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    [positionBtn setImage:[UIImage imageNamed:@"iconBuy"] forState:UIControlStateNormal];
    positionBtn.backgroundColor = [UIColor redColor];
    [self addSubview:positionBtn];
    self.positonButton = positionBtn;
    
    UIButton *sellBtn = [[UIButton alloc] init];
    [sellBtn setTitle:@"我要卖车" forState:UIControlStateNormal];
    sellBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    [sellBtn setImage:[UIImage imageNamed:@"iconSell"] forState:UIControlStateNormal];
    sellBtn.backgroundColor = [UIColor orangeColor];
    [self addSubview:sellBtn];
    self.sellButton = sellBtn;
    
    UIView *bottomView = [[UIView alloc] init];
    bottomView.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:bottomView];
    
}

- (void)setImages:(NSArray<UIImage *> *)images {
    _images = images;
    
    self.scrollView.images = images;
    
    self.height = images[0].size.height / images[0].size.width * self.width + topBottomMargin * 2 + btnHeight + topBottomMargin;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    // 布局子控件
    if (CGSizeEqualToSize(self.scrollView.images[0].size, CGSizeZero)) {
        return;
    }
    
    CGFloat btnWidth = (self.width - leftRightMargin * 3) / 2;
    // scrollView
    self.scrollView.frame = CGRectMake(0, 0, self.width, self.width * self.scrollView.images[0].size.height / self.scrollView.images[0].size.width);
    
        // positionBtn
    self.positonButton.frame = CGRectMake(leftRightMargin, self.scrollView.height + topBottomMargin, btnWidth, btnHeight);
    
    self.sellButton.frame = CGRectMake(self.positonButton.width + leftRightMargin * 2, self.scrollView.height + topBottomMargin, btnWidth, btnHeight);
    
    self.subviews.lastObject.frame = CGRectMake(0, self.height - topBottomMargin, self.width, topBottomMargin);
}

@end
