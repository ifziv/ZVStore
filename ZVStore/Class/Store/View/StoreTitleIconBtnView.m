//
//  StoreTitleIconBtnView.m
//  ZVStore
//
//  Created by zivInfo on 17/2/20.
//  Copyright © 2017年 xiwangtech.com. All rights reserved.
//

#import "StoreTitleIconBtnView.h"

@implementation StoreTitleIconBtnView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.font = [UIFont systemFontOfSize:15];
        [self addSubview:_titleLabel];
        
        _icon = [[UIImageView alloc]init];
        //        _icon.contentMode = UIViewContentModeCenter;
        [self addSubview:_icon];
        
        [_icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.centerY.equalTo(self).offset(-10);
            make.size.mas_equalTo(CGSizeMake(30, 30));
        }];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_icon.mas_bottom).offset(8);
            make.leading.trailing.equalTo(self);
            make.height.mas_equalTo(19);
        }];
    }
    
    return  self;
}

- (instancetype)initWithTitleLabel:(NSString *)titleLabel icon:(NSString *)icon boder:(BOOL)boder
{
    if (self = [super init]) {
        if (boder) {
            //            self.layer.borderColor = GrayColor.CGColor;
            //            self.layer.borderWidth = 0.5;
        }
        self.titleLabel.text = titleLabel;
        [self.icon sd_setImageWithURL:[NSURL URLWithString:icon] placeholderImage:nil];
        
    }
    return self;
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
