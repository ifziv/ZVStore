//
//  StoreModel.h
//  ZVStore
//
//  Created by zivInfo on 17/2/20.
//  Copyright © 2017年 xiwangtech.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StoreModel : NSObject

@property (nonatomic, strong) NSString *special_title;
@property (nonatomic, strong) NSString *special_image;

+ (instancetype)initWithDic:(NSDictionary *)dict;

@end
