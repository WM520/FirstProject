//
//  CMTCollectionRootController.h
//  CMT
//
//  Created by qianfeng on 16/1/4.
//  Copyright © 2016年 汪淼. All rights reserved.
//

#import "CMTRootController.h"
#import "MJRefresh.h"

@interface CMTCollectionRootController : CMTRootController<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

{
    UICollectionView *_collectionView;
    NSMutableArray *_dataArray;
}

- (void)configUI;
- (void)loadData;

//是否用上下拉刷新
-(void)addMJRefreshHasHeader:(BOOL)isHavHeader withHasFooter:(BOOL)isHavFooter;
-(void)loadMore;
-(void)reloadData;

@end
