//
//  BasketCell.h
//  ZVStore
//
//  Created by zivInfo on 17/2/20.
//  Copyright © 2017年 xiwangtech.com. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BasketModel.h"
#import "UIImageView+WebCache.h"

@protocol BasketCellDelegate <NSObject>

- (void)selectBasketCellClick:(NSIndexPath *)indexPath btn:(UIButton *)btn;

@end

@interface BasketCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *selectmageView;
@property (weak, nonatomic) IBOutlet UIButton *selectBtn;
@property (weak, nonatomic) IBOutlet UIImageView *picView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *numLabel;

@property (strong, nonatomic) NSIndexPath *indexPath;
@property (nonatomic, strong) BasketModel *model;
@property (nonatomic, weak) id<BasketCellDelegate> delegate;


- (IBAction)selectbtnAction:(UIButton *)sender;

+ (instancetype)cellWithTableView:(UITableView *)tableView;



@end
