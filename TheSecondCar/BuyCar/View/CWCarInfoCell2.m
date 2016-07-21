//
//  CWCarInfoCell2.m
//  TheSecondCar
//
//  Created by ChenWei on 16/7/13.
//  Copyright © 2016年 cw. All rights reserved.
//

#import "CWCarInfoCell2.h"
@import Masonry;

@interface CWCarInfoCell2 ()
@property (weak, nonatomic) UILabel *km_numLabel;
@property (weak, nonatomic) UILabel *first_reg;
@property (weak, nonatomic) UILabel *gearbox_type;
@property (weak, nonatomic) UILabel *emissions;
@property (weak, nonatomic) UILabel *paifang;
@end

@implementation CWCarInfoCell2

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UIView *view0 = [self createLabelView];
        ((UILabel *)view0.subviews.firstObject).text = @"表显里程";
        [self.contentView addSubview:view0];
        self.km_numLabel = ((UILabel *)view0.subviews.lastObject);
        self.km_numLabel.text = @"23.5";
        
        UIView *view1 = [self createLabelView];
        [self.contentView addSubview:view1];
        ((UILabel *)view1.subviews.firstObject).text = @"首次上牌";
        self.first_reg = ((UILabel *)view1.subviews.lastObject);
        self.first_reg.text = @"2014-1";

        
        UIView *view2 = [self createLabelView];
        [self.contentView addSubview:view2];
        ((UILabel *)view2.subviews.firstObject).text = @"变速箱";
        self.gearbox_type = ((UILabel *)view2.subviews.lastObject);
        self.gearbox_type.text = @"手动";
        
        UIView *view3 = [self createLabelView];
        [self.contentView addSubview:view3];
        ((UILabel *)view3.subviews.firstObject).text = @"排量";
        self.emissions = ((UILabel *)view3.subviews.lastObject);
        self.emissions.text = @"1.5T";
        
        UIView *view4 = [self createLabelView];
        [self.contentView addSubview:view4];
        ((UILabel *)view4.subviews.firstObject).text = @"排放标准";
        self.paifang = ((UILabel *)view4.subviews.lastObject);
        self.paifang.text = @"5T";
        
        UIView *view5 = [self createLabelView];
        [self.contentView addSubview:view5];
        
        UIView *view6 = [[UIView alloc] init];
        view6.layer.borderColor = [UIColor lightGrayColor].CGColor;
        view6.layer.borderWidth = 0.5;
        [self.contentView addSubview:view6];
        
        UILabel *label = [[UILabel alloc] init];
        
        label.textColor =[ UIColor lightGrayColor];
        label.font =[UIFont systemFontOfSize:12];
        label.numberOfLines = 0;
        label.text = @"* 以上信息仅供参考，以实际为准。以上信息仅供参考，以实际为准。以上信息仅供参考，以实际为准。";
        [view6 addSubview:label];
        
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(label.superview.mas_left).offset(10);
            make.right.equalTo(label.superview.mas_right).offset(-10);
            make.top.equalTo(label.superview);
            make.bottom.equalTo(label.superview);

        }];
        
        // 布局
        CGFloat height = 40;
        [view0 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView);
            make.left.equalTo(self.contentView);
            make.width.equalTo(self.contentView.mas_width).multipliedBy(0.5);
            make.height.mas_equalTo(height);
        }];
        
        [view1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView);
            make.left.equalTo(view0.mas_right);
            make.right.equalTo(self.contentView.mas_right);
            make.height.mas_equalTo(height);
        }];
        
        [view2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(view0.mas_bottom);
            make.left.equalTo(self.contentView);
            make.width.equalTo(self.contentView.mas_width).multipliedBy(0.5);
            make.height.mas_equalTo(height);
        }];
        
        [view3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(view1.mas_bottom);
            make.left.equalTo(view0.mas_right);
            make.right.equalTo(self.contentView.mas_right);
            make.height.mas_equalTo(height);
        }];
        
        
        [view4 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(view3.mas_bottom);
            make.left.equalTo(self.contentView);
            make.width.equalTo(self.contentView.mas_width).multipliedBy(0.5);
            make.height.mas_equalTo(height);
        }];
        
        [view5 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(view3.mas_bottom);
            make.left.equalTo(view4.mas_right);
            make.right.equalTo(self.contentView);
            make.height.mas_equalTo(height);
        }];
        
        [view6 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(view5.mas_bottom);
            make.left.equalTo(self.contentView);
            make.right.equalTo(self.contentView);
            make.height.mas_equalTo(44);
        }];
    }
    return self;
}


#pragma mark - 内部方法
/** 创建label的整体View：里面包含有二个label */
- (UIView *)createLabelView {
    UIView *wholeView = [[UIView alloc] init];
    wholeView.layer.borderWidth = 0.5;
    wholeView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    // 添加子控件
    UILabel *label = [[UILabel alloc] init];
    label.font = [UIFont systemFontOfSize:10];
    label.textColor = [UIColor lightGrayColor];
    [label sizeToFit];
    [wholeView addSubview:label];
    
    UILabel *rightLabel = [[UILabel alloc] init];
    rightLabel.font = [UIFont systemFontOfSize:12];
    rightLabel.textColor = [UIColor blackColor];
    [wholeView addSubview:rightLabel];
    
    // 布局
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(wholeView).offset(10);
        make.top.equalTo(wholeView);
         make.bottom.equalTo(wholeView);
    }];
    
    [rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(label.mas_right).offset(10);
        make.top.equalTo(wholeView);
        make.bottom.equalTo(wholeView);
    }];
    
    return wholeView;
}
@end
