//
//  StoreTitleIconBtnModel.m
//  ZVStore
//
//  Created by zivInfo on 17/2/20.
//  Copyright © 2017年 xiwangtech.com. All rights reserved.
//

#import "StoreTitleIconBtnModel.h"

@implementation StoreTitleIconBtnModel

+ (instancetype)titleIconWith:(NSString *)title icon:(NSString *)image controller:(UIViewController *)controlller tag:(NSInteger )tag{
    StoreTitleIconBtnModel *titleIconAction = [[StoreTitleIconBtnModel alloc]init];
    titleIconAction.title = title;
    titleIconAction.icon = image;
    titleIconAction.controller = controlller;
    titleIconAction.tag = tag;
    return titleIconAction;
}

@end
