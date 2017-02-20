//
//  StoreViewController.m
//  ZVStore
//
//  Created by zivInfo on 17/2/16.
//  Copyright © 2017年 xiwangtech.com. All rights reserved.
//

#import "StoreViewController.h"

@interface StoreViewController ()

@end

@implementation StoreViewController

- (NSDictionary *)channelDict
{
    if (!_channelDict) {
        _channelDict = [NSDictionary dictionary];
    }
    
    return _channelDict;
}

- (NSMutableArray *)menuArray
{
    if (!_menuArray) {
        _menuArray = [NSMutableArray array];
    }
    return _menuArray;
}

- (NSMutableArray *)storeCellArray
{
    if (!_storeCellArray) {
        _storeCellArray = [NSMutableArray array];
    }
    return _storeCellArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setupData];
    [self initTableView];
}

- (void)setupData
{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSString *path = [[NSBundle mainBundle] pathForResource:@"Store" ofType:@"json"];
        NSData *data = [NSData dataWithContentsOfFile:path];
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        
        NSDictionary *datas = [NSDictionary dictionary];
        datas = [json objectForKey:@"datas"];
        
        self.channelDict = [datas objectForKey:@"channel"];
        
        NSMutableArray *bannerArr = [NSMutableArray array];
        bannerArr = [datas objectForKey:@"banner"];
        
        self.bannerArray = [NSMutableArray array];
        for (int i =0 ; i<bannerArr.count; i++) {
            NSString *pic = [bannerArr[i] objectForKey:@"advertImg"];
            NSDictionary *dicPic = @{@"url":pic};
            [self.bannerArray addObject:dicPic];
        }
        
        NSArray *menuArr = [NSArray array];
        menuArr = [datas objectForKey:@"tag_classify"];
        
        for (int i =0 ; i<menuArr.count; i++) {
            NSDictionary *dict = menuArr[i];
            
            StoreTitleIconBtnModel *btnModel = [StoreTitleIconBtnModel titleIconWith:[dict objectForKey:@"tag_name"] icon:[dict objectForKey:@"tag_img"] controller:self tag:[[dict objectForKey:@"tag_type"] intValue]];
            [self.menuArray addObject:btnModel];
        }
        
        
        
        NSMutableArray *query = [NSMutableArray array];
        query = [datas objectForKey:@"query"];
        self.storeCellArray = [NSMutableArray array];
        // 字典数组 -> 模型数组
        for (int i = 1; i<query.count; i++) {
            NSDictionary *dict = query[i];
            StoreModel *m = [StoreModel initWithDic:dict];
            [self.storeCellArray addObject:m];
            
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.storeTableView reloadData];
        });
    });
}

- (void)initTableView
{
    self.storeTableView.dataSource = self;
    self.storeTableView.delegate = self;
    self.storeTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.storeTableView];
    
}

#pragma mark - TableView代理方法
// tableView数据源代理方法啊
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.storeCellArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    StoreCell *cell = [StoreCell cellWithTableView: tableView];
    cell.models = self.storeCellArray[indexPath.row];
  
    return cell;
}


// tableView代理方法啊
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 320;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] init];
    
    /////////////////////////////////
    ZCScrollView *scrollView = [[ZCScrollView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 200)];
    scrollView.backgroundColor = [UIColor grayColor];
    [headerView addSubview:scrollView];
    
    [scrollView setZCScrollViewWithArray:self.bannerArray];
    
    [scrollView tapImageViewBlock:^(NSInteger curPage) {
        NSLog(@"ZCScrollView page %zd", curPage);
        
    }];

    /////////////////////////////////
    StoreMenuView *menuView = [[StoreMenuView alloc]initMenu:self.menuArray];
    menuView.delegate = self;
    menuView.frame = CGRectMake(0, 200, ScreenWidth, 180);
    [headerView addSubview:menuView];

    /////////////////////////////////
    UIView *xsView = [[UIView alloc] initWithFrame:CGRectMake(0, 380, ScreenWidth, 200)];
//    xsView.bgImageName = [self.channelDict objectForKey:@"goods_img"];
//    
//    //    xsView.title = [self.channelDict objectForKey:@"title"];
//    //    xsView.nowPrice = [self.channelDict objectForKey:@"zhekou"];
//    //    xsView.origPrice = [self.channelDict objectForKey:@"goods_price"];
//    //    xsView.desc = [self.channelDict objectForKey:@"goods_name"];
//    xsView.title = @"title";
//    xsView.nowPrice = @"12";
//    xsView.origPrice = @"3";
//    xsView.desc = @"hah";
    [headerView addSubview:xsView];
    
    
    
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 580;
}

#pragma mark - StoreMenuDelegate
- (void)menuBtnClick
{
    NSLog(@"-----------");
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
