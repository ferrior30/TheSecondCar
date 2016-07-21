//
//  CWHomeCertificationCell.m
//  TheSecondCar
//
//  Created by ChenWei on 16/7/1.
//  Copyright © 2016年 cw. All rights reserved.
//

#import "CWHomeCertificationCell.h"
#import "UIView+CWFrame.h"

@import Masonry;
@import SDWebImage;

extern CGFloat const topBottomMargin;

@interface CWHomeCertificationCell ()
@property (weak, nonatomic) UIImageView *imageV;
@end

@implementation CWHomeCertificationCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = [UIColor orangeColor];
        
        // 添加子控件
        UIImageView *imageV = [[UIImageView alloc] init];
        [self.contentView addSubview:imageV];
        self.imageV = imageV;
        
        // 布局
        [self.imageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView).insets(UIEdgeInsetsZero);
        }];
    }
    return self;
}

- (void)setImageUrl:(NSString *)imageUrl {
    imageUrl = imageUrl;
    
    [self.imageV sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:nil];
    
    [self.imageV sd_setImageWithURL:[NSURL URLWithString:imageUrl] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.imageV.image = image;
//        [self.imageV mas_updateConstraints:^(MASConstraintMaker *make) {
//            <#code#>
//        }];
//        self.height = 200;
    }];
}

// 设置cell间距
- (void)setFrame:(CGRect)frame {
    
    frame.size.height -= topBottomMargin;
    [super setFrame: frame];
}


@end
