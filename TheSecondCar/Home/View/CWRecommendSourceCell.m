//
//  CWRecommendSourceCell.m
//  TheSecondCar
//
//  Created by ChenWei on 16/7/1.
//  Copyright © 2016年 cw. All rights reserved.
//

#import "CWRecommendSourceCell.h"

extern CGFloat const topBottomMargin;

@import Masonry;

@implementation CWRecommendSourceCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.layer.borderWidth = 0.5;
        self.layer.borderColor = [UIColor lightGrayColor].CGColor;
        
        // 添加子控件
        UILabel *label = [[UILabel alloc] init];
        label.text = @"暂无推荐车源";
        label.textColor = [UIColor lightGrayColor];
        [self.contentView addSubview:label];
        
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.contentView);
        }];
    }
    
    return self;
}

// 设置cell间距
- (void)setFrame:(CGRect)frame {
    
    frame.size.height -= topBottomMargin;
    [super setFrame: frame];
}

@end
