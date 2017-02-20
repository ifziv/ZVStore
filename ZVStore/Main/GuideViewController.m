//
//  GuideViewController.m
//  ZVStore
//
//  Created by zivInfo on 17/2/16.
//  Copyright © 2017年 xiwangtech.com. All rights reserved.
//

#import "GuideViewController.h"

@implementation GuideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIScrollView *scroll = [[UIScrollView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    scroll.contentSize = CGSizeMake(GuideScreenWidth * 5, GuideScreenHeight);
    scroll.bounces = NO;
    scroll.showsHorizontalScrollIndicator = NO;
    scroll.pagingEnabled = YES;
    scroll.delegate = self;
    [self.view addSubview:scroll];
    
    for (int i=0; i<5; i++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        NSString *name = [NSString stringWithFormat:@"bg_guide_6_%d",i+1];
        imageView.image = [UIImage imageNamed:name];
        imageView.frame = CGRectMake(GuideScreenWidth*i, 0, GuideScreenWidth, GuideScreenHeight);
        [scroll addSubview:imageView];
        if (i==4) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.backgroundColor = [UIColor clearColor];
            btn.frame = CGRectMake(GuideScreenWidth*i + 100, GuideScreenHeight * 0.75, GuideScreenWidth-200, GuideScreenHeight * 0.15);
            [btn addTarget:self action:@selector(startApp) forControlEvents:UIControlEventTouchUpInside];
            [scroll addSubview:btn];
        }
    }
    
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    pageControl.frame = CGRectMake(GuideScreenWidth * 0.42, GuideScreenHeight * 0.9, 100, 44);
    pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    pageControl.numberOfPages = 4;
    self.pageControl = pageControl;
    pageControl.currentPageIndicatorTintColor = [UIColor colorWithRed:211/255.0 green:192/255.0 blue:162/255.0 alpha:1.0];
    [self.view addSubview:pageControl];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    long page = scrollView.contentOffset.x / GuideScreenWidth;
    
    if (page == 4) {
        self.pageControl.hidden = YES;
    } else {
        self.pageControl.hidden = NO;
    }
    self.pageControl.currentPage = (NSInteger)page+0.5;
}

- (void)startApp
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    window.rootViewController = [[TabBarViewController alloc] init];
}


@end
