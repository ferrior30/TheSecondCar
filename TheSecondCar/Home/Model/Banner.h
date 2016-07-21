//
//  Banner.h
//  TheSecondCar
//
//  Created by ChenWei on 16/6/25.
//  Copyright © 2016年 cw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Banner : NSObject
/** 
 "banner":[
 {
 "id":"111",
 "name":"æååä½",
 "url":"http://m.chemao.com.cn/zhaoshang.html",
 "position":"101",
 "image_url":"fc_advertises_201606031737184208.jpg",
 "image_path":"http://img.dongdalou.com/advertises/fc_advertises_201606031737184208.jpg"
 },
 */
@property (strong, nonatomic) NSString *id;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *url;
@property (strong, nonatomic) NSString *position;
@property (strong, nonatomic) NSString *image_url;
@property (strong, nonatomic) NSString *image_path;

@end
