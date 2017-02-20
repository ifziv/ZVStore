//
//  BasketViewController.m
//  ZVStore
//
//  Created by zivInfo on 17/2/16.
//  Copyright © 2017年 xiwangtech.com. All rights reserved.
//

#import "BasketViewController.h"

@interface BasketViewController ()

@end

@implementation BasketViewController


- (NSMutableArray *)goodsArray
{
    if (!_goodsArray) {
        _goodsArray = [NSMutableArray array];
    }
    return _goodsArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self loadDatas];
    self.flag = NO;

    [self initTableView];
    [self setupFooterView];
}

#pragma mark - 加载数据
- (void)loadDatas
{
//    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
//    NSString *sqlFilePath = [path stringByAppendingPathComponent:@"goods.sqlite"];
//    NSLog(@"---->%@",sqlFilePath);
//    self.db= [FMDatabase databaseWithPath:sqlFilePath];
//    if ([self.db open]) {
//        NSLog(@"打开成功");
//        // 查询数据
//        FMResultSet *result = [self.db executeQuery:@"SELECT id, goods_name, goods_desc, goods_price, goods_num, goods_img FROM t_goods ;"];
//        
//        NSMutableArray *tempArray = [NSMutableArray array];
//        
//        while ([result next]) {
//            NSInteger ID = [result intForColumnIndex:0];
    
            NSMutableArray *tempArray = [NSMutableArray array];

            NSString *goods_id = [NSString stringWithFormat:@"870"];
            NSString *goods_name = @"haha";
            NSString *goods_desc = @"this is test";
            NSString *goods_price = @"9.90";
            NSString *goods_img = @"http://yueshi.b0.upaiyun.com/cms/2016/08/15/97cbb0ce55b2235f";
            NSString *goods_num = @"1";
            
            NSDictionary *dict = [NSDictionary dictionary];
            dict = @{@"goods_id":goods_id,@"goods_name":goods_name,@"goods_desc":goods_desc,@"goods_price":goods_price,@"goods_img":goods_img,@"goods_num":goods_num};
            [tempArray addObject:dict];
    
    
        NSString *goods_id2 = [NSString stringWithFormat:@"870"];
        NSString *goods_name2 = @"haha2";
        NSString *goods_desc2 = @"this is test";
        NSString *goods_price2 = @"10.90";
        NSString *goods_img2 = @"http://yueshi.b0.upaiyun.com/cms/2016/08/15/97cbb0ce55b2235f";
        NSString *goods_num2 = @"1";
    
        NSDictionary *dict2 = [NSDictionary dictionary];
        dict2 = @{@"goods_id":goods_id2,@"goods_name":goods_name2,@"goods_desc":goods_desc2,@"goods_price":goods_price2,@"goods_img":goods_img2,@"goods_num":goods_num2};
        [tempArray addObject:dict2];
//        }
    
        for (NSDictionary *dict in tempArray) {
            BasketModel *model = [BasketModel initWithDic:dict];
            model.selectBtn = NO;
            [self.goodsArray addObject:model];
        }
        
        
//    } else {
//        NSLog(@"打开失败");
//    }
//    
//    [self.db close];
}

- (void)initTableView
{
    self.basketTableView.dataSource = self;
    self.basketTableView.delegate = self;
    self.basketTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.basketTableView];
    
    self.rfcontrol = [[UIRefreshControl alloc] init];
    self.rfcontrol.attributedTitle = [[NSAttributedString alloc] initWithString:@"下拉刷新"];
    [self.rfcontrol addTarget:self action:@selector(refresh) forControlEvents:UIControlEventValueChanged];
    [self.basketTableView addSubview:self.rfcontrol];

}

- (void)setupFooterView
{
    UIView *footerView = [[UIView alloc] init];
    [footerView setBackgroundColor:[UIColor whiteColor]];
    footerView.layer.borderColor = ThemeColor.CGColor;
    footerView.layer.borderWidth = 0.5;
    [self.view addSubview:footerView];
    
    UIButton *selImage = [UIButton buttonWithType:UIButtonTypeCustom];
    [selImage setImage:[UIImage imageNamed:@"car_noSelect"] forState:UIControlStateNormal];
    [selImage addTarget:self action:@selector(allSelectClick:) forControlEvents:UIControlEventTouchUpInside];
    [selImage setImage:[UIImage imageNamed:@"car_Select"] forState:UIControlStateSelected];
    self.selImage = selImage;
    [footerView addSubview:selImage];
    
    
    UILabel *allSelect = [[UILabel alloc] init];
    allSelect.text = @"全选";
    [footerView addSubview:allSelect];
    
    UILabel *allPrice = [[UILabel alloc] init];
    allPrice.text = @"合计:";
    allPrice.textAlignment = NSTextAlignmentRight;
    allPrice.font = [UIFont systemFontOfSize:13.0];
    [footerView addSubview:allPrice];
    
    UILabel *totalPrice = [[UILabel alloc] init];
    totalPrice.text =@"￥0.00";
    totalPrice.textAlignment = NSTextAlignmentLeft;
    totalPrice.font = [UIFont systemFontOfSize:13.0];
    totalPrice.textColor = ThemeColor;
    self.totalPrice = totalPrice;
    [footerView addSubview:totalPrice];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setBackgroundColor:ThemeColor];
    [btn setTitle:@"结算" forState:UIControlStateNormal];
    [btn setTintColor:[UIColor whiteColor]];
    [btn.titleLabel setFont:[UIFont systemFontOfSize:16.0]];
    [btn addTarget:self action:@selector(buyBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:btn];
    
    [footerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(-0.5);
        make.right.mas_equalTo(self.view.mas_right).offset(0.5);
        make.bottom.mas_equalTo(self.view.mas_bottom).offset(-43.5);
        make.height.mas_equalTo(@44);
    }];
    
    [selImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(footerView).mas_equalTo(11);
        make.left.mas_equalTo(footerView).mas_equalTo(10);
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];
    
    [allSelect mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(footerView).mas_equalTo(11);
        make.left.mas_equalTo(selImage.mas_right).mas_equalTo(10);
        make.size.mas_equalTo(CGSizeMake(40, 20));
    }];
    
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(footerView.mas_right);
        make.top.mas_equalTo(footerView.mas_top);
        make.bottom.mas_equalTo(footerView.mas_bottom);
        make.width.mas_equalTo(100);
    }];
    
    [totalPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(footerView).mas_equalTo(11);
        make.right.mas_equalTo(btn.mas_left).mas_equalTo(-20);
        make.height.mas_equalTo(20);
    }];
    
    [allPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(footerView).mas_equalTo(11);
        make.right.mas_equalTo(totalPrice.mas_left).mas_equalTo(-5);
        make.size.mas_equalTo(CGSizeMake(40, 20));
    }];
}

#pragma mark - 内部控件事件
- (void)editClick
{
    NSLog(@"------editClick-------");
}

- (void)buyBtnClick
{
    NSLog(@"------buyBtnClick-------");
}

- (void)allSelectClick:(UIButton *)button
{
    button.selected = !button.selected;
    
    for (BasketModel *shopModel in self.goodsArray) {
        shopModel.selectBtn = button.selected;
        self.selectBtn.selected = button.selected;
    }
    
    if (button.selected) {
        [self.selectBtn setImage:[UIImage imageNamed:@"car_Select"] forState:UIControlStateSelected];
        
        
        //全选视图
        NSMutableArray *temAry = [NSMutableArray arrayWithCapacity:0];
        for (BasketModel *model in self.goodsArray) {
            model.selectBtn = YES;
            [temAry addObject:model];
        }
        self.goodsArray = temAry;
        [self.basketTableView reloadData];

        
        
        
        [self updateAllprice];
    }
    else {
        [self.selectBtn setImage:[UIImage imageNamed:@"car_noSelect"] forState:UIControlStateSelected];
        
        //全选视图
        NSMutableArray *temAry = [NSMutableArray arrayWithCapacity:0];
        for (BasketModel *model in self.goodsArray) {
            model.selectBtn = NO;
            [temAry addObject:model];
        }
        self.goodsArray = temAry;
        [self.basketTableView reloadData];
        
        self.totalPrice.text = @"￥:0.00";
    }
    
}


- (void)updateAllprice {
    CGFloat allmoney = 0;
    for (BasketModel *shopModel in self.goodsArray) {
        
        float goodsPrice = shopModel.goods_price.floatValue;
        float goodsNum = shopModel.goods_num.floatValue;
        if (shopModel.selectBtn == YES) {
            allmoney += goodsPrice * goodsNum;
        } else {
            
        }
        
        
    }
    NSString *moneys = [NSString stringWithFormat:@"¥%.2f",allmoney];
    self.totalPrice.text = moneys;

}

- (void)refresh
{
    [self.goodsArray removeAllObjects];
    [self loadDatas];
    [self.basketTableView reloadData];
    [self.rfcontrol endRefreshing];
}

#pragma mark - TableView代理方法
// tableView数据源代理方法啊
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.goodsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BasketCell *cell = [BasketCell cellWithTableView:tableView];
    cell.model = self.goodsArray[indexPath.row];
    cell.indexPath = indexPath;
    cell.delegate = self;
    return cell;
}


// tableView代理方法啊
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 110;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *head = [[UIView alloc] init];
    head.backgroundColor = [UIColor whiteColor];
    
//    UIButton *selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [selectBtn setImage:[UIImage imageNamed:@"car_noSelect"] forState:UIControlStateNormal];
//    [selectBtn setImage:[UIImage imageNamed:@"car_Select"] forState:UIControlStateSelected];
//    [selectBtn addTarget:self action:@selector(allSelectClick:) forControlEvents:UIControlEventTouchUpInside];
//    self.selectBtn = selectBtn;
//    [head addSubview:selectBtn];
//    
//    UIImageView *storeImg = [[UIImageView alloc] init];
//    storeImg.image = [UIImage imageNamed:@"shopIcon"];
//    [head addSubview:storeImg];
//    
//    UILabel *storeNameLabel = [[UILabel alloc] init];
//    storeNameLabel.text = @"悦食家";
//    storeNameLabel.textColor = ThemeColor;
//    storeNameLabel.font = [UIFont systemFontOfSize:15.0];
//    [head addSubview:storeNameLabel];
//    
//    UIImageView *inImg = [[UIImageView alloc] init];
//    inImg.image = [UIImage imageNamed:@"btn_in"];
//    [head addSubview:inImg];
//    
//    [selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(head).mas_equalTo(11);
//        make.left.mas_equalTo(head).mas_equalTo(10);
//        make.size.mas_equalTo(CGSizeMake(20, 20));
//    }];
//    
//    [storeImg mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(selectBtn.mas_top);
//        make.left.mas_equalTo(selectBtn.mas_right).mas_equalTo(20);
//        make.size.mas_equalTo(CGSizeMake(20, 20));
//    }];
//    
//    [storeNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(selectBtn.mas_top);
//        make.left.mas_equalTo(storeImg.mas_right).mas_equalTo(20);
//        make.height.mas_equalTo(20);
//    }];
//    
//    [inImg mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.mas_equalTo(head.mas_right).offset(-15);
//        make.centerY.mas_equalTo(head.mas_centerY);
//        make.size.mas_equalTo(CGSizeMake(6, 11));
//    }];
    
    return head;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
}

//先要设Cell可编辑
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
//定义编辑样式
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}
//进入编辑模式，按下出现的编辑按钮后,进行删除操作
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        BasketModel *model = self.goodsArray[indexPath.row];
        NSInteger index = model.goods_id.integerValue;
        NSLog(@"---->%zd",index);
        [self.goodsArray removeObjectAtIndex:indexPath.row];
//        [self deleteGoodsData:index];
        [self.basketTableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
    }
}
//修改编辑按钮文字
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}

#pragma mark - cellDelegate
- (void)selectBasketCellClick:(NSIndexPath *)indexPath btn:(UIButton *)btn
{
    if (btn.selected == NO) {
        self.selImage.selected = btn.selected;
    }
    BasketModel *shopModel = self.goodsArray[indexPath.row];
    shopModel.selectBtn = btn.selected;
    [self updateAllprice];
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
