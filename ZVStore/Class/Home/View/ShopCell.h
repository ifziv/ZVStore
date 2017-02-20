//
//  ShopCell.h
//  ZVStore
//
//  Created by zivInfo on 17/2/17.
//  Copyright © 2017年 xiwangtech.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShopCell : UICollectionViewCell

@property (nonatomic, strong) NSString *pciName;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *price;

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;


@end
