//
//  MeAccountCell.h
//  ZVStore
//
//  Created by zivInfo on 17/2/20.
//  Copyright © 2017年 xiwangtech.com. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Masonry.h"

// 获取RGB颜色
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define RGB(r,g,b) RGBA(r,g,b,1.0f)
#define ThemeColor RGB(230, 198, 168)

#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height


@interface MeAccountCell : UITableViewCell

@property (nonatomic, strong) NSArray *numArr;
@property (nonatomic, strong) NSArray *textArr;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
