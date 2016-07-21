//
//  CWShowImageViewController.h
//  TheSecondCar
//
//  Created by ChenWei on 16/7/19.
//  Copyright © 2016年 cw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CWCarInfo.h"

@interface CWShowImageViewController : UIViewController
@property (strong, nonatomic) CWCarInfo *carInfo;
/**
 *  创建一个可以滚动显示图片详细的控制器
 */
- (instancetype)initWith:(CWCarInfo *)carInfo selectedImageViewIndex:(NSInteger)selectedImageViewIndex;
@end
