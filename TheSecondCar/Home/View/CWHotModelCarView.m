//
//  CWHotModelCarView.m
//  TheSecondCar
//
//  Created by ChenWei on 16/7/1.
//  Copyright © 2016年 cw. All rights reserved.
//

#import "CWHotModelCarView.h"
#import "CWCarCategory.h"
#import "UIView+CWFrame.h"


@import SDWebImage;
@import Masonry;

@interface CWHotModelCarView ()
@property (weak, nonatomic) UILabel *titlelabel;
@property (weak, nonatomic) UIImageView *imageV;
@end

@implementation CWHotModelCarView
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.layer.borderWidth = 0.5;
        self.layer.borderColor = [UIColor lightGrayColor].CGColor;
        
        //1. 添加子控件
        UILabel *titlelabel = [[UILabel alloc] init];
        titlelabel.font = [UIFont systemFontOfSize:14];
        [self addSubview:titlelabel];
        self.titlelabel = titlelabel;
        
        UIImageView *imageV = [[UIImageView alloc] init];
        [self addSubview:imageV];
        self.imageV = imageV;
        
        [titlelabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_offset(0);
            make.top.mas_equalTo(20);
        }];
        
        // 2.2 imageV
        [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_offset(0);
            make.top.equalTo(titlelabel.mas_bottom).mas_equalTo(5);
            make.size.mas_equalTo(CGSizeMake(75, 44));
        }];

    }
    return self;
}


- (void)setCar:(CWCarCategory *)car {
    _car = car;
    
    self.titlelabel.text = car.title;
    
    [self.imageV sd_setImageWithURL:[NSURL URLWithString:car.imageUrl] placeholderImage:nil];
}

@end
