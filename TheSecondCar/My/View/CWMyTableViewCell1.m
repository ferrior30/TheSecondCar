//
//  CWMyTableViewCell1.m
//  TheSecondCar
//
//  Created by ChenWei on 16/7/26.
//  Copyright © 2016年 cw. All rights reserved.
//

#import "CWMyTableViewCell1.h"

@interface CWMyTableViewCell1 ()


@end

@implementation CWMyTableViewCell1

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setFrame:(CGRect)frame {
    frame.size.height -= 1;
    
    [super setFrame:frame];
}
@end
