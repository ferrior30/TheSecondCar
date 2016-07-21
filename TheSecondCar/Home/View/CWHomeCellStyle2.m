//
//  CWHomeCellStyle2.m
//  TheSecondCar
//
//  Created by ChenWei on 16/6/30.
//  Copyright © 2016年 cw. All rights reserved.
//

#import "CWHomeCellStyle2.h"
#import "CWHotCarView.h"
#import "CWHotModelCarView.h"
#import "UIView+CWFrame.h"

extern CGFloat const topBottomMargin;

/** hotCarViewHeight */
extern CGFloat const hotCarViewHeight;
/** hotModelCarViewHeight */
extern CGFloat const hotModelCarViewHeight;

/** 屏幕尺寸 */
#define CWScreenW [UIScreen mainScreen].bounds.size.width
#define CWScreenH [UIScreen mainScreen].bounds.size.height

@interface CWHomeCellStyle2 ()
@property (weak, nonatomic) CWHotCarView *hotCarView1;
@property (weak, nonatomic) CWHotCarView *hotCarView2;
@property (weak, nonatomic) CWHotModelCarView *hotModelView1;
@property (weak, nonatomic) CWHotModelCarView *hotModelView2;
@property (weak, nonatomic) CWHotModelCarView *hotModelView3;
@property (weak, nonatomic) CWHotModelCarView *hotModelView4;
@end

@implementation CWHomeCellStyle2

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.layer.borderWidth = 0.5;
        
        [self setupUI];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - 添加子控件
- (void)setupUI {
    CWHotCarView *hotCarView1 = [[CWHotCarView alloc] init];
    hotCarView1.car = self.carTypeHot.firstObject;
    [self.contentView addSubview:hotCarView1];
    self.hotCarView1 = hotCarView1;
    
    CWHotCarView *hotCarView2 = [[CWHotCarView alloc] init];
    hotCarView2.car = self.carTypeHot.lastObject;
    [self.contentView addSubview:hotCarView2];
    self.hotCarView2 = hotCarView2;
    
    CWHotModelCarView *hotModelView1 = [[CWHotModelCarView alloc] init];
    [self.contentView addSubview:hotModelView1];
    self.hotModelView1 = hotModelView1;
    
    CWHotModelCarView *hotModelView2 = [[CWHotModelCarView alloc] init];
    [self.contentView addSubview:hotModelView2];
    self.hotModelView2 = hotModelView2;
    
    CWHotModelCarView *hotModelView3 = [[CWHotModelCarView alloc] init];
    [self.contentView addSubview:hotModelView3];
    self.hotModelView3 = hotModelView3;
    
    CWHotModelCarView *hotModelView4 = [[CWHotModelCarView alloc] init];
    [self.contentView addSubview:hotModelView4];
    self.hotModelView4= hotModelView4;
}

// 设置cell间距
- (void)setFrame:(CGRect)frame {
    
    frame.size.height -= topBottomMargin;
    [super setFrame: frame];
}

#pragma mark - Properties
- (void)setCarTypeHot:(NSArray *)carTypeHot {
    _carTypeHot = carTypeHot;
    
    self.hotCarView1.car = carTypeHot.firstObject;
    self.hotCarView2.car = carTypeHot.lastObject;
}

- (void)setCarModelHot:(NSArray *)carModelHot {
    _carModelHot = carModelHot;
    
    self.hotModelView1.car = carModelHot[0];
    self.hotModelView2.car = carModelHot[1];
    self.hotModelView3.car = carModelHot[2];
    self.hotModelView4.car = carModelHot[3];
}

#pragma mark - 布局子控件
- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.hotCarView1.frame = CGRectMake(0, 0, CWScreenW * 0.5, hotCarViewHeight);
    self.hotCarView2.frame = CGRectMake(CWScreenW * 0.5, 0, CWScreenW * 0.5, hotCarViewHeight);
    CGFloat hotModelViewWidth = CWScreenW / 4;
    
    self.hotModelView1.frame = CGRectMake(0, hotCarViewHeight, hotModelViewWidth, hotModelCarViewHeight);
    self.hotModelView2.frame = CGRectMake(hotModelViewWidth * 1 , hotCarViewHeight, hotModelViewWidth, hotModelCarViewHeight);
    self.hotModelView3.frame = CGRectMake(hotModelViewWidth * 2, hotCarViewHeight, hotModelViewWidth, hotModelCarViewHeight);
    self.hotModelView4.frame = CGRectMake(hotModelViewWidth * 3, hotCarViewHeight, hotModelViewWidth, hotModelCarViewHeight);
}
@end
