//
//  StoreMenuView.h
//  ZVStore
//
//  Created by zivInfo on 17/2/20.
//  Copyright © 2017年 xiwangtech.com. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "StoreTitleIconBtnModel.h"
#import "StoreTitleIconBtnView.h"

@protocol  StoreMenuViewDelegate<NSObject>

- (void)menuBtnClick;

@end


#define ScreenWidth [UIScreen mainScreen].bounds.size.width

@interface StoreMenuView : UIView

@property (nonatomic, weak) id<StoreMenuViewDelegate> delegate;
@property (nonatomic, strong) NSArray *menuArray;

- (instancetype)initMenu:(NSArray <StoreTitleIconBtnModel *> *)menuArray;

@end
