//
//  VideoModel.h
//  ZVStore
//
//  Created by zivInfo on 17/2/17.
//  Copyright © 2017年 xiwangtech.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VideoModel : NSObject

@property (nonatomic, strong) NSString *article_title;
@property (nonatomic, strong) NSString *article_video;
@property (nonatomic, strong) NSString *article_image;
@property (nonatomic, strong) NSString *article_abstract;
@property (nonatomic, strong) NSString *video_length;

+ (instancetype)initWithDic:(NSDictionary *)dict;

@end
