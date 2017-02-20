//
//  BasketModel.h
//  ZVStore
//
//  Created by zivInfo on 17/2/20.
//  Copyright © 2017年 xiwangtech.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BasketModel : NSObject

@property (nonatomic, strong) NSString *goods_id;
@property (nonatomic, strong) NSString *goods_name;
@property (nonatomic, strong) NSString *goods_desc;
@property (nonatomic, strong) NSString *goods_price;
@property (nonatomic, strong) NSString *goods_img;
@property (nonatomic, strong) NSString *goods_num;

@property (nonatomic, assign) BOOL selectBtn;

+ (instancetype)initWithDic:(NSDictionary *)dict;

@end
