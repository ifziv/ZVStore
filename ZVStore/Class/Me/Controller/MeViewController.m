//
//  MeViewController.m
//  ZVStore
//
//  Created by zivInfo on 17/2/16.
//  Copyright © 2017年 xiwangtech.com. All rights reserved.
//

#import "MeViewController.h"

@interface MeViewController ()

@end

@implementation MeViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setupTableView];
    [self setupSettingBtn];

}

#pragma mark - 界面初始化
// tableView
- (void)setupTableView
{
//    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.meTableView.delegate = self;
    self.meTableView.dataSource = self;
    self.meTableView.tableFooterView = [UIView new];
    [self.view addSubview:self.meTableView];
    
    
    self.topImageView = [[UIImageView alloc] initWithFrame:(CGRectMake(0, -HeadViewH, self.view.frame.size.width, HeadViewH))];
    _topImageView.image = [UIImage imageNamed:@"wishbg.jpg"];
    _topImageView.contentMode = UIViewContentModeScaleAspectFill;
    _topImageView.clipsToBounds = YES;
    [self.meTableView addSubview:self.topImageView];
    
    UIImageView *iconImage = [[UIImageView alloc] init];
    iconImage.image = [UIImage imageNamed:@""];
    self.iconImage = iconImage;
    [_topImageView addSubview:iconImage];
    [iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(_topImageView.mas_centerX);
        make.centerY.mas_equalTo(_topImageView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(kIconH, kIconH));
    }];
    
    UILabel *userLabel = [[UILabel alloc] init];
    userLabel.text = @"jeffery";
    userLabel.font = [UIFont systemFontOfSize:18.0];
    userLabel.textColor = [UIColor whiteColor];
    userLabel.textAlignment = NSTextAlignmentCenter;
    self.userLabel = userLabel;
    [_topImageView addSubview:userLabel];
    [userLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(iconImage.mas_bottom).offset(18);
        make.centerX.mas_equalTo(iconImage.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(100, 21));
    }];
    
    self.meTableView.contentInset = UIEdgeInsetsMake(HeadViewH, 0, 0, 0);
    
    //    UIBlurEffect *blur = [UIBlurEffect effectWithStyle:(UIBlurEffectStyleLight)];
    //    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:blur];
    //    effectView.frame = _topImageView.frame;
    //    _effectView = effectView;
    //    [self.tableView addSubview:_effectView];
    
    
    
}

- (void)setupSettingBtn
{
    UIButton *settingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [settingBtn setBackgroundImage:[UIImage imageNamed:@"mine_setting"] forState:UIControlStateNormal];
    //设置尺寸
    settingBtn.size = settingBtn.currentBackgroundImage.size;
    [self.view addSubview:settingBtn];
    
    [settingBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).offset(25);
        make.left.mas_equalTo(self.view).offset(15);
    }];
}


#pragma mark - TableView代理方法
// tableView数据源代理方法啊
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
    }
    
    if (indexPath.row == 0) {
        MeOrderCell *cell = [MeOrderCell cellWithTableView:tableView];
        [cell setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, MAXFLOAT)];
        return cell;
    } else if (indexPath.row == 1) {
        MeAccountCell *cell = [MeAccountCell cellWithTableView:tableView];
        
        return cell;
    } else if (indexPath.row == 2) {
        
        cell.textLabel.text = @"我的收藏";
    }
    else if (indexPath.row == 3) {
        
        cell.textLabel.text = @"我的活动";
    }
    else if (indexPath.row == 4) {
        
        cell.textLabel.text = @"邀请好友";
    }
    else if (indexPath.row == 5) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        cell.textLabel.text = @"联系客服(9:00-18:00)";
        cell.detailTextLabel.text = @"4006-277-717";
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    
    return cell;
    
    
}



// tableView代理方法啊
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 150;
    } else if (indexPath.row == 1) {
        return 150;
    } else  {
        return 44;
    }
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    // 向下的话 为负数
    CGFloat offY = scrollView.contentOffset.y;
    
    // 下拉超过照片的高度的时候
    if (offY < - HeadViewH)
    {
        CGRect frame = self.topImageView.frame;
        // 这里的思路就是改变 顶部的照片的 fram
        self.topImageView.frame = CGRectMake(0, offY, frame.size.width, -offY);
        //        self.effectView.frame = self.topImageView.frame;
        // 对应调整毛玻璃的效果
        //        self.effectView.alpha = 1 + (off_y + HeadViewH) / ScreenHeight ;
    }
    
    
    
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
