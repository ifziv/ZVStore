//
//  StoreMenuView.m
//  ZVStore
//
//  Created by zivInfo on 17/2/20.
//  Copyright © 2017年 xiwangtech.com. All rights reserved.
//

#import "StoreMenuView.h"

static const NSInteger DefaultRowNumbers = 4;

@implementation StoreMenuView

- (instancetype)initMenu:(NSArray<StoreTitleIconBtnModel *> *)menuArray
{
    if (self = [super init]) {
        self.backgroundColor = [UIColor whiteColor];
        self.menuArray = menuArray;
        for (StoreTitleIconBtnModel *title in menuArray) {
            StoreTitleIconBtnView * titleIconView = [[StoreTitleIconBtnView alloc] initWithTitleLabel:title.title icon:title.icon boder:NO];
            titleIconView.tag = title.tag;
            titleIconView.userInteractionEnabled = YES;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(titleIconViewClick)];
            [titleIconView addGestureRecognizer:tap];
            [self addSubview:titleIconView];
        }
    }
    return self;
}

- (void)titleIconViewClick
{
    if ([self.delegate respondsToSelector:@selector(menuBtnClick)]) {
        [self.delegate menuBtnClick];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat width = ScreenWidth / DefaultRowNumbers;
    //    CGFloat height = ScreenHeight / (self.menuArray.count / DefaultRowNumbers);
    CGFloat height = 90;
    NSLog(@"%f",height);
    for (int i = 0; i<self.subviews.count; i++) {
        StoreTitleIconBtnView *titleIconView = self.subviews[i];
        CGFloat viewX = (i % DefaultRowNumbers) *width;
        CGFloat viewY = (i / DefaultRowNumbers) * height;
        
        titleIconView.frame = CGRectMake(viewX, viewY, width, height);
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
