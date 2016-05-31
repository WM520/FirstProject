//
//  FineStreetViewController2.m
//  CMT
//
//  Created by qianfeng on 15/12/22.
//  Copyright (c) 2015年 汪淼. All rights reserved.
//

#import "FineStreetViewController2.h"
#import "MJRefresh.h"
#import "HttpManager.h"
#import "LoversSpaceCell.h"
#import "LoversSpaceModel.h"
#import "CMTDetailController.h"

@interface FineStreetViewController2 () <UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
{
    NSMutableArray *_dataArray;
    UICollectionView *_collectionView;
    //记录当前你已经加载到的页数
    NSInteger _page;
}
@end

@implementation FineStreetViewController2

- (void)viewDidLoad {
    [super viewDidLoad];
    _page = 1;
    [self configUI];
    [self loadData];
}

- (void)configUI {
    
    
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    flowLayout.minimumInteritemSpacing = 10;
    
    flowLayout.minimumLineSpacing = 10;
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(5, 0, self.view.frame.size.width - 10, self.view.frame.size.height) collectionViewLayout:flowLayout];
    _collectionView.showsVerticalScrollIndicator = NO;
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [self.view addSubview:_collectionView];
    _collectionView.backgroundColor = KBackColor;
    _dataArray = [NSMutableArray new];
    [_collectionView registerNib:[UINib nibWithNibName:@"LoversSpaceCell" bundle:nil] forCellWithReuseIdentifier:@"LoversSpaceCell"];
    
    [self addMJRefresh];
}

- (void)addMJRefresh {
    _collectionView.header=[MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(reloadSource)];
    
    _collectionView.footer=[MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMore)];
}

- (void)reloadSource {
    _page = 1;
    [self loadData];
}

- (void)loadMore {
    _page++;
    [self loadData];
}


- (void)loadData {
    NSString *strURL = [NSString stringWithFormat:KJingPinXiaoJie2,_page];
    [[HttpManager shareManager] requestWithUrl:strURL withDictionary:nil withSuccessBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
        [_collectionView.header endRefreshing];
        [_collectionView.footer endRefreshing];
        if (_page == 1) {
            [_dataArray removeAllObjects];
        }
        NSArray *itemDetail = [responseObject objectForKey:@"data"][@"itemDetail"];
        for (NSDictionary *dict in itemDetail) {
            LoversSpaceModel *model = [[LoversSpaceModel alloc] initWithDictionary:dict error:nil];
            [_dataArray addObject:model];
        }
        [_collectionView reloadData];
    } withFailureBlock:^(AFHTTPRequestOperation *operation, NSError *error) {
        [_collectionView.header endRefreshing];
        [_collectionView.footer endRefreshing];
    }];
}


#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return _dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"LoversSpaceCell";
    LoversSpaceCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    LoversSpaceModel *model = _dataArray[indexPath.row];
    [cell.image sd_setImageWithURL:[NSURL URLWithString:model.pic_url]];
    cell.priceLabel.text = [NSString stringWithFormat:@"￥%@",model.coupon_price];
    cell.desLabel.text = model.title;
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    LoversSpaceModel *model = _dataArray[indexPath.row];
    
    CMTDetailController *vc = [[CMTDetailController alloc] init];
    
    vc.ID = [NSNumber numberWithInteger:[model._id integerValue]];
    
    __weak typeof (&*vc) ws = vc;
    self.changBlock(ws);
}

#pragma mark - UICollectionViewDelegate
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(150, 270);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 0, 10, 0);
    
}


@end
