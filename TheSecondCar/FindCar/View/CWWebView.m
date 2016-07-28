//
//  CWWebView.m
//  TheSecondCar
//
//  Created by ChenWei on 16/7/26.
//  Copyright © 2016年 cw. All rights reserved.
//

#import "CWWebView.h"

@interface CWWebView ()
//@property (weak, nonatomic) UIProgressView *progressView;
@end

@implementation CWWebView

- (instancetype)initWithFrame:(CGRect)frame configuration:(WKWebViewConfiguration *)configuration {
    if (self = [super initWithFrame:frame configuration:configuration]) {
        [self addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
        
        UIProgressView *progressView = [[UIProgressView alloc] init];
        progressView.trackTintColor = [UIColor whiteColor];
        progressView.progressTintColor = [UIColor blueColor];
        progressView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 2);
        [self.scrollView addSubview:progressView];
        self.progressView = progressView;
    }
    return self;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if (![keyPath  isEqual: @"estimatedProgress"]) {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
//    self.progressView.progress = [change[NSKeyValueChangeNewKey] floatValue];
    
    [self.progressView setAlpha:1.0f];
    [self.progressView setProgress:self.estimatedProgress animated:YES];
    
    if(self.estimatedProgress >= 1.0f) {
        
        [UIView animateWithDuration:0.3 delay:0.3 options:UIViewAnimationOptionCurveEaseOut animations:^{
            [self.progressView setAlpha:0.0f];
        } completion:^(BOOL finished) {
            [self.progressView setProgress:0.0f animated:NO];
        }];
    }
}

- (void)dealloc {
    [self removeObserver:self forKeyPath:@"estimatedProgress"];
}

@end
