//
//  VideoCell.m
//  ZVStore
//
//  Created by zivInfo on 17/2/17.
//  Copyright © 2017年 xiwangtech.com. All rights reserved.
//

#import "VideoCell.h"

@implementation VideoCell

- (void)awakeFromNib {
    // Initialization code
}

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"videoCell";
    
    VideoCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
        cell.selectionStyle =UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (IBAction)playBtnAction:(UIButton *)sender {
}

- (void)setModel:(VideoModel *)model
{
    _model = model;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [self.backImageView sd_setImageWithURL:[NSURL URLWithString:model.article_image]];
    });
    self.timeLabel.text = model.video_length;
    self.titleLabel.text = model.article_title;
    self.descLabel.text = model.article_abstract;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
