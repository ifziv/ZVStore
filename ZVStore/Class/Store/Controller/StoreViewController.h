//
//  StoreViewController.h
//  ZVStore
//
//  Created by zivInfo on 17/2/16.
//  Copyright © 2017年 xiwangtech.com. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ZCScrollView.h"
#import "UIImageView+WebCache.h"
#import "StoreTitleIconBtnModel.h"
#import "StoreModel.h"
#import "StoreTitleIconBtnView.h"
#import "StoreMenuView.h"
#import "StoreCell.h"

#define ScreenWidth  [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height

@interface StoreViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate, StoreMenuViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *storeTableView;
@property (nonatomic, strong) NSMutableArray *bannerArray;
@property (nonatomic, strong) NSMutableArray *menuArray;
@property (nonatomic, strong) NSMutableArray *storeCellArray;
@property (nonatomic, strong) NSDictionary *channelDict;


@end
