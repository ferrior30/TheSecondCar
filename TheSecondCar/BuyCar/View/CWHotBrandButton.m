//
//  CWHotBrandButton.m
//  TheSecondCar
//
//  Created by ChenWei on 16/7/7.
//  Copyright © 2016年 cw. All rights reserved.
//

#import "CWHotBrandButton.h"

@implementation CWHotBrandButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.imageView.center = CGPointMake(self.bounds.size.width * 0.5, self.imageView.image.size.height * 0.5);
    
    self.titleLabel.frame = CGRectMake(0, self.imageView.bounds.size.height, self.bounds.size.width, self.bounds.size.height - self.imageView.bounds.size.height);
}

@end
