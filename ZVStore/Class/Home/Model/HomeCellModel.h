//
//  HomeCellModel.h
//  ZVStore
//
//  Created by zivInfo on 17/2/16.
//  Copyright © 2017年 xiwangtech.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomeCellModel : NSObject

@property (nonatomic, strong) NSString *relation_object_image;
@property (nonatomic, strong) NSString *relation_object_title;
@property (nonatomic, strong) NSString *relation_object_jingle;
@property (nonatomic, strong) NSString *goods_price;

+ (instancetype)initWithDic:(NSDictionary *)dict;

@end
