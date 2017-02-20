//
//  StoreCell.m
//  ZVStore
//
//  Created by zivInfo on 17/2/20.
//  Copyright © 2017年 xiwangtech.com. All rights reserved.
//

#import "StoreCell.h"

@implementation StoreCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"storeCell";
    StoreCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
    }
    return cell;
}


- (void)setModels:(StoreModel *)models
{
    _models = models;
    
    self.titleLabel.text = models.special_title;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        [self.picImageView sd_setImageWithURL:[NSURL URLWithString:models.special_image] placeholderImage:nil];
        dispatch_async(dispatch_get_main_queue(), ^{
            
        });
    });
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
