//
//  CMTCollectionController.m
//  CMT
//
//  Created by qianfeng on 15/12/21.
//  Copyright © 2015年 汪淼. All rights reserved.
//

#import "CMTCollectionController.h"

@interface CMTCollectionController ()

@end

@implementation CMTCollectionController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 64, KSCREENWIDTH, KSCREENHEIGHT - 64 - 49) collectionViewLayout:flowLayout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_collectionView];
    
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
