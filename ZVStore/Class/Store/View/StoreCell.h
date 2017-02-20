//
//  StoreCell.h
//  ZVStore
//
//  Created by zivInfo on 17/2/20.
//  Copyright © 2017年 xiwangtech.com. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "StoreModel.h"
#import "UIImageView+WebCache.h"

@interface StoreCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *picImageView;
@property (nonatomic, strong) StoreModel *models;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
