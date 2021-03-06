//
//  SpecialViewController.m
//  ZVStore
//
//  Created by zivInfo on 17/2/16.
//  Copyright © 2017年 xiwangtech.com. All rights reserved.
//

#import "SpecialViewController.h"

CGFloat const TitilesViewH = 44;

@interface SpecialViewController ()

@end

@implementation SpecialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setupChildViewController];
    
    [self setupTitleView];
    [self setupContentView];
    
}

- (void)setupChildViewController
{
    VideoViewController *videoViewController = [[VideoViewController alloc] init];
    videoViewController.title = @"视频";
    [self addChildViewController:videoViewController];
    
    ListTopViewController *listTopViewController = [[ListTopViewController alloc] init];
    listTopViewController.title = @"榜单";
    [self addChildViewController:listTopViewController];
    
    KnowledgeViewController *knowledgeViewController = [[KnowledgeViewController alloc] init];
    knowledgeViewController.title = @"知识";
    [self addChildViewController:knowledgeViewController];
    
    PeopleViewController *peopleViewController = [[PeopleViewController alloc] init];
    peopleViewController.title = @"人文";
    [self addChildViewController:peopleViewController];
    
    MapViewController *mapViewController = [[MapViewController alloc] init];
    mapViewController.title = @"地图";
    [self addChildViewController:mapViewController];
    
    ActivityViewController *activityViewController = [[ActivityViewController alloc] init];
    activityViewController.title = @"活动";
    [self addChildViewController:activityViewController];
    
}

- (void)setupTitleView
{
    //标签栏整体
    UIView *titlesView =  [[UIView alloc] init];
    titlesView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:1.0];
    titlesView.width = self.view.width;
    titlesView.height = TitilesViewH;
    titlesView.y = 64;
    self.titlesView = titlesView;
    [self.view addSubview:titlesView];
    
    //下面的指示器view
    UIView *indicatorView = [[UIView alloc] init];
    indicatorView.backgroundColor = RGBA;
    indicatorView.height = 2;
    indicatorView.tag = -1;
    indicatorView.y = titlesView.height - indicatorView.height;
    self.indicatorView = indicatorView;
    
    // 内部子视图空间
    CGFloat width = titlesView.width / self.childViewControllers.count;
    CGFloat height = titlesView.height + 2;
    for (NSInteger i = 0; i<self.childViewControllers.count; i++) {
        UIButton *button = [[UIButton alloc] init];
        button.tag = i;
        button.height = height;
        button.width = width;
        button.x = i * width;
        UIViewController *vc = self.childViewControllers[i];
        [button setTitleEdgeInsets:UIEdgeInsetsMake(5, 0, 0, 0)];
        [button setTitle:vc.title forState:UIControlStateNormal];
        [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [button setTitleColor:RGBA forState:UIControlStateDisabled];
        button.titleLabel.font = [UIFont boldSystemFontOfSize:15];
        [button addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
        [titlesView addSubview:button];
        
        
        // 默认点击了第一个按钮
        if (i == 0) {
            button.enabled = NO;
            self.selectedButton = button;
            
            // 让按钮内部的label根据文字内容来计算尺寸
            [button.titleLabel sizeToFit];
            self.indicatorView.width = width;
            self.indicatorView.centerX = button.centerX;
        }
    }
    
    //底部灰色背景
    UIView *indicatorBgView = [[UIView alloc] init];
    indicatorBgView.backgroundColor =  [UIColor colorWithRed:255/255.0f green:255/255.0f blue:255/255.0f alpha:1.0];
    indicatorBgView.width = self.view.width;
    indicatorBgView.height = 2;
    indicatorBgView.y = TitilesViewH - 2;
    [self.titlesView addSubview:indicatorBgView];
    
    
    [titlesView addSubview:indicatorView];
}


- (void)titleClick:(UIButton *)button
{
    // 修改按钮状态
    self.selectedButton.enabled = YES;
    button.enabled = NO;
    self.selectedButton = button;
    
    // 动画
    [UIView animateWithDuration:0.25 animations:^{
        self.indicatorView.width = ScreenWidth/self.childViewControllers.count;
        self.indicatorView.centerX = button.centerX;
    }];
    
    // 滚动
    CGPoint offset = self.contentView.contentOffset;
    offset.x = button.tag * self.contentView.width;
    [self.contentView setContentOffset:offset animated:YES];
}

/**
 * 底部的scrollView
 */
- (void)setupContentView
{
    // 不要自动调整inset
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIScrollView *contentView = [[UIScrollView alloc] init];
    contentView.backgroundColor = [UIColor whiteColor];
    contentView.frame = self.view.bounds;
    contentView.delegate = self;
    contentView.pagingEnabled = YES;
    [self.view insertSubview:contentView atIndex:0];
    contentView.contentSize = CGSizeMake(contentView.width * self.childViewControllers.count, 0);
    self.contentView = contentView;
    
    // 添加第一个控制器的view
    [self scrollViewDidEndScrollingAnimation:contentView];
}

#pragma mark - <UIScrollViewDelegate>
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    // 当前的索引
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    
    // 取出子控制器
    UIViewController *vc = self.childViewControllers[index];
    vc.view.x = scrollView.contentOffset.x;
    vc.view.y = 0; // 设置控制器view的y值为0(默认是20)
    vc.view.height = scrollView.height; // 设置控制器view的height值为整个屏幕的高度(默认是比屏幕高度少个20)
    [scrollView addSubview:vc.view];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollViewDidEndScrollingAnimation:scrollView];
    
    // 点击按钮
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    [self titleClick:self.titlesView.subviews[index]];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
