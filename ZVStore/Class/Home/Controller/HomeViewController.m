//
//  HomeViewController.m
//  ZVStore
//
//  Created by zivInfo on 17/2/16.
//  Copyright © 2017年 xiwangtech.com. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController


- (NSMutableDictionary *)heights
{
    if (!_heights) {
        _heights = [NSMutableDictionary dictionary];
    }
    return _heights;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor whiteColor];
    [self loadData];

    [self setTitleView];
    [self initTableView];
    

}

- (void)setTitleView
{

    UIImageView *titleImage = [[UIImageView alloc] init];
    titleImage.frame = CGRectMake(25, 20, 60, 20);
    titleImage.image = [UIImage imageNamed:@"YS_food+"];
    self.navigationItem.titleView = titleImage;
    
}

- (void)initTableView
{
    self.homeTableView.dataSource = self;
    self.homeTableView.delegate = self;
    self.homeTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.homeTableView];
}

#pragma mark - 获取数据
- (void)loadData
{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSString *path = [[NSBundle mainBundle] pathForResource:@"Home" ofType:@"json"];
        NSData *data = [NSData dataWithContentsOfFile:path];
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        
        NSDictionary *datas = [NSDictionary dictionary];
        datas = [json objectForKey:@"datas"];
        NSMutableArray *bannerArr = [NSMutableArray array];
        bannerArr = [datas objectForKey:@"banner"];
        
        self.tempArr = [NSMutableArray array];
        for (int i =0 ; i<bannerArr.count; i++) {
            NSString *pic = [bannerArr[i] objectForKey:@"advertImg"];
            NSDictionary *dicPic = @{@"url":pic};
            [self.tempArr addObject:dicPic];
        }
        
        NSMutableArray *data_type = [NSMutableArray array];
        data_type = [datas objectForKey:@"data_type"];
        self.homeCellArray = [NSMutableArray array];
        // 字典数组 -> 模型数组
        for (int i = 1; i<data_type.count; i++) {
            NSDictionary *dict = data_type[i];
            HomeCellModel *status = [HomeCellModel initWithDic:dict];
            [self.homeCellArray addObject:status];
            
        }
        
        NSDictionary *firstData = data_type[0];
        self.infoString = [firstData objectForKey:@"relation_object_title"];
        self.infoPicName = [firstData objectForKey:@"relation_object_image"];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.homeTableView reloadData];
        });
    });
    
    NSLog(@"homeCellArray %@", self.homeCellArray);
}

#pragma mark -
#pragma mark - TableView代理方法
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 650;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] init];
    
    /////////////////////////////////
    ZCScrollView *scrollView = [[ZCScrollView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 200)];
    scrollView.backgroundColor = [UIColor grayColor];
    [headerView addSubview:scrollView];
    
    [scrollView setZCScrollViewWithArray:self.tempArr];
    
    [scrollView tapImageViewBlock:^(NSInteger curPage) {
        NSLog(@"ZCScrollView page %zd", curPage);
        
        [self.navigationController pushViewController:[[HomeInfoViewController alloc] init] animated:YES];
    }];
    
    /////////////////////////////////
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 200, ScreenWidth, 30)];
    label.text = @"YUESHI CHOSEN";
    label.textColor = [UIColor blackColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:15.0];
    label.backgroundColor = [UIColor whiteColor];
    [headerView addSubview:label];
    
    UIImageView *aImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 230, ScreenWidth, 200)];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        [aImageView sd_setImageWithURL:[NSURL URLWithString:self.infoPicName]];
    });
    
    UIToolbar *burlView = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 200)];
    burlView.alpha = 0.8;
    [aImageView addSubview:burlView];
    
    UIImageView *bImageView = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth * 0.2, 70, ScreenWidth * 0.6, 70)];
//    bImageView.image = [UIImage imageNamed:@"InfoCelltitle"];
    [burlView addSubview:bImageView];
    UILabel *infoLabel = [[UILabel alloc] initWithFrame:CGRectMake((bImageView.frame.size.width-150)/2, 20, 150, 30)];
    infoLabel.textAlignment = NSTextAlignmentCenter;
    infoLabel.text = self.infoString;
    infoLabel.font = [UIFont systemFontOfSize:17.0];
    [bImageView addSubview:infoLabel];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClicked)];
    [aImageView addGestureRecognizer:tap];
    aImageView.userInteractionEnabled = YES;
    [headerView addSubview:aImageView];

    ////////////////////////////
    //创建一个layout布局类
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(120, 200);
    //最小行间距
    layout.minimumLineSpacing = 15;
    //最小的item间距
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    CGFloat margin = 15;
    layout.sectionInset = UIEdgeInsetsMake(0, margin, 0, margin);

    //创建collectionView
    UICollectionView * collect = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 430, ScreenWidth, 220) collectionViewLayout:layout];
    //代理设置
    collect.backgroundColor = [UIColor whiteColor];
    collect.delegate = self;
    collect.dataSource = self;
    //注册item类型
    [collect registerNib:[UINib nibWithNibName:NSStringFromClass([ShopCell class]) bundle:nil] forCellWithReuseIdentifier:@"shopCell"];
    collect.showsHorizontalScrollIndicator = NO;
    [headerView addSubview:collect];
    
    return headerView;
}

- (void)tapClicked
{
    [self.navigationController pushViewController:[[HomeInfoViewController alloc] init] animated:YES];
}


// tableView数据源代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.homeCellArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HomeCell *cell = [HomeCell cellWithTableView:tableView];
    cell.model = self.homeCellArray[indexPath.row];
    CGFloat tmpHeight = [cell cellHeight];
    
    [self.heights setObject:@(tmpHeight) forKey:@(indexPath.row)];

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 370;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSLog(@"UITableView row %@", self.homeCellArray[indexPath.row]);
    [self.navigationController pushViewController:[[HomeInfoViewController alloc] init] animated:YES];
    
}

#pragma mark -
#pragma mark - collectionView代理
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 4;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ShopCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"shopCell" forIndexPath:indexPath];
    cell.userInteractionEnabled = YES;
    
    cell.pciName = @"";
    cell.name = @"石锅";
    cell.price = @"¥ 9.00";
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"UICollectionView row %ld", (long)indexPath.row);
    [self.navigationController pushViewController:[[HomeInfoViewController alloc] init] animated:YES];
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
