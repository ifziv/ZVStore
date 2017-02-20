//
//  BasketCell.m
//  ZVStore
//
//  Created by zivInfo on 17/2/20.
//  Copyright © 2017年 xiwangtech.com. All rights reserved.
//

#import "BasketCell.h"

@implementation BasketCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(allSelectClicked)];
    [self.selectmageView addGestureRecognizer:tap];

}

- (void)allSelectClicked
{
    NSLog(@"--------");
}

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"basketCell";
    
    BasketCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
        cell.selectionStyle =UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (void)setModel:(BasketModel *)model
{
    _model = model;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [self.picView sd_setImageWithURL:[NSURL URLWithString:model.goods_img]];
    });
    
    self.selectBtn.selected = model.selectBtn;
    self.nameLabel.text = model.goods_name;
    self.descLabel.text = model.goods_desc;
    self.priceLabel.text = [NSString stringWithFormat:@"￥%@",model.goods_price];
    self.numLabel.text = [NSString stringWithFormat:@"x%@",model.goods_num];
    
    if (self.selectBtn.selected) {
        [self.selectBtn setImage:[UIImage imageNamed:@"car_Select"] forState:UIControlStateSelected];
    }
    else {
        [self.selectBtn setImage:[UIImage imageNamed:@"car_noSelect"] forState:UIControlStateSelected];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)selectbtnAction:(UIButton *)sender {
    
    sender.selected = !sender.selected;

    if (sender.selected) {
        [self.selectBtn setImage:[UIImage imageNamed:@"car_Select"] forState:UIControlStateSelected];
    }
    else {
        [self.selectBtn setImage:[UIImage imageNamed:@"car_noSelect"] forState:UIControlStateSelected];
    }
    
    if ([self.delegate respondsToSelector:@selector(selectBasketCellClick:btn:)]) {
        [self.delegate selectBasketCellClick:self.indexPath btn:sender];
    }

}

@end
