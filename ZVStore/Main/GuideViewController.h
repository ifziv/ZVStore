//
//  GuideViewController.h
//  ZVStore
//
//  Created by zivInfo on 17/2/16.
//  Copyright © 2017年 xiwangtech.com. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "TabBarViewController.h"

#define GuideScreenWidth  [UIScreen mainScreen].bounds.size.width
#define GuideScreenHeight [UIScreen mainScreen].bounds.size.height

@interface GuideViewController : UIViewController <UIScrollViewDelegate>

@property (nonatomic, weak) UIPageControl *pageControl;

@end
