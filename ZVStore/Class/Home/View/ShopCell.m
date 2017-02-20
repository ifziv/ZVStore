//
//  ShopCell.m
//  ZVStore
//
//  Created by zivInfo on 17/2/17.
//  Copyright © 2017年 xiwangtech.com. All rights reserved.
//

#import "ShopCell.h"

@implementation ShopCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.layer.borderWidth = 0.5;
    self.layer.borderColor = [UIColor colorWithRed:211.0f/255.0f green:192.0f/255.0f blue:162.0f/255.0f alpha:1.0].CGColor;
}

- (void)setPciName:(NSString *)pciName
{
    _pciName = pciName;
    self.imageView.image = [UIImage imageNamed:pciName];
}

- (void)setName:(NSString *)name
{
    _name = name;
    self.nameLabel.text = name;
}

- (void)setPrice:(NSString *)price
{
    _price = price;
    self.priceLabel.text = price;
}
@end
