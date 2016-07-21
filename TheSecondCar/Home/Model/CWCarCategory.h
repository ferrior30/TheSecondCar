//
//  CWCarCategory.h
//  TheSecondCar
//
//  Created by ChenWei on 16/6/30.
//  Copyright © 2016年 cw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CWCarCategory : NSObject
/** 
 "title": "SUV",
 "detail": "é«å¤§ä¸ï¼",
 "imageUrl": "http:\/\/img1.dongdalou.com\/cars\/201602291518106541.jpg",
 "condition": "{\"car_kind\":\"372\"}",
 "show": "1"
 */
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *detail;
@property (strong, nonatomic) NSString *imageUrl;
//@property (strong, nonatomic) NSDictionary *condition;
@property (strong, nonatomic) NSString *show;


/** size */
@property (assign, nonatomic)  CGSize size;

@end
