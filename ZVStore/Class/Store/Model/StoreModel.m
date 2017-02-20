//
//  StoreModel.m
//  ZVStore
//
//  Created by zivInfo on 17/2/20.
//  Copyright © 2017年 xiwangtech.com. All rights reserved.
//

#import "StoreModel.h"

@implementation StoreModel

+ (instancetype)initWithDic:(NSDictionary *)dict
{
    StoreModel *model = [[self alloc] init];
    [model setValuesForKeysWithDictionary:dict];
    return model;
    
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

@end
