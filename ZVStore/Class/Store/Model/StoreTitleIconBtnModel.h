//
//  StoreTitleIconBtnModel.h
//  ZVStore
//
//  Created by zivInfo on 17/2/20.
//  Copyright © 2017年 xiwangtech.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface StoreTitleIconBtnModel : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) NSString *icon;
@property (nonatomic, strong) UIViewController *controller;
@property (nonatomic, assign) NSInteger tag;

+ (instancetype)titleIconWith:(NSString *)title icon:(NSString *)image controller:(UIViewController *)controlller tag:(NSInteger )tag;

@end
