//
//  CWCar.h
//  TheSecondCar
//
//  Created by ChenWei on 16/7/5.
//  Copyright © 2016年 cw. All rights reserved.
//

#import <Foundation/Foundation.h>

@class User;
//@class CWTrade;

@interface CWCar : NSObject
@property (strong, nonatomic) NSString *id;
@property (strong, nonatomic) NSString *name;
//@property (strong, nonatomic) NSString *status;
//@property (strong, nonatomic) NSString *user_id;
@property (strong, nonatomic) NSString *model_id;
//@property (strong, nonatomic) NSString *chexingid;
@property (strong, nonatomic) NSString *model_year;
@property (strong, nonatomic) NSString *first_reg_year;
@property (strong, nonatomic) NSString *km_num;
//@property (strong, nonatomic) NSString *identity;
//@property (strong, nonatomic) User *user_b;
//@property (strong, nonatomic) NSString *reg_area_pname;
//@property (strong, nonatomic) NSString *reg_area_cname;
@property (strong, nonatomic) NSString *logo;
@property (strong, nonatomic) NSString *seller_price;
@property (strong, nonatomic) NSString *address;





/** 对应trade中的id */
@property (strong, nonatomic) NSString *trade_id;
/** 对应trade中的mode */
@property (strong, nonatomic) NSString *trade_mode;

@end
