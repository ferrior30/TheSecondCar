//
//  CWHotCarView.m
//  TheSecondCar
//
//  Created by ChenWei on 16/6/30.
//  Copyright © 2016年 cw. All rights reserved.
//

#import "CWHotCarView.h"
#import "CWCarCategory.h"
#import "UIView+CWFrame.h"


@import SDWebImage;
@import Masonry;
/** 
 /@property (strong, nonatomic) NSString *title;
 @property (strong, nonatomic) NSString *detail;
 @property (strong, nonatomic) NSString *imageUrl;
 //@property (strong, nonatomic) NSDictionary *condition;
 @property (strong, nonatomic) NSString *show;**
 */

@interface CWHotCarView ()
@property (weak, nonatomic) UILabel *titlelabel;
@property (weak, nonatomic) UILabel *detailLabel;
@property (weak, nonatomic) UIImageView *imageV;
@property (weak, nonatomic) UIImageView *hotIcon;
@end

@implementation CWHotCarView
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.layer.borderWidth = 0.5;
        self.layer.borderColor = [UIColor lightGrayColor].CGColor;
        
//        self.width = self.superview.bounds.size.width * 0.5;
//        self.height = 70;
        
        //1. 添加子控件
        UILabel *titlelabel = [[UILabel alloc] init];
        titlelabel.font = [UIFont systemFontOfSize:14];
        [self addSubview:titlelabel];
        self.titlelabel = titlelabel;
        
        UILabel *detailLabel = [[UILabel alloc] init];
        detailLabel.font = [UIFont systemFontOfSize:10];
        [self addSubview:detailLabel];
        self.detailLabel = detailLabel;
        
        UIImageView *imageV = [[UIImageView alloc] init];
        [self addSubview:imageV];
        self.imageV = imageV;
        
        UIImageView *hotIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tagHot"]];
        
        [self addSubview:hotIcon];
        self.hotIcon = hotIcon;
        
        // 2.布局子控件
        CGFloat margin = 5;
        CGFloat leftMargin = 10;
        
        // 2.1 titleLabel
        
        [titlelabel mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.width.mas_equalTo(MAXFLOAT);
//            make.height.mas_equalTo(height);
            make.left.mas_offset(leftMargin);
            make.bottom.mas_equalTo(self.mas_centerY).mas_offset(-margin * 0.5);
        }];
        
        // 2.2 detailLabel
        
        [detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.width.mas_equalTo(MAXFLOAT);
//            make.height.mas_equalTo(detailLabelheight);
            make.left.mas_offset(leftMargin);
            make.top.mas_equalTo(self.mas_centerY).mas_offset(margin * 0.5);
        }];
        
        // 2.3 imageV
        [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_offset(-leftMargin);
            make.centerY.mas_offset(0);
            make.size.mas_equalTo(CGSizeMake(103, 50));
        }];
        
        // 2.4 hotIcon
        [hotIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_offset(0);
            make.right.mas_offset(-leftMargin);
            make.size.mas_equalTo(self.hotIcon.image.size);
        }];
    }
    return self;
}

- (void)setCar:(CWCarCategory *)car {
    _car = car;
    
    self.titlelabel.text = car.title;
    
    self.hotIcon.hidden = !car.show.integerValue;
    
    self.detailLabel.text = car.detail;
    
    [self.imageV sd_setImageWithURL:[NSURL URLWithString:car.imageUrl] placeholderImage:nil];
}

@end
