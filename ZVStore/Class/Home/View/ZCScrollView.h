//
//  ZCScrollView.h
//  ScrollViewTop
//
//  Created by zivInfo on 17/2/15.
//  Copyright © 2017年 xiwangtech.com. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UIImageView+WebCache.h"

typedef void (^TapImageViewBlock)(NSInteger curPage);

#define ZCDefalutImageName @"image_defalut.png"

@interface ZCScrollView : UIScrollView <UIScrollViewDelegate>


@property (nonatomic, strong) UIImageView *leftIV;
@property (nonatomic, strong) UIImageView *centerIV;
@property (nonatomic, strong) UIImageView *rightIV;

@property (nonatomic, strong) NSArray       *carouselArray;
@property (nonatomic, strong) UIPageControl *pageControl;

@property (nonatomic, strong) NSTimer   *timer;       //定时器用于滚动轮播图
@property (nonatomic, assign) NSInteger currentPage;  //当前页

@property (nonatomic, strong) TapImageViewBlock tapImageBlock; //Block返回当前点击的第几个Page

/**功能：初始化轮播数组
 * @param array 数据，存储的是字典类型。字典格式｛@“url”:value, @"url":value, @"url":value｝
 */
-(void)setZCScrollViewWithArray:(NSArray *)array;

/**功能：停止轮播定时器
 * @param 无
 * return void */
-(void)invalidateTimer;

/**功能：开启定时器
 * @param 无
 * return void
 */
-(void)fireTimer;

/**功能：Block返回当前点击的第几个Page
 * @param 无
 * return currentPage
 */
- (void)tapImageViewBlock:(TapImageViewBlock)tapImageBlock;


@end
