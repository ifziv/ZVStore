//
//  HomeCell.m
//  ZVStore
//
//  Created by zivInfo on 17/2/16.
//  Copyright © 2017年 xiwangtech.com. All rights reserved.
//

#import "HomeCell.h"

@implementation HomeCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"HomeCell";
    HomeCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
    }
    return cell;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
//    CGFloat sizes = [UIScreen mainScreen].bounds.size.width;
//    CGRect frame = self.frame;
//    frame.size.height = sizes;
//    self.frame = frame;
    
    self.loveBtn.layer.borderWidth = 0.5;
    self.loveBtn.layer.borderColor = [UIColor colorWithRed:211.0f/255.0f green:192.0f/255.0f blue:162.0f/255.0f alpha:1.0f].CGColor;
    self.loveBtn.layer.cornerRadius = 5.0;

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (CGFloat)cellHeight
{
    [self layoutIfNeeded];
    return CGRectGetMaxY(self.descLabel.frame);
}

- (IBAction)loveBtnAction:(UIButton *)sender
{
    NSLog(@"love Button");
}

- (void)setModel:(HomeCellModel *)model
{
    _model = model;
    
    [self.picImage sd_setImageWithURL:[NSURL URLWithString:model.relation_object_image]];
    self.nameLabel.text = model.relation_object_title;
    self.priceLabel.text = [NSString stringWithFormat:@"$ %@",model.goods_price];
    self.descLabel.text = model.relation_object_jingle;
}


@end
