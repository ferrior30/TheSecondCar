//
//  CWWebView.h
//  TheSecondCar
//
//  Created by ChenWei on 16/7/26.
//  Copyright © 2016年 cw. All rights reserved.
//

#import <WebKit/WebKit.h>

@interface CWWebView : WKWebView
@property (weak, nonatomic) UIProgressView *progressView;
@end
