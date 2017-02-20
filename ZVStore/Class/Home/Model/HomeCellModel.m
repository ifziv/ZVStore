//
//  HomeCellModel.m
//  ZVStore
//
//  Created by zivInfo on 17/2/16.
//  Copyright © 2017年 xiwangtech.com. All rights reserved.
//

#import "HomeCellModel.h"

@implementation HomeCellModel

+ (instancetype)initWithDic:(NSDictionary *)dict
{
    HomeCellModel *model = [[self alloc] init];
    [model setValuesForKeysWithDictionary:dict];
   
    return model;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}


@end
