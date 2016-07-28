//
//  CWMyTableViewCell0.m
//  TheSecondCar
//
//  Created by ChenWei on 16/7/26.
//  Copyright © 2016年 cw. All rights reserved.
//

#import "CWMyTableViewCell0.h"

@implementation CWMyTableViewCell0

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setFrame:(CGRect)frame {
    frame.size.height -= 1;
    
    [super setFrame:frame];
}
@end
