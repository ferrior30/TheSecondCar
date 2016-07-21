//
//  Brand.h
//  TheSecondCar
//
//  Created by ChenWei on 16/6/26.
//  Copyright © 2016年 cw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Brand : NSObject
/**
 brand": "18",
 "brand_name": "å®é©¬",
 "brand_py": "bm
 */
@property (strong, nonatomic) NSString *brand;
@property (strong, nonatomic) NSString *brand_name;
@property (strong, nonatomic) NSString *brand_py;

@property (strong, nonatomic) UIImage *brand_image;
@end
