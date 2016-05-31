//
//  CMTCollectionController.h
//  CMT
//
//  Created by qianfeng on 15/12/21.
//  Copyright © 2015年 汪淼. All rights reserved.
//

#import "CMTRootController.h"
#import "UIImageView+WebCache.h"
#import "MJRefresh.h"

@interface CMTCollectionController : CMTRootController <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

{
    UICollectionView *_collectionView;
    NSMutableArray *_dataArray;
}

- (void)configUI;
- (void)loadData;


@end
