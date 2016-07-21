//
//  CWCarInfoCell3.m
//  TheSecondCar
//
//  Created by ChenWei on 16/7/13.
//  Copyright © 2016年 cw. All rights reserved.
//

#import "CWCarInfoCell3.h"

@import SDWebImage;
@import Masonry;

@interface CWCarInfoCell3 ()
@property (weak, nonatomic) UIImageView *imageV;
@end

@implementation CWCarInfoCell3

//- (void)awakeFromNib {
//    [super awakeFromNib];
//    // Initialization code
//}
//
//- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
//    [super setSelected:selected animated:animated];
//
//    // Configure the view for the selected state
//}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UIImageView *imageV = [[UIImageView alloc] init];
        [self.contentView addSubview:imageV];
        self.imageV = imageV;
        
        [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView).insets(UIEdgeInsetsMake(5, 5, 0, 5));
        }];
    }
    return self;
}

@end
