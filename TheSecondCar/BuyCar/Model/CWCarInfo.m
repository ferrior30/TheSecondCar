//
//  CWCarInfo.m
//  TheSecondCar
//
//  Created by ChenWei on 16/7/11.
//  Copyright © 2016年 cw. All rights reserved.
//

#import "CWCarInfo.h"
@import SDWebImage;

#define CWScreenW [UIScreen mainScreen].bounds.size.width
#define CWScreenH [UIScreen mainScreen].bounds.size.height

@interface CWCarInfo ()
@property (strong, nonatomic) SDWebImageDownloader *downloader;
@end

@implementation CWCarInfo
//- (void)setImages:(NSArray *)images {
//    NSLog(@"%s", __func__);
//    _images = images;
//    
////    dispatch_group_t group = dispatch_group_create();
////    dispatch_group_enter(group);
////    // 下载第一张图片
////    [[SDWebImageManager sharedManager] downloadImageWithURL:[NSURL URLWithString:images.firstObject]  options:kNilOptions progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
////        NSLog(@"SDWebImageManager = %@", [NSThread currentThread]);
////         self.imageHeight = [UIScreen mainScreen].bounds.size.width * image.size.height / image.size.width;
////         dispatch_group_leave(group);
////    }];
////    
////    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
////        // 计算cell的高度
////        self.cell0height = self.imageHeight + 100;
////    });
//     NSLog(@"end");
//}

//-(CGFloat)cell0height {
//    if (_cell0height > 0) {
//        return _cell0height;
//    }
//    
//    dispatch_group_t group = dispatch_group_create();
//    dispatch_group_enter(group);
//    // 下载第一张图片
//    [[SDWebImageManager sharedManager] downloadImageWithURL:[NSURL URLWithString:self.images.firstObject]  options:kNilOptions progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
//        NSLog(@"SDWebImageManager = %@", [NSThread currentThread]);
//        self.imageHeight = [UIScreen mainScreen].bounds.size.width * image.size.height / image.size.width;
//        dispatch_group_leave(group);
//    }];
//    
//    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
//        // 计算cell的高度
//        _cell0height = self.imageHeight + 100;
//        
//    });
//    return _cell0height;


//}

- (NSString *)xinChePrice {
    return [NSString stringWithFormat:@"%@+%@", self.carnewprice, self.carnewprice_tax];
}

- (void)setSeller_price:(NSString *)seller_price {
    _seller_price = seller_price;
    
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:seller_price attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:18]}];
    NSAttributedString *string2 = [[NSAttributedString alloc] initWithString:@"万" attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:22]}];
    
    [string appendAttributedString:string2];
    self.sellerProce = string;
}

- (CGFloat)cell0height {
    if (_cell0height > 0) {
        return _cell0height;
    }
    CGFloat nameHeight = [self.name boundingRectWithSize:CGSizeMake(CWScreenW - 20, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesDeviceMetrics attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:17]} context:nil].size.height;
    
    CGFloat priceHeight = [[UIFont systemFontOfSize:22] lineHeight];
    
    CGFloat newPriceHeight = [[UIFont systemFontOfSize:12] lineHeight];
    
    _cell0height = self.imageHeight + 10 + nameHeight + 0 + priceHeight + 5 + newPriceHeight + 10;
    return _cell0height;

}

//- (void)calculateCell0Height {
//    
//}
@end
