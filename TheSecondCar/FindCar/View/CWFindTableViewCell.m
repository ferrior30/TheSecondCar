//
//  CWFindTableViewCell.m
//  TheSecondCar
//
//  Created by ChenWei on 16/7/26.
//  Copyright © 2016年 cw. All rights reserved.
//

#import "CWFindTableViewCell.h"

@implementation CWFindTableViewCell

//- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
//    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
//        
//    }
//    return self;
//}

- (void)setFrame:(CGRect)frame {
    
    frame.size.height -= 1;
    
    [super setFrame:frame];
}

@end
