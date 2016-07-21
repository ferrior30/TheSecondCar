//
//  CWHeadView.h
//  TheSecondCar
//
//  Created by ChenWei on 16/6/24.
//  Copyright © 2016年 cw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CWInfiniteScrollView.h"

@interface CWHeadView : UIView
@property (strong, nonatomic) NSArray<UIImage *> *images;
@property (weak, nonatomic) CWInfiniteScrollView *scrollView;
@property (weak, nonatomic) UIButton *positonButton;
@property (weak, nonatomic) UIButton *sellButton;
@end
