//
//  CMTGroupController.m
//  CMT
//
//  Created by qianfeng on 16/12/17.
//  Copyright (c) 2016年 汪淼. All rights reserved.
//

#import "CMTGroupController.h"
#import "CMTStyleModel.h"
#import "CMTCollectionViewCell.h"
#import "CMTReusableView.h"
#import "CMTWaterFlowLayout.h"
#import "CMTItemModel.h"
#import "CMTItemCell.h"
#import "MJRefresh.h"
#import "CMTGroupDetailController.h"



@interface CMTGroupController () {
    UICollectionView *_collectionView;
    NSMutableArray *_dataArray;
    NSMutableArray *_section1;
    NSMutableArray *_section2;
    NSInteger _page;
    UIButton *_btn;
}
@end

@implementation CMTGroupController

- (void)viewDidLoad {
    [super viewDidLoad];
    _page = 1;
    _section1 = [NSMutableArray array];
    _section2 = [NSMutableArray array];
    _dataArray = [NSMutableArray array];
    [self configUI];
    
}

- (void)configUI
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    _collectionView.bounces = NO;
    [self addTitleView:@"穿搭"];
    CMTWaterFlowLayout * layOut = [[CMTWaterFlowLayout alloc] init];
    layOut.degelate =self;
    UICollectionView * collectView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height - 64 - 49) collectionViewLayout:layOut];
    collectView.delegate =self;
    collectView.dataSource =self;
    collectView.backgroundColor = [UIColor whiteColor];
    _collectionView = collectView;
    _collectionView.backgroundColor = KCOLOR(226, 226, 226);
    [self.view addSubview:_collectionView];
    [self addBackButton];

    [self addRefresh];
}

// 添加重置按钮
- (void)addBackButton
{
    _btn = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 30 *KRATE, self.view.frame.size.height - 49 -30, 30 *KRATE, 30)];
    _btn.hidden = YES;
    [_btn setImage:[UIImage imageNamed:@"back1"] forState:UIControlStateNormal];
    [_btn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self.view insertSubview:_btn aboveSubview:_collectionView];
}


// 添加上下拉刷新
- (void)addRefresh
{
    [_collectionView registerClass:[CMTItemCell class] forCellWithReuseIdentifier:@"cell"];
    _collectionView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(reloadData)];
    [_collectionView.header beginRefreshing];
    _collectionView.footer = [MJRefreshAutoFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMore)];
}
// 回到顶部
- (void)back
{
    _collectionView.contentOffset = CGPointMake(0, 0);
}

// 上下拉刷新
- (void)reloadData
{
    _page = 1;
    [self loadData];
}

- (void)loadMore
{
    _page++;
    [self loadData];
    
}
// 加载数据
- (void)loadData
{
    NSString *url = [NSString stringWithFormat:KITEMURL,_page];
    [[HttpManager shareManager] requestWithUrl:url withDictionary:nil withSuccessBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [_collectionView.header endRefreshing];
        [_collectionView.footer endRefreshing];
        if (_page ==  1) {
            [_dataArray removeAllObjects];
        }
        NSArray *array = responseObject[@"data"];
        
        for (NSDictionary *dic in array) {
            CMTItemModel *model = [[CMTItemModel alloc] initWithDictionary:dic error:nil];
            [_dataArray addObject:model];
        }
        [_collectionView reloadData];
        
    } withFailureBlock:^(AFHTTPRequestOperation *operation, NSError *error) {
        [_collectionView.header endRefreshing];
        [_collectionView.footer endRefreshing];
    }];
}

#pragma mark - collectionView delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _dataArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CMTItemCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.model = _dataArray[indexPath.item];
    return cell;
}
//代理方法
-(CGFloat)ZWwaterFlow:(CMTWaterFlowLayout *)waterFlow heightForWidth:(CGFloat)width atIndexPath:(NSIndexPath *)indexPath
{
    CMTItemModel * model = _dataArray[indexPath.item];
    return [model.height floatValue]/[model.width floatValue] * width;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    CMTItemModel *model = _dataArray[indexPath.item];
    CMTGroupDetailController *vc = [[CMTGroupDetailController alloc] init];
    vc.number = [model.collocation_id integerValue];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (_collectionView.contentOffset.y > 2 * self.view.frame.size.height) {
        _btn.hidden = NO;
    } else {
        _btn.hidden = YES;
    }
}

@end
