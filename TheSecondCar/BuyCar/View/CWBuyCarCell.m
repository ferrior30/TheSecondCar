//
//  CWBuyCarCell.m
//  TheSecondCar
//
//  Created by ChenWei on 16/7/5.
//  Copyright © 2016年 cw. All rights reserved.
//

#import "CWBuyCarCell.h"
#import "CWCar.h"

@import SDWebImage;

@interface CWBuyCarCell ()
@property (weak, nonatomic) IBOutlet UIImageView *logoImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *modeYearLabel;
@property (weak, nonatomic) IBOutlet UILabel *kmNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *sellerPriceLabel;

@property (weak, nonatomic) IBOutlet UILabel *address;
@end

@implementation CWBuyCarCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setCar:(CWCar *)car {
    _car = car;
    
    [self.logoImageView sd_setImageWithURL:[NSURL URLWithString:car.logo] placeholderImage:nil];
    
    self.nameLabel.text = car.name;
    
    if (car.model_year.length >0) {
        self.modeYearLabel.text =  [NSString stringWithFormat:@"%@年",car.model_year];
    }else self.modeYearLabel.text =  [NSString stringWithFormat:@"%@年",car.first_reg_year];
    
    self.kmNumLabel.text = car.km_num;
    
    self.sellerPriceLabel.text = car.seller_price;
    
    self.address.hidden = car.address.length <= 0;
}

@end
