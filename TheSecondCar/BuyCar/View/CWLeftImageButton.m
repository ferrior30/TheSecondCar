//
//  CWLeftImageButton.m
//  TheSecondCar
//
//  Created by ChenWei on 16/7/5.
//  Copyright © 2016年 cw. All rights reserved.
//

#import "CWLeftImageButton.h"
#import "UIView+CWFrame.h"

@interface CWLeftImageButton ()
@property (assign, nonatomic) CGSize titleSize;
@end

@implementation CWLeftImageButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

//- (void)setTitleEdgeInsets:(UIEdgeInsets)titleEdgeInsets {
//    
//}
//
//- (void)setImageEdgeInsets:(UIEdgeInsets)imageEdgeInsets {
//    
//}

//- (CGRect)titleRectForContentRect:(CGRect)contentRect {
//    CGRect rect = self.imageView.frame;
//    return CGRectZero;
//}
//
//
//- (CGRect)imageRectForContentRect:(CGRect)contentRect {
//     return CGRectZero;
//}
//
- (CGSize)titleSize {
    CGSize size = [self.titleLabel.text boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, self.titleLabel.font.lineHeight) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.titleLabel.font} context:nil].size;
    
    return size;
}
//
//- (CGSize)imageSize {
//    return self.imageView.image.size;
//}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.titleLabel.center = CGPointMake((self.frame.size.width - self.titleSize.width - 7) * 0.5, self.centerY);
    self.imageView.center =CGPointMake(CGRectGetMaxX(self.titleLabel.frame) + 3.5, self.centerY);
}
@end
