//
//  CMTSegController.m
//  CMT
//
//  Created by qianfeng on 15/12/24.
//  Copyright © 2015年 汪淼. All rights reserved.
//

#import "CMTSegController.h"
#import "LoversSpaceCell.h"
#import "LoversSpaceModel.h"
#import "CMTDetailController.h"

@interface CMTSegController () <UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
{
    NSMutableArray *_dataArray;
    UICollectionView *_collectionView;
}
@end

@implementation CMTSegController

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataArray = [NSMutableArray new];
    [self loadData];
    [self configUI];
}
- (void)configUI {
    [self addTitleView:_name];
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumInteritemSpacing = 10;
    flowLayout.minimumLineSpacing = 10;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, KSCREENWIDTH, KSCREENHEIGHT) collectionViewLayout:flowLayout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.bounces = NO;
    _collectionView.backgroundColor = KBackColor;
    [self.view addSubview:_collectionView];
    
    [_collectionView registerNib:[UINib nibWithNibName:@"LoversSpaceCell" bundle:nil] forCellWithReuseIdentifier:@"LoversSpaceCell"];
}

- (void)loadData {
   
    [[HttpManager shareManager] requestWithUrl:self.URL withDictionary:nil withSuccessBlock:^(AFHTTPRequestOperation *operation, id responseObject) {

        NSArray *itemDetail = [responseObject objectForKey:@"data"][@"itemDetail"];
        for (NSDictionary *dict in itemDetail) {
            LoversSpaceModel *model = [[LoversSpaceModel alloc] initWithDictionary:dict error:nil];
            [_dataArray addObject:model];
        }
        [_collectionView reloadData];
    } withFailureBlock:^(AFHTTPRequestOperation *operation, NSError *error) {
   
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
    
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark - UICollectionViewDelegate
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(150, 260);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(5, 5, 5, 5);
}




@end
