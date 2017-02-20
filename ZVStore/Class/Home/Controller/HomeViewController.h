//
//  HomeViewController.h
//  ZVStore
//
//  Created by zivInfo on 17/2/16.
//  Copyright © 2017年 xiwangtech.com. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "HomeCellModel.h"
#import "HomeCell.h"
#import "ShopCell.h"
#import "ZCScrollView.h"
#import "HomeInfoViewController.h"

#define ScreenWidth  [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height

@interface HomeViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *homeTableView;
@property (nonatomic, weak) UIButton *upBtn;

@property (nonatomic, strong) NSString *infoString;
@property (nonatomic, strong) NSString *infoPicName;

@property (nonatomic, strong) NSMutableArray *tempArr;
@property (nonatomic, strong) NSMutableArray *homeCellArray;
@property (nonatomic, strong) NSMutableArray *rowHeightArr;  // 缓存cell高度

@property (strong, nonatomic) NSMutableDictionary *heights;  // 存放所有cell的高度


@end
