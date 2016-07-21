//
//  CWCarInfo.h
//  TheSecondCar
//
//  Created by ChenWei on 16/7/11.
//  Copyright © 2016年 cw. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;

@class CWCar;

@interface CWCarInfo : NSObject
/** cell0的高度 */
@property (assign, nonatomic) CGFloat cell0height;
/** iamgeV的高度 */
@property (assign, nonatomic) CGFloat imageHeight;
/** image数组 */
@property (strong, nonatomic) NSArray *images;

@property (strong, nonatomic) NSString *car_id;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *seller_price;
@property (strong, nonatomic) NSAttributedString *sellerProce;
@property (strong, nonatomic) NSString *carnewprice;
@property (strong, nonatomic) NSString *carnewprice_tax;
/** 辅助属性 */
@property (strong, nonatomic) NSString *xinChePrice;
/** 例如：三成买车，仅需2.94万 */
@property (strong, nonatomic) NSString *desc;
@property (strong, nonatomic) NSString *url;
/** 车商名称 */
@property (strong, nonatomic) NSString *cheShangName;
/** 车商地址 */
@property (strong, nonatomic) NSString *cheShangAddress;

/** 推荐车辆模型数组 */
@property (strong, nonatomic) NSArray<CWCar *>  *recommend_cars;
/** 全部推荐车辆数量 */
@property (strong, nonatomic) NSString *total_num;


@end
