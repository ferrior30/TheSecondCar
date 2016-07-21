//
//  CWCarInfoCell0.m
//  TheSecondCar
//
//  Created by ChenWei on 16/7/11.
//  Copyright © 2016年 cw. All rights reserved.
//

#import "CWCarInfoCell0.h"
#import "CWBuyScrollView.h"
#import "CWShowImageViewController.h"

@import SDWebImage;
@import Masonry;

@implementation CWCarInfoCell0

- (void)awakeFromNib {
    [super awakeFromNib];
    // 添加tap手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [self.scrollView addGestureRecognizer:tap];
    
    self.scrollView.currentIndex = 0;
}

#pragma mark- tap手势：弹出图片详情控制器
- (void)tap:(UITapGestureRecognizer *)tap {
//    CWShowImageViewController *vc = [[CWShowImageViewController alloc] initWithImages:self.carInfo.images imageViewSize:self.scrollView.bounds.size];
    
    if ([self.delegate respondsToSelector:@selector(carInfoCell0ImageViewDidClick:)]) {
        
        [self.delegate carInfoCell0ImageViewDidClick:self.scrollView.currentIndex];
    }
    
}


- (void)setCarInfo:(CWCarInfo *)carInfo {
    _carInfo = carInfo;
    self.scrollView.carInfo = carInfo;
    
    self.iconCheMao.hidden = NO;
    
    // 给scrollView添加图片控件
    NSMutableArray<UIImageView *> *imageViews = [NSMutableArray array];
    self.scrollView.imageViews = imageViews;
    for (int i = 0; i < carInfo.images.count; i++) {
        UIImageView *imageV = [[UIImageView alloc] init];
        [self.scrollView insertSubview:imageV belowSubview:self.scrollView.brandIdView];
        [self.scrollView.imageViews addObject:imageV];
        [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.scrollView).mas_offset(0);
            make.bottom.equalTo(self.scrollView).mas_offset(0);
            make.left.equalTo(self.scrollView).mas_offset(i * self.scrollView.bounds.size.width);
            make.size.equalTo(self.scrollView);
        }];
    }
    
    // 更新imageV的高度
    [self.scrollView.imageViews.firstObject sd_setImageWithURL:[NSURL URLWithString:carInfo.images.firstObject] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (!error) {
            self.scrollView.imageViews.firstObject.image = image;
            self.iconCheMao.hidden = YES;
            
            // 如果图片高度不是正确的高度，更新高度
            if (self.scrollView.frame.size.height != carInfo.imageHeight) {
                self.scrollViewHeightConstraint.constant = carInfo.imageHeight;
            }
        }
    }];
    
    // name
    self.nameLabel.text = carInfo.name;
    
    // sellerPrice
    self.priceLabel.attributedText = carInfo.sellerProce;
    
    // xinChePice
    self.xinChePrice.text = carInfo.xinChePrice;
    
}

@end
