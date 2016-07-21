//
//  CWShowImageViewController.m
//  TheSecondCar
//
//  Created by ChenWei on 16/7/19.
//  Copyright © 2016年 cw. All rights reserved.
//

#import "CWShowImageViewController.h"

@import SDWebImage;
@import MBProgressHUD;
@import Masonry;

@interface CWShowImageViewController ()<UIScrollViewDelegate>

@property (weak, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) NSMutableArray<UIImageView *> *imageViews;


/** 当前显示的图片索引 */
@property (assign, nonatomic) NSInteger selectedImageViewIndex;
@property (weak, nonatomic) UILabel *pageLabel;
@end

@implementation CWShowImageViewController

- (instancetype)initWith:(CWCarInfo *)carInfo selectedImageViewIndex:(NSInteger)selectedImageViewIndex; {
    if (self == [super init]) {
        self.carInfo = carInfo;
        self.selectedImageViewIndex = selectedImageViewIndex;
        
        // 1.添加scrollView
        UIScrollView *scrollView = [[UIScrollView alloc] init];
        scrollView.backgroundColor = [UIColor whiteColor];
        scrollView.pagingEnabled = YES;
        scrollView.frame = CGRectMake(self.view.center.x - [UIScreen mainScreen].bounds.size.width * 0.5, self.view.center.y - carInfo.imageHeight * 0.5, [UIScreen mainScreen].bounds.size.width, carInfo.imageHeight);
        [self.view addSubview:scrollView];
        self.scrollView = scrollView;
        self.scrollView.contentSize = CGSizeMake(self.view.bounds.size.width * carInfo.images.count, 0);
        self.scrollView.contentOffset = CGPointMake(self.view.bounds.size.width * selectedImageViewIndex, 0);
        
        scrollView.delegate = self;
        scrollView.maximumZoomScale = 2.0;
        scrollView.minimumZoomScale = 1.0;
        
        // 1.1 给scrollView 添加iamgeViews
        NSMutableArray *imageViews = [NSMutableArray array];
        
        for (int i = 0; i < carInfo.images.count; i++) {
            UIImageView *imageV = [[UIImageView alloc] init];
            CGRect rect = self.scrollView.bounds;
            rect.origin.x = self.view.bounds.size.width * i;
            rect.origin.y = 0;
            imageV.frame = rect;
            
            [self.scrollView addSubview:imageV];
            [imageViews addObject:imageV];
        }
        self.imageViews = imageViews;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
     self.view.backgroundColor = [UIColor blackColor];
    
    // 页码Label
    UILabel *pageLabel = [[UILabel alloc] init];
    self.pageLabel = pageLabel;
    pageLabel.textColor = [UIColor whiteColor];
    pageLabel.text = [NSString stringWithFormat:@"%zd / %zd", self.selectedImageViewIndex, self.imageViews.count];
    [pageLabel sizeToFit];
    [self.view addSubview:pageLabel];

    [pageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_bottom).mas_offset(-20);
    }];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.imageViews[self.selectedImageViewIndex] sd_setImageWithURL:[NSURL URLWithString:self.carInfo.images[self.selectedImageViewIndex]] placeholderImage:[UIImage imageNamed:@"iconDefaultImage"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.imageViews[self.selectedImageViewIndex].image = image;
    }];
     self.pageLabel.text = [NSString stringWithFormat:@"%zd / %zd", self.selectedImageViewIndex + 1, self.imageViews.count];
}

#pragma mark - UIScrollViewdelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGPoint offset = scrollView.contentOffset;
    
    NSInteger index = (NSInteger)(offset.x / self.scrollView.bounds.size.width);
    
    self.selectedImageViewIndex = index;
    
    [MBProgressHUD showHUDAddedTo:self.imageViews[index] animated:YES];
    [self.imageViews[index] sd_setImageWithURL:[NSURL URLWithString:self.carInfo.images[index]] placeholderImage:[UIImage imageNamed:@"iconDefaultImage"]  completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.pageLabel.text = [NSString stringWithFormat:@"%zd / %zd", self.selectedImageViewIndex + 1, self.imageViews.count];

        if (image != nil) { // 图片下载成功
            self.imageViews[index].image = image;
            [MBProgressHUD hideHUDForView:self.imageViews[index] animated:NO];
        }else {  // 图片下载失败
            MBProgressHUD *hud = [MBProgressHUD allHUDsForView:self.view].firstObject;
            hud.mode = MBProgressHUDModeText;
            hud.labelText = @"加载失败";
            [hud hide:NO];
        }
    }];
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.imageViews[self.selectedImageViewIndex];
}

//- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
//    self.imageViews[self.selectedImageViewIndex].ce
//}

//- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (void)dealloc {
    NSLog(@"%s", __func__);
}

@end
