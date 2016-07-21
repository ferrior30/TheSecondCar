//
//  CWCar.m
//  TheSecondCar
//
//  Created by ChenWei on 16/7/5.
//  Copyright © 2016年 cw. All rights reserved.
//

#import "CWCar.h"
@import MJExtension;

@implementation CWCar
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"address":@"user_b.address"};
}

- (void)setKm_num:(NSString *)km_num {
    if (km_num.integerValue == 0) {
        _km_num = @"0公里";
    }else {
        NSString *licheng = [NSString stringWithFormat:@"%02f", km_num.integerValue / 10000.0];
        NSInteger offset = licheng.length - 1;
        NSString *s = nil;
        while (offset)
            {
            s = [licheng substringWithRange:NSMakeRange(offset, 1)];
            if ([s isEqualToString:@"0"] || [s isEqualToString:@"."])
                {
                offset--;
                }
            else
                {
                break;
                }
            }
        _km_num = [NSString stringWithFormat:@"%@万公里",[licheng substringToIndex:offset+1]];
    }

}
- (void)setSeller_price:(NSString *)seller_price {
    if (seller_price.integerValue >= 10000) {
        _seller_price = [NSString stringWithFormat:@"%.2f万", seller_price.integerValue / 10000.0];
    }else _seller_price = [NSString stringWithFormat:@"%zd万", seller_price.integerValue];
}
@end
