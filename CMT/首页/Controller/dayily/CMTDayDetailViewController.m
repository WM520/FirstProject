//
//  CMTDayDetailViewController.m
//  CMT
//
//  Created by qianfeng on 16/1/4.
//  Copyright © 2016年 汪淼. All rights reserved.
//

#import "CMTDayDetailViewController.h"
#import "LoversSpaceCell.h"
#import "LoversSpaceModel.h"
#import "CMTDetailController.h"

@interface CMTDayDetailViewController ()
{
    NSInteger _currentPage;
}
@end

@implementation CMTDayDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)configUI
{
    [super configUI];
    [self addMJRefreshHasHeader:YES withHasFooter:YES];
    [self addTitleView:self.name];
    _currentPage = 1;
    [_collectionView registerNib:[UINib nibWithNibName:@"LoversSpaceCell" bundle:nil] forCellWithReuseIdentifier:@"LoversSpaceCell"];
}

- (void)reloadData
{
    _currentPage = 1;
    [self loadData];
}

- (void)loadMore
{
    _currentPage++;
    [self loadData];
}

- (void)loadData
{
    NSString *urlString = [NSString stringWithFormat:KDayilyDetailUrl, [self.ID integerValue], _currentPage];
    
    [[HttpManager shareManager]requestWithUrl:urlString withDictionary:nil withSuccessBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSArray *array = responseObject[@"data"];
        [_collectionView.header endRefreshing];
        [_collectionView.footer endRefreshing];
        
        if (_currentPage == 1) {
            [_dataArray removeAllObjects];
        }
        
        
        for (NSDictionary *dic in array) {
            LoversSpaceModel *model = [[LoversSpaceModel alloc] initWithDictionary:dic error:nil];
            [_dataArray addObject:model];
        }
        
        [_collectionView reloadData];
        
    } withFailureBlock:^(AFHTTPRequestOperation *operation, NSError *error) {
        [_collectionView.header endRefreshing];
        [_collectionView.footer endRefreshing];
    }];
}


#pragma mark - collectionView的代理
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"LoversSpaceCell";
    LoversSpaceModel *model = _dataArray[indexPath.row];
    LoversSpaceCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
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
    
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark - UICollectionViewDelegate
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(150, 260);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 0, 10, 0);
    
}

@end
