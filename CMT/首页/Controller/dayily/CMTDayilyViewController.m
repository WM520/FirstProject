//
//  CMTDayilyViewController.m
//  CMT
//
//  Created by qianfeng on 16/1/4.
//  Copyright © 2016年 汪淼. All rights reserved.
//

#import "CMTDayilyViewController.h"
#import "CMTDayilyModel.h"
#import "CMTDayilyCell.h"
#import "CMTDayDetailViewController.h"

@interface CMTDayilyViewController ()

@end

@implementation CMTDayilyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
}


- (void)configUI
{
    [super configUI];
    [self addTitleView:self.name];
    [_collectionView registerNib:[UINib nibWithNibName:@"CMTDayilyCell" bundle:nil] forCellWithReuseIdentifier:@"dayCell"];
}

- (void)loadData
{
    [[HttpManager shareManager]requestWithUrl:KDayilyUrl withDictionary:nil withSuccessBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSArray *array = responseObject[@"data"];
        for (NSDictionary *dic in array) {
            CMTDayilyModel *model = [[CMTDayilyModel alloc] initWithDictionary:dic error:nil];
            [_dataArray addObject:model];
        }
        [_collectionView reloadData];
    } withFailureBlock:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}

#pragma mark - collectionView的代理
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"dayCell";
    CMTDayilyModel *model = _dataArray[indexPath.row];
    CMTDayilyCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    [cell.iconImageView sd_setImageWithURL:[NSURL URLWithString:model.kind_icon]];
    cell.nameLabel.text = model.kind_name;
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    return CGSizeMake(140 * KRATE, 160 * KRATE);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    CMTDayDetailViewController *vc = [[CMTDayDetailViewController alloc] initWithNibName:@"CMTDayDetailViewController" bundle:nil];
    CMTDayilyModel *model = _dataArray[indexPath.row];
    vc.name = model.kind_name;
    vc.ID = model.kind_id;
    [self.navigationController pushViewController:vc animated:YES];
}


@end
