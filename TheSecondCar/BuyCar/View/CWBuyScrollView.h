//
//  CWBuyScrollView.h
//  TheSecondCar
//
//  Created by ChenWei on 16/7/12.
//  Copyright © 2016年 cw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CWCarInfo.h"

@interface CWBuyScrollView : UIScrollView
@property (strong, nonatomic) CWCarInfo *carInfo;
@property (strong, nonatomic) NSMutableArray<UIImageView *> *imageViews;
@property (weak, nonatomic)  UIView *brandIdView;

/** 编号 */
@property (weak, nonatomic)  UILabel *carIdLabel;

/** 显示当前image index的label */
@property (weak, nonatomic)  UILabel *currentImageIndex;
/** 显示总图片数量的label。例如总共有9张 ：显示 /9 */
@property (weak, nonatomic)  UILabel *totalImageIndex;

/** 当前显示的图片索引 */
@property (assign, nonatomic) NSInteger currentIndex;

@end
