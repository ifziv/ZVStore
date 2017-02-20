//
//  VideoCell.h
//  ZVStore
//
//  Created by zivInfo on 17/2/17.
//  Copyright © 2017年 xiwangtech.com. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "VideoModel.h"
#import "UIImageView+WebCache.h"

@interface VideoCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UIImageView *backImageView;
@property (weak, nonatomic) IBOutlet UIView *coverView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@property (weak, nonatomic) IBOutlet UIButton *playBtn;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (nonatomic, strong) VideoModel *model;

+ (instancetype)cellWithTableView:(UITableView *)tableView;
- (IBAction)playBtnAction:(UIButton *)sender;

@end
