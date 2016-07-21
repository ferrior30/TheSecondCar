//
//  CWBuyScrollView.m
//  TheSecondCar
//
//  Created by ChenWei on 16/7/12.
//  Copyright © 2016年 cw. All rights reserved.
//

#import "CWBuyScrollView.h"
#import "UIView+CWFrame.h"
#import "CWShowImageViewController.h"

@import Masonry;
@import SDWebImage;
@import MBProgressHUD;

@interface CWBuyScrollView ()<UIScrollViewDelegate>

@end


@implementation CWBuyScrollView

- (void)awakeFromNib {
    self.width = [UIScreen mainScreen].bounds.size.width;
    
    self.delegate = self;
    
    UIView *brandIdView = [[UIView alloc] init];
    brandIdView.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.5];
    [self.superview addSubview:brandIdView];
    self.brandIdView = brandIdView;
    
    UILabel *carIdLabel = [[UILabel alloc] init];
    carIdLabel.font = [UIFont systemFontOfSize:12];
    carIdLabel.text = @"编号：";
    carIdLabel.textColor = [UIColor whiteColor];
    [self.brandIdView addSubview:carIdLabel];
    self.carIdLabel = carIdLabel;
    
    UILabel *totalImageIndex = [[UILabel alloc] init];
    totalImageIndex.font = [UIFont systemFontOfSize:12];
    totalImageIndex.text = @"/9";
    totalImageIndex.textColor = [UIColor whiteColor];
    [self.brandIdView addSubview:totalImageIndex];
    self.totalImageIndex = totalImageIndex;
    
    UILabel *currentImageIndex = [[UILabel alloc] init];
    currentImageIndex.text = @"1";
    currentImageIndex.textColor = [UIColor redColor];
    currentImageIndex.font = [UIFont systemFontOfSize:12];
    [self.brandIdView addSubview:currentImageIndex];
    self.currentImageIndex = currentImageIndex;
    
    // 布局
    [self.carIdLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.brandIdView).mas_offset(10);
        make.centerY.mas_equalTo(self.brandIdView.mas_centerY);
    }];
    
    [self.totalImageIndex mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.brandIdView).mas_offset(-10);
        make.centerY.equalTo(self.brandIdView);
    }];
    
    [self.currentImageIndex mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.totalImageIndex.mas_left).mas_offset(0);
         make.centerY.equalTo(self.brandIdView);
    }];
}

- (void)layoutSubviews {
    [super layoutSubviews];

    [self.brandIdView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.superview).offset(self.carInfo.imageHeight - 25);
    
        make.left.equalTo(self.superview).mas_offset(0);
        make.right.equalTo(self.superview).mas_offset(0);
        
//        make.width.mas_equalTo(self.bounds.size.width);
        make.height.mas_equalTo(25);
    }];
    self.contentSize = CGSizeMake(375 * self.carInfo.images.count, 0);
}

//#pragma mark- tap手势
//- (void)tap:(UITapGestureRecognizer *)tap {
//    CWShowImageViewController *vc = [[CWShowImageViewController alloc] initWithImages:self.carInfo.images imageViewSize:self.bounds.size];
//    
//    vc.view.backgroundColor = [UIColor blackColor];
//    
//    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:vc animated:NO completion:nil];
//}

#pragma mark - Proterties
- (void)setCarInfo:(CWCarInfo *)carInfo {
    _carInfo = carInfo;
    
    self.carIdLabel.text = [NSString stringWithFormat:@"编号：%@", carInfo.car_id];
    
}

#pragma mark - UIScrollViewdelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
     CGPoint offset = scrollView.contentOffset;
    
    NSInteger index = (NSInteger)(offset.x / self.bounds.size.width);
    
    self.currentImageIndex.text = [NSString stringWithFormat:@"%zd", index + 1];
    
    [MBProgressHUD showHUDAddedTo:self animated:YES];
    [self.imageViews[index] sd_setImageWithURL:[NSURL URLWithString:self.carInfo.images[index]] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        if (image != nil) { // 图片下载成功
            self.imageViews[index].image = image;
            [MBProgressHUD hideHUDForView:self animated:NO];
        }else {  // 图片下载失败
            MBProgressHUD *hud = [MBProgressHUD allHUDsForView:self].firstObject;
            hud.mode = MBProgressHUDModeText;
            hud.labelText = @"加载失败";
            [hud hide:NO];
        }
    }];
}

@end
