//
//  StoreTitleIconBtnView.h
//  ZVStore
//
//  Created by zivInfo on 17/2/20.
//  Copyright © 2017年 xiwangtech.com. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Masonry.h"
#import "UIImageView+WebCache.h"

@interface StoreTitleIconBtnView : UIView

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *icon;

- (instancetype)initWithTitleLabel:(NSString *)titleLabel icon:(NSString *)icon boder:(BOOL)boder;

@end
