//
//  SpecialViewController.h
//  ZVStore
//
//  Created by zivInfo on 17/2/16.
//  Copyright © 2017年 xiwangtech.com. All rights reserved.
//
//  专题页
//

#import <UIKit/UIKit.h>

#import "UIView+UIViewCategory.h"

#import "VideoViewController.h"
#import "ListTopViewController.h"
#import "KnowledgeViewController.h"
#import "PeopleViewController.h"
#import "MapViewController.h"
#import "ActivityViewController.h"

#define RGBA [UIColor colorWithRed:230/255.0f green:198/255.0f blue:168/255.0f alpha:1.0]
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height

@interface SpecialViewController : UIViewController <UIScrollViewDelegate,UINavigationControllerDelegate>

/** 标签栏底部的红色指示器 */
@property (nonatomic, weak) UIView   *indicatorView;
/** 当前选中的按钮 */
@property (nonatomic, weak) UIButton *selectedButton;
/** 顶部的所有标签 */
@property (nonatomic, weak) UIView   *titlesView;
/** 底部的所有内容 */
@property (nonatomic, weak) UIScrollView *contentView;

@end
