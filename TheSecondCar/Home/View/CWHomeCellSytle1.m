//
//  CWHomeCellSytle1.m
//  TheSecondCar
//
//  Created by ChenWei on 16/6/24.
//  Copyright © 2016年 cw. All rights reserved.
//

#import "CWHomeCellSytle1.h"
#import "UIView+CWFrame.h"

/** 【快速通道】按钮高度 */
CGFloat const ButtonHeight = 50;
extern CGFloat const topBottomMargin;

@interface CWHomeCellSytle1 ()
@property (strong, nonatomic) NSMutableArray<NSString *> *priceTexts;
@end

@implementation CWHomeCellSytle1

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        // 添加子控件
//        [self setupUI];
//        self.contentView.backgroundColor = [UIColor lightGrayColor];
    }
    return self;
}

- (void)setupUI {
    // 1.价格按钮
    for (NSInteger i = 0; i < self.priceTexts.count; i++) {
        UIButton *priceButton = [[UIButton alloc] init];
        priceButton.backgroundColor = [UIColor whiteColor];
        priceButton.tag = i;
        [priceButton setTitle:self.priceTexts[i] forState:UIControlStateNormal];
        [priceButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        priceButton.layer.borderWidth = 0.5;
        priceButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
        [self.contentView addSubview:priceButton];
    }
    
    // 2.商标按钮
    // 2.1 加载bundle资源
    NSString *path = [[NSBundle mainBundle] pathForResource:@"CMBrandIcon.bundle" ofType:nil];
    NSBundle *bundle = [NSBundle bundleWithPath:path];
    [bundle load];
    
    for (NSInteger i = 0; i < self.brands.count; i++) {
        UIButton *brandButton = [[UIButton alloc] init];
         brandButton.backgroundColor = [UIColor whiteColor];
        brandButton.layer.borderWidth = 0.5;
        brandButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
        
        
        brandButton.tag = i;
//        NSString *imageName = [NSString stringWithFormat:@"/CMBrandIcon.bundle/brand_%03zd", self.brands[i]];
//        NSString *path = [NSBundle mainBundle] path
//        [NSBundle bundleWithPath:<#(nonnull NSString *)#>]
         NSString *imageName = [bundle pathForResource: [NSString stringWithFormat:@"brand_%03zd@2x.png",i+1] ofType:nil];

        [brandButton setImage:[UIImage imageWithContentsOfFile:imageName] forState:UIControlStateNormal];
        
        [self.contentView addSubview:brandButton];
    }
    
    // 3.更多品牌按钮
    UIButton *moreBrand = [[UIButton alloc] init];
    moreBrand.backgroundColor = [UIColor whiteColor];
    moreBrand.layer.borderWidth = 0.5;
    moreBrand.layer.borderColor = [UIColor lightGrayColor].CGColor;
    moreBrand.tag = self.contentView.subviews.count;
    [moreBrand setTitle:@"更多品牌" forState:UIControlStateNormal];
    [moreBrand setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.contentView addSubview:moreBrand];
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat btnWidth = self.contentView.width / 4;
    CGFloat btnHeight = ButtonHeight;
    CGFloat btnX = 0;
    CGFloat btnY = 0;
    for (int i = 0; i< self.contentView.subviews.count; i++) {
        NSUInteger row = i / 4;
        NSUInteger column = i % 4;
        
        btnX = column * btnWidth;
        btnY = row * btnHeight;
        
        self.contentView.subviews[i].frame = CGRectMake(btnX, btnY, btnWidth, btnHeight);
    }
}

//- (void)setBrands:(NSArray *)brands {
//    _brands = brands;
//}

- (void)setPrices:(NSArray *)prices {
    _prices = prices;
    
    // 价格按钮文字转换
    NSMutableArray<NSString *> *priceTexts = [NSMutableArray array];
    NSString *priceText = nil;
    for (NSString *text in prices) {
//        NSLog(@"text = %@", text);
        NSArray<NSString *> *strArr = [text componentsSeparatedByString:@","];
        NSString *begin = [strArr.firstObject substringFromIndex:1];
        NSString *end = [strArr.lastObject substringToIndex:strArr.lastObject.length - 1];
        if ([begin  isEqual: @""]) {
            priceText = [NSString stringWithFormat:@"%@万以上",end];
        }else if ([end isEqualToString:@""]) {
            priceText = [NSString stringWithFormat:@"%@万以下",begin];
        }else {
            priceText = [NSString stringWithFormat:@"%@-%@万", begin, end];
        }
        [priceTexts addObject:priceText];
    }
    
    self.priceTexts = priceTexts;
    
    [self setupUI];
    
    [self layoutIfNeeded];
}

// 设置cell间距
- (void)setFrame:(CGRect)frame {
   
    frame.size.height -= topBottomMargin;
    [super setFrame: frame];
}


@end
