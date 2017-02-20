//
//  ZCScrollView.m
//  ScrollViewTop
//
//  Created by zivInfo on 17/2/15.
//  Copyright © 2017年 xiwangtech.com. All rights reserved.
//

#import "ZCScrollView.h"

@implementation ZCScrollView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self creatUI];
    }
    
    return self;
}

-(void)drawRect:(CGRect)rect{
    
    CGSize size = CGSizeMake(CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
    self.leftIV.frame = CGRectMake(0, 0, size.width, size.height);
    self.centerIV.frame = CGRectMake(size.width, 0, size.width, size.height);
    self.rightIV.frame = CGRectMake(size.width * 2, 0, size.width, size.height);
    self.pageControl.frame = CGRectMake(0, size.height - 20, size.width, 20);
    [self setContentSize:CGSizeMake(size.width * 3, size.height)];
    [self setContentOffset:CGPointMake(size.width, 0)];
}

-(void)creatUI{
    self.pagingEnabled = YES;
    self.showsHorizontalScrollIndicator = NO;
    self.leftIV = [[UIImageView alloc] init];
    self.leftIV.image = [UIImage imageNamed:ZCDefalutImageName];
    [self addSubview:self.leftIV];
    
    self.centerIV = [[UIImageView alloc] init];
    self.centerIV.image = [UIImage imageNamed:ZCDefalutImageName];
    [self addSubview:self.centerIV];
    
    self.rightIV = [[UIImageView alloc] init];
    self.rightIV.image = [UIImage imageNamed:ZCDefalutImageName];
    [self addSubview:self.rightIV];
    
    self.delegate = self;
    
    UITapGestureRecognizer *TapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageViewTap:)];
    self.centerIV.userInteractionEnabled = YES;
    [self.centerIV addGestureRecognizer:TapGesture];
    
    
}

-(void)imageViewTap:(UITapGestureRecognizer *)tap{
    
    __weak typeof(self)WeakSelf = self;
    
    if (WeakSelf.tapImageBlock) {
        
        WeakSelf.tapImageBlock(_currentPage);
    }
    
}

-(void)tapImageViewBlock:(TapImageViewBlock)tapImageBlock{
    
    self.tapImageBlock = tapImageBlock;
    
}

/*功能：初始化轮播数组
 * @param array 数据，存储的是字典类型。字典格式｛@“url”:value, @"url":value, @"url":value｝
 */
-(void)setZCScrollViewWithArray:(NSArray *)array{
    if (array.count == 0) {
        return;
    }
    self.carouselArray = array;
    self.currentPage = 0;
    self.pageControl.numberOfPages = array.count;
    [self updateScrollViewAndImage];
    
    [self fireTimer];
}


-(UIPageControl *)pageControl{
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] init];
        _pageControl.currentPageIndicatorTintColor = [UIColor colorWithRed:245.0/255 green:98.0/255 blue:45.0/255 alpha:1.0];
        _pageControl.pageIndicatorTintColor = [UIColor whiteColor];
        [self.superview addSubview:_pageControl];
    }
    
    return _pageControl;
}


//定时器自动轮播
-(void)animalImage{
    [UIView animateWithDuration:0.3 animations:^{
        [self setContentOffset:CGPointMake(CGRectGetWidth(self.frame) * 2, 0)];
    } completion:^(BOOL finished) {
        if (finished) {
            [self updateCurrentPageWithDirector:NO];
            [self updateScrollViewAndImage];
        }
    }];
    
    
}


//滚动后更新scrollView的位置和显示的图片
-(void)updateScrollViewAndImage
{
    [self setContentOffset:CGPointMake(CGRectGetWidth(self.frame), 0)];
    
    NSInteger pageCount = self.carouselArray.count;
    if (pageCount == 0) {
        return;
    }
    
    NSInteger leftIndex = (_currentPage > 0) ? (_currentPage - 1) : (pageCount - 1);
    NSInteger rightIndex = (_currentPage < pageCount - 1) ? (_currentPage + 1) : 0;
    
    NSDictionary *leftDic = self.carouselArray[leftIndex];
    NSDictionary *centerDic = self.carouselArray[_currentPage];
    NSDictionary *rightDic = self.carouselArray[rightIndex];
    
    NSString *leftString = [leftDic objectForKey:@"url"];
    NSString *centerString = [centerDic objectForKey:@"url"];
    NSString *rightString = [rightDic objectForKey:@"url"];
    
    [self.leftIV sd_setImageWithURL:[NSURL URLWithString:leftString]
                   placeholderImage:[UIImage imageNamed:ZCDefalutImageName]];
    [self.centerIV sd_setImageWithURL:[NSURL URLWithString:centerString]
                     placeholderImage:[UIImage imageNamed:ZCDefalutImageName]];
    [self.rightIV sd_setImageWithURL:[NSURL URLWithString:rightString]
                    placeholderImage:[UIImage imageNamed:ZCDefalutImageName]];
    
    [self.pageControl setCurrentPage:_currentPage];
    
}


-(void)updateCurrentPageWithDirector:(BOOL) isRight{
    NSInteger pageCount = self.carouselArray.count;
    if (pageCount == 0) {
        return;
    }
    if (isRight) {
        self.currentPage = self.currentPage > 0 ? (self.currentPage - 1) : (pageCount - 1);
    }else{
        self.currentPage = (self.currentPage + 1) % pageCount;
    }
}


#pragma mark UIScrollerViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
    [self.timer setFireDate:[NSDate dateWithTimeIntervalSinceNow:5.0]];
    if (self.contentOffset.x == 0)
    {
        [self updateCurrentPageWithDirector:YES];
    }
    else if (self.contentOffset.x > CGRectGetWidth(scrollView.frame))
    {
        [self updateCurrentPageWithDirector:NO];
        
    }else{
        return;
    }
    [self updateScrollViewAndImage];
    
}


#pragma mark 定时器处理
- (void)dealloc
{
    [self invalidateTimer];
}


//取消定时器
-(void)invalidateTimer
{
    if (_timer && [_timer isValid]) {
        [_timer invalidate];
        _timer = nil;
    }
}

-(void)fireTimer{
    [self invalidateTimer];
    //如果有图片才开启定时器
    if (self.carouselArray.count > 0) {
        self.timer = [NSTimer scheduledTimerWithTimeInterval:5.0f target:self selector:@selector(animalImage) userInfo:nil repeats:YES];
    }
    
}



@end
