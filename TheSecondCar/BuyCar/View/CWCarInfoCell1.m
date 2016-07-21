//
//  CWCarInfoCell1.m
//  TheSecondCar
//
//  Created by ChenWei on 16/7/12.
//  Copyright © 2016年 cw. All rights reserved.
//

#import "CWCarInfoCell1.h"

@interface CWCarInfoCell1 ()
/** 车商名称 */
@property (weak, nonatomic) IBOutlet UILabel *cheShangName;
/** 车商地址 */
@property (weak, nonatomic) IBOutlet UILabel *cheShangAddress;
@property (weak, nonatomic) IBOutlet UIView *cheShangNameView;

@end

@implementation CWCarInfoCell1

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
}

//- (void)tap {
//    UITabBarController *tab = (UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
//    UINavigationController *nav = (UINavigationController *)tab.selectedViewController;
//    nav.topViewController.navigationItem.backBarButtonItem.title = @"返回";
//    
//    UIViewController *v = [[UIViewController alloc] init];
//    
//    v.view.backgroundColor = [UIColor redColor];
//    [nav pushViewController:v animated:YES];
//    
//    v.navigationItem.backBarButtonItem.title = @"返回";
//    v.navigationController.navigationItem.backBarButtonItem.title = @"返回";
//}

////- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
//////    [super setSelected:selected animated:animated];
////
////    // Configure the view for the selected state
////}
//- (void)setHighlighted:(BOOL)highlighted {
//
//}

- (void)setCarInfo:(CWCarInfo *)carInfo {
    _carInfo = carInfo;
    
    self.cheShangName.text = carInfo.cheShangName;
    self.cheShangAddress.text = carInfo.cheShangAddress;
}

@end
