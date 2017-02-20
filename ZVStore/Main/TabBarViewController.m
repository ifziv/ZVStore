//
//  TabBarViewController.m
//  ZVStore
//
//  Created by zivInfo on 17/2/16.
//  Copyright © 2017年 xiwangtech.com. All rights reserved.
//

#import "TabBarViewController.h"

@implementation TabBarViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    HomeViewController *homeViewController = [[HomeViewController alloc] init];
    homeViewController.title = @"首页";
    [self addChildVC:homeViewController imageName:@"YS_index_nor" selectedImageName:@"YS_index_sel"];

    SpecialViewController *specialViewController = [[SpecialViewController alloc] init];
    specialViewController.title = @"专题";
    [self addChildVC:specialViewController imageName:@"YS_pro_nor" selectedImageName:@"YS_pro_sel"];
    
    StoreViewController *storeViewController = [[StoreViewController alloc] init];
    storeViewController.title = @"商店";
    [self addChildVC:storeViewController imageName:@"YS_shop_nor" selectedImageName:@"YS_shop_sel"];
    
    BasketViewController *basketViewController = [[BasketViewController alloc] init];
    basketViewController.title = @"购物篮";
    [self addChildVC:basketViewController imageName:@"YS_car_nor" selectedImageName:@"YS_car_sel"];
    
    MeViewController *meViewController = [[MeViewController alloc] init];
    meViewController.title = @"我的";
    [self addChildVC:meViewController imageName:@"YS_mine_nor" selectedImageName:@"YS_mine_sel"];

    TabBar *myTabBar = [[TabBar alloc] init];
    [self setValue:myTabBar forKey:@"tabBar"];
    
    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:211.0f/255.0f green:192.0f/255.0f blue:162.0f/255.0f alpha:1.0f]];

}

- (void)addChildVC:(UIViewController *)childVc imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName
{
    // 设置图标
    childVc.tabBarItem.image = [UIImage imageNamed:imageName];
    
    //设置文字样式
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = [UIColor colorWithRed:168.0f/255.0f green:168.0f/255.0f blue:168.0f/255.0f alpha:1.0f];
    [childVc.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    
    // 设置tabBarItem的选中文字颜色
    NSMutableDictionary *selectedTextAttrs = [NSMutableDictionary dictionary];
    selectedTextAttrs[NSForegroundColorAttributeName] = [UIColor colorWithRed:211.0f/255.0f green:192.0f/255.0f blue:162.0f/255.0f alpha:1.0f];
    [childVc.tabBarItem setTitleTextAttributes:selectedTextAttrs forState:UIControlStateSelected];
    
    childVc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    // 添加为tabbar控制器的子控制器
    NavigationViewController *nav = [[NavigationViewController alloc] initWithRootViewController:childVc];
    
    [self addChildViewController:nav];
}


@end
