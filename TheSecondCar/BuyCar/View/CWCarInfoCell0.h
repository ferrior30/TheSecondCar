//
//  CWCarInfoCell0.h
//  TheSecondCar
//
//  Created by ChenWei on 16/7/11.
//  Copyright © 2016年 cw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CWCarInfo.h"
@class CWBuyScrollView;

@protocol CWCarInfoCell0ImageViewDidClickDelegate <NSObject>

- (void)carInfoCell0ImageViewDidClick:(NSInteger)selectedImageViewIndex;

@end

@interface CWCarInfoCell0 : UITableViewCell
@property (weak, nonatomic) IBOutlet CWBuyScrollView *scrollView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *scrollViewHeightConstraint;

@property (weak, nonatomic) IBOutlet UIImageView *iconCheMao;
@property (strong, nonatomic) CWCarInfo *carInfo;

//@property (weak, nonatomic) IBOutlet UIImageView *imageV;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;


@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

@property (weak, nonatomic) IBOutlet UILabel *xinChePrice;
/** 区域：例如武汉 */
@property (weak, nonatomic) IBOutlet UILabel *regionLabel;

/** 车辆迁移信息： （例如：上海不可迁） */
@property (weak, nonatomic) IBOutlet UILabel *migrateLabel;

/**
 *  当图片被点击时显示详情界面的标记
 *  YES: 显示 NO: 不显示。
 */
@property (weak, nonatomic) id<CWCarInfoCell0ImageViewDidClickDelegate> delegate;


@end
