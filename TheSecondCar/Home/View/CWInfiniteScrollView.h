//
//  CWInfiniteScrollView.h
//
//  Copyright (c) 2015年 CW. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CWInfiniteScrollView : UIView
@property (strong, nonatomic) NSArray<UIImage *> *images;
@property (weak, nonatomic, readonly) UIPageControl *pageControl;
@property (assign, nonatomic, getter=isScrollDirectionPortrait) BOOL scrollDirectionPortrait;
@end
