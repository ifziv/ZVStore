//
//  VideoModel.m
//  ZVStore
//
//  Created by zivInfo on 17/2/17.
//  Copyright © 2017年 xiwangtech.com. All rights reserved.
//

#import "VideoModel.h"

@implementation VideoModel

+ (instancetype)initWithDic:(NSDictionary *)dict
{
    VideoModel *model = [[self alloc] init];
    [model setValuesForKeysWithDictionary:dict];
    return model;
    
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

@end
