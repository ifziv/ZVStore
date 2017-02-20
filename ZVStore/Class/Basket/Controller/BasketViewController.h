//
//  BasketViewController.h
//  ZVStore
//
//  Created by zivInfo on 17/2/16.
//  Copyright © 2017年 xiwangtech.com. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BasketCell.h"
#import "BasketModel.h"
#import "Masonry.h"

#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define RGB(r,g,b) RGBA(r,g,b,1.0f)
#define ThemeColor RGB(230, 198, 168)

@interface BasketViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, BasketCellDelegate>

@property (weak, nonatomic) IBOutlet UITableView *basketTableView;

@property (nonatomic, strong) NSMutableArray *goodsArray;
@property(nonatomic,strong)UIRefreshControl *rfcontrol;
@property (nonatomic, weak) UIButton *selImage;
@property (nonatomic, weak) UILabel *totalPrice;
@property (nonatomic, weak) UIButton *selectBtn ;

@property (nonatomic, assign) BOOL flag;

@end
