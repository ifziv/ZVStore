//
//  MeViewController.h
//  ZVStore
//
//  Created by zivInfo on 17/2/16.
//  Copyright © 2017年 xiwangtech.com. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UIImageView+WebCache.h"
#import "MeOrderCell.h"
#import "MeAccountCell.h"
#import "UIView+UIViewCategory.h"

#define HeadViewH 150
#define HeadViewMinH 64

#define kIconW 60
#define kIconH 60

@interface MeViewController : UIViewController <UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *meTableView;
@property (nonatomic, weak) UIImageView *iconImage;
// 顶部的照片
@property (nonatomic, strong) UIImageView *topImageView;
// 毛玻璃
@property (nonatomic, strong) UIVisualEffectView *effectView;

@property (nonatomic, weak) UILabel *userLabel;

@end
