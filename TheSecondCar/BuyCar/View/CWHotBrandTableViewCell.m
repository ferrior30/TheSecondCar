//
//  CWHotBrandTableViewCell.m
//  TheSecondCar
//
//  Created by ChenWei on 16/7/7.
//  Copyright © 2016年 cw. All rights reserved.
//

#import "CWHotBrandTableViewCell.h"
#import "CWHotBrandButton.h"

/** 屏幕尺寸 */
#define CWScreenW [UIScreen mainScreen].bounds.size.width

/** 最热品牌按钮选中通知 */
NSString * const CWHotBrandButtonDidClickedNotification = @"CWHotBrandButtonDidClickedNotification";
@interface CWHotBrandTableViewCell ()
/** 最热品牌数据 */
@property (strong, nonatomic) NSArray *carBrandHot;
@end

@implementation CWHotBrandTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        // 添加子控件
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    NSUInteger totalColumn = 5;
    CGFloat btnWH = (CWScreenW - 15) / totalColumn;
    CGFloat BtnX = 0;
    CGFloat btnY = 0;
    
    NSUInteger column = 0;
    NSUInteger row = 0;
    NSString *path = [[NSBundle mainBundle] pathForResource:@"CMBrandIcon.bundle" ofType:nil];
    NSBundle *bundle = [NSBundle bundleWithPath:path];
    for (int i = 0; i < 10; i++) {
        CWHotBrandButton *btn = [[CWHotBrandButton alloc] init];
        btn.tag = i;
        
        NSString *imageNumber = self.carBrandHot[i][@"brand_id"];
        NSString *imageName = [NSString stringWithFormat:@"brand_%03zd@2x.png", imageNumber.integerValue];
        
        NSString *imagePath = [bundle pathForResource:imageName ofType:nil];
        
        [btn setImage:[UIImage imageWithContentsOfFile:imagePath] forState:UIControlStateNormal];
        
        [btn setTitle:self.carBrandHot[i][@"name"] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.titleLabel.textAlignment = NSTextAlignmentCenter;
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.contentView addSubview:btn];
        
        // 行和列
        row = i / totalColumn;
        column = i % totalColumn;
        
        // frame
        BtnX = column * btnWH;
        btnY = row *btnWH;
        
        btn.frame = CGRectMake(BtnX, btnY, btnWH, btnWH);
    }
}

- (void)btnClick:(CWHotBrandButton *)button {
    [[NSNotificationCenter defaultCenter] postNotificationName:CWHotBrandButtonDidClickedNotification object:nil userInfo:@{@"brand_id":self.carBrandHot[button.tag][@"brand_id"]}];
}

#pragma mark - 懒加载
- (NSArray *)carBrandHot {
    if (_carBrandHot == nil) {
        NSString *hotPath = [[NSBundle mainBundle] pathForResource:@"CarBrandHot.plist" ofType:nil];
        _carBrandHot = [NSArray arrayWithContentsOfFile:hotPath];
    }
    return _carBrandHot;
}

@end
