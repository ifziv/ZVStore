//
//  VideoViewController.h
//  ZVStore
//
//  Created by zivInfo on 17/2/17.
//  Copyright © 2017年 xiwangtech.com. All rights reserved.
//
//  视频页
//

#import <UIKit/UIKit.h>

#import "WMPlayer.h"
#import "VideoModel.h"
#import "VideoCell.h"
#import "Masonry.h"
#import "UIView+UIViewCategory.h"

#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height

@interface VideoViewController : UIViewController <UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate,WMPlayerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *videoTableView;
@property (nonatomic, strong) NSMutableArray *videoModelArray;
@property (strong, nonatomic) NSMutableDictionary *heights;

@property (nonatomic, strong) WMPlayer    *wmPlayer;
@property (nonatomic, assign) NSIndexPath *currentIndexPath;
@property (nonatomic, retain) VideoCell   *currentCell;


@end
