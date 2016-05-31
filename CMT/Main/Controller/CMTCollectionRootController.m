//
//  CMTCollectionRootController.m
//  CMT
//
//  Created by qianfeng on 16/1/4.
//  Copyright © 2016年 汪淼. All rights reserved.
//

#import "CMTCollectionRootController.h"


@interface CMTCollectionRootController ()

@end

@implementation CMTCollectionRootController

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataArray = [NSMutableArray array];
    [self configUI];
}

- (void)configUI
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    NSLog(@"子类需要重写configUI，且需要调用父类的configUI");
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumInteritemSpacing = 10;
    flowLayout.minimumLineSpacing = 10;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 64, KSCREENWIDTH, KSCREENHEIGHT - 64) collectionViewLayout:flowLayout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_collectionView];
}

#pragma mark 下拉刷新，上拉加载更多

-(void)addMJRefreshHasHeader:(BOOL)isHavHeader withHasFooter:(BOOL)isHavFooter{
    if (isHavHeader) {
        _collectionView.header=[MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(reloadData)];
        //开始加载
        [_collectionView.header beginRefreshing];
    }
    if (isHavFooter) {
        _collectionView.footer=[MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMore)];
    }
}

-(void)reloadData{
    NSLog(@"重新加载数据，子类需要重写");
}
-(void)loadMore{
    NSLog(@"加载更多，子类需要重写");
}



- (void)loadData
{
    NSLog(@"子类需要重写loadData");
}

#pragma mark - collectionView的代理
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSLog(@"子类需要重写numberOfItemsInSection:");
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"子类需要重写cellForItemAtIndexPath:");
    return nil;
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"子类需要重写sizeForItemAtIndexPath:");
    return CGSizeMake(0, 0);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    NSLog(@"子类需要重写 insetForSectionAtIndex:");
    return UIEdgeInsetsMake(0, 0, 0, 0);
}


@end
