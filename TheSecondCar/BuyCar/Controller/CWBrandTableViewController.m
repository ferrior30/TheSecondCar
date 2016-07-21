//
//  CWBrandTableViewController.m
//  TheSecondCar
//
//  Created by ChenWei on 16/7/6.
//  Copyright © 2016年 cw. All rights reserved.
//

#import "CWBrandTableViewController.h"
#import "CWHotBrandTableViewCell.h"

@interface CWBrandTableViewController ()
@property (strong, nonatomic) NSArray *carBrand;
@property (strong, nonatomic) NSArray *carBrandHot;
@property (strong, nonatomic) NSBundle *brandIconBundle;
/** 字典数组： 字典中有存放有二个键：1:index -> 字符串 和 2: cars -> 数组 */
@property (strong, nonatomic) NSMutableArray *carArray;
/** tableView右边索引数组 */
@property (strong, nonatomic) NSMutableArray *rightIndexArray;
@end


@implementation CWBrandTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 加载品牌图片的bundle
    NSString *path = [[NSBundle mainBundle] pathForResource:@"CMBrandIcon.bundle" ofType:nil];
    NSBundle *bundle = [NSBundle bundleWithPath:path];
    self.brandIconBundle = bundle;
    
    [self loadCarBrand];
}



#pragma mark - Table view data source 数据源

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.carArray.count + 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0 || section == 1) {
        return 1;
    }else {
        NSArray *carsArr = self.carArray[section - 2][@"cars"];
        return carsArr.count;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return [UIScreen mainScreen].bounds.size.width / 5 * 2 + 10;
    }else if (indexPath.section == 1) {
        return 40;
    }else return 40;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return @"热门品牌";
    }else if (section == 1) {
        return @"#";
    }else return self.carArray[section - 2][@"index"];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        CWHotBrandTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"hotBrand"];
        if (cell == nil) {
            cell = [[CWHotBrandTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"hotBrand"];
        }
        return cell;
    }else if (indexPath.section == 1) {
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"derestrictBrand"];
        cell.textLabel.text = @"不限品牌";
        return cell;
    }else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Brand"];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Brand"];
        }
       
        // 1.字符串转NSInteger
        NSString *brandNumString = self.carArray[indexPath.section - 2][@"cars"][indexPath.row][@"brand_id"];
        NSInteger brandNum = brandNumString.integerValue;
        
        // 2.图片路径
        NSString *imageName = [NSString stringWithFormat:@"brand_%03zd@2x", brandNum];
        NSString *imagePath = [self.brandIconBundle pathForResource:imageName ofType:@"png"];
        
        // 3.设置图片和文字
        cell.imageView.image = [UIImage imageWithContentsOfFile:imagePath];
        cell.textLabel.text = self.carArray[indexPath.section - 2][@"cars"][indexPath.row][@"name"];
        
        return cell;
    }
}

- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    return self.rightIndexArray;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%s", __func__);
}

//- 

#pragma mark - 懒加载
- (NSArray *)carBrandHot {
    if (_carBrandHot == nil) {
        NSString *hotPath = [[NSBundle mainBundle] pathForResource:@"CarBrandHot.plist" ofType:nil];
        _carBrandHot = [NSArray arrayWithContentsOfFile:hotPath];
    }
    return _carBrandHot;
}

- (void)loadCarBrand {
    if (_carBrand == nil) {
        NSString *hotPath = [[NSBundle mainBundle] pathForResource:@"CarBrand.plist" ofType:nil];
        _carBrand = [NSArray arrayWithContentsOfFile:hotPath];
        
        // 将数组转化成字典数组（字典中有二个键值对：拼音索引和对应的car数组）
        NSMutableArray *carArr = [NSMutableArray array];
        self.rightIndexArray = [NSMutableArray arrayWithObjects:@"*", @"#", nil];
        for (NSDictionary *dict in _carBrand) {
            NSString *brand_py = dict[@"brand_py"];
            
            // 1.carArr为空时（第一次加入字典）
            if (carArr.count <= 0) {
                NSMutableDictionary *interdict = [NSMutableDictionary dictionary];
                [interdict setValue:brand_py forKey:@"index"];
                NSMutableArray *array = [NSMutableArray array];
                [array addObject:dict];
                [interdict setValue:array forKey:@"cars"];
                
                [carArr addObject:interdict];
                [self.rightIndexArray addObject:brand_py];
                continue;
            }
            
            // 2.carArr不为空时
            NSString *py = carArr.lastObject[@"index"];
            if ([py isEqualToString:brand_py]) { // 2.1拼音索引car数组已经存在
                [carArr.lastObject[@"cars"] addObject:dict];
            }else { // 2.2拼音索引car数组第一次出现
                NSMutableDictionary *interdict = [NSMutableDictionary dictionary];
                [interdict setValue:brand_py forKey:@"index"];
                NSMutableArray *array = [NSMutableArray array];
                [array addObject:dict];
                [interdict setValue:array forKey:@"cars"];
                
                [carArr addObject:interdict];
                
                // tableView右边索引数组添加拼音索引
                [self.rightIndexArray addObject:brand_py];
            }
            
        }
        self.carArray = carArr;
        [self.carArray writeToFile:@"/Users/cw/Desktop/cars.plist" atomically:YES];
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"%s", __func__);
}


@end
