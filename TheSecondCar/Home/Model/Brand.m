//
//  Brand.m
//  TheSecondCar
//
//  Created by ChenWei on 16/6/26.
//  Copyright © 2016年 cw. All rights reserved.
//

#import "Brand.h"

@implementation Brand
- (void)setBrand:(NSString *)brand {
    _brand = brand;
    
    self.brand_image = [UIImage imageNamed:[NSString stringWithFormat:@"CMBrandIcon.bundle/brand_%03zd", brand.intValue]];
}
@end
