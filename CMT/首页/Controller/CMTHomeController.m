//
//  CMTHomeController.m
//  CMT
//
//  Created by qianfeng on 16/12/17.
//  Copyright (c) 2016年 汪淼. All rights reserved.
//

#import "CMTHomeController.h"
#import "SDCycleScrollView.h"
#import "CMTHeader.h"
#import "CMTJXModel.h"
#import "CMTJXCell.h"
#import "CMTDetailController.h"
#import "CMTHeaderReusableView.h"
#import "CMTIconCell.h"
#import "CMTUserComment.h"
#import "CMTGengduoCell.h"
#import "LoversSpaceViewController.h"
#import "CMTSegController.h"
#import "ScrollModel.h"
#import "CMTHuoDongCell.h"
#import "CMTWebController.h"
#import "CMTNewWebController.h"
#import "TrendyItemsViewController.h"
#import "CMTDayilyViewController.h"
#import "CMTWearController.h"

@interface CMTHomeController ()

{
    UIButton *_btn;
    NSMutableArray *_section1;
    NSMutableArray *_section2;
    NSMutableArray *_section3;
    NSMutableArray *_section4;
    NSMutableArray *_imageArray;
    NSMutableArray *_topArray;
    NSMutableArray *_headViewArray;
}

@end


@implementation CMTHomeController


- (void)viewDidLoad
{
    [super viewDidLoad];
    _topArray = [NSMutableArray array];
    _section4 = [NSMutableArray array];
    _section3 = [NSMutableArray array];
    _section2 = [NSMutableArray array];
    _section1 = [NSMutableArray array];
    _headViewArray = [NSMutableArray array];
    [_section4 addObject:@"偏年轻"];
    [_section4 addObject:@"偏成熟"];
    [self configUI];
}

- (void)configUI
{
    [super configUI];
    [self addTitleView:@"精选"];
    _collectionView.backgroundColor = [UIColor colorWithRed:236/255.0 green:236/255.0 blue:236/255.0 alpha:1.0];
    [_collectionView registerNib:[UINib nibWithNibName:@"CMTJXCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];
    [_collectionView registerNib:[UINib nibWithNibName:@"CMTHeaderReusableView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"Header"];
    [_collectionView registerClass:[CMTScrollReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"ScrollHeader"];
    [_collectionView registerNib:[UINib nibWithNibName:@"CMTIconCell" bundle:nil] forCellWithReuseIdentifier:@"iconcell"];
    [_collectionView registerNib:[UINib nibWithNibName:@"CMTGengduoCell" bundle:nil] forCellWithReuseIdentifier:@"morecell"];
     [_collectionView registerNib:[UINib nibWithNibName:@"CMTHuoDongCell" bundle:nil] forCellWithReuseIdentifier:@"hongCell"];
    [self addRefresh];
    [self addBackButton];
}

- (void)addRefresh
{
    _collectionView.header=[MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(reloadSource)];
    [_collectionView.header beginRefreshing];
}

- (void)reloadSource
{
    [self loadData];
}

- (void)loadData
{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
       [[HttpManager shareManager] requestWithUrl:AD_URL withDictionary:nil withSuccessBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
           NSArray *array = responseObject[@"data"];
           [_topArray removeAllObjects];
           for (NSDictionary *dict in array) {
               ScrollModel *scrollModel = [[ScrollModel alloc]init];
               [scrollModel setValuesForKeysWithDictionary:dict];
               [_headViewArray addObject:scrollModel];
               [_topArray addObject:scrollModel.theme_image];
           }
           
       } withFailureBlock:^(AFHTTPRequestOperation *operation, NSError *error) {
           
       }];
        [[HttpManager shareManager] requestWithUrl:KHOMEHEADER withDictionary:nil withSuccessBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSArray *array = responseObject[@"data"];
            if (_section1.count != 0) {
                [_section1 removeAllObjects];
            }
            for (NSDictionary *dic in array) {
                CMTHeader *model = [[CMTHeader alloc] initWithDictionary:dic error:nil];
                [_section1 addObject:model];
            }
        } withFailureBlock:^(AFHTTPRequestOperation *operation, NSError *error) {
            
        }];
        [[HttpManager shareManager] requestWithUrl:KHUODONGURL withDictionary:nil withSuccessBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSArray *array = responseObject[@"data"];
            if (_section2.count != 0) {
                 [_section2 removeAllObjects];
            }
            for (NSDictionary *dict in array) {
                ScrollModel *scrollModel = [[ScrollModel alloc]init];
                [scrollModel setValuesForKeysWithDictionary:dict];
                [_section2 addObject:scrollModel];
            }
            
        } withFailureBlock:^(AFHTTPRequestOperation *operation, NSError *error) {
            
        }];
        
        [[HttpManager shareManager] requestWithUrl:KHOMEITEM withDictionary:nil withSuccessBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
            [_collectionView.header endRefreshing];
            NSArray *array = responseObject[@"data"][@"itemDetail"];
            if (_section3.count != 0) {
                [_section3 removeAllObjects];
            }
            for (NSDictionary *dic in array) {
                CMTJXModel *model = [[CMTJXModel alloc] initWithDictionary:dic error:nil];
                [_section3 addObject:model];
            }
            if (_dataArray.count != 0)
            {
                [_dataArray removeAllObjects];
            }
            [_dataArray addObject:_section1];
            [_dataArray addObject:_section2];
            [_dataArray addObject:_section3];
            [_dataArray addObject:_section4];
            
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [_collectionView reloadData];
            });
         
        } withFailureBlock:^(AFHTTPRequestOperation *operation, NSError *error) {
            
        }];

    });
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

// 回到顶部
- (void)back
{
    _collectionView.contentOffset = CGPointMake(0, 0);
}

#pragma mark - collectionView datasource的代理
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return _dataArray.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [_dataArray[section] count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0) {
        static NSString *ID = @"iconcell";
        CMTIconCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
        CMTHeader *model = _dataArray[indexPath.section][indexPath.row];
        [cell.iconImage sd_setImageWithURL:[NSURL URLWithString:model.theme_image]];
        cell.title.text = model.theme_name;
        return cell;
    }
    if (indexPath.section == 1) {
        static NSString *ID = @"hongCell";
        CMTHuoDongCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
        ScrollModel *model = _dataArray[indexPath.section][indexPath.row];
        [cell.descImage sd_setImageWithURL:[NSURL URLWithString:model.theme_image]];
        return cell;
    }
    
    if (indexPath.section == 2) {
        static NSString *ID = @"cell";
        CMTJXCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
        CMTJXModel *model = _dataArray[indexPath.section][indexPath.row];
        [cell.iconImage sd_setImageWithURL:[NSURL URLWithString:model.pic_url]];
        cell.descLabel.text = model.title;
        cell.priceLabel.text = model.coupon_price;
        cell.farLabel.text = model.saveCount;
        return cell;
    }
    if (indexPath.section == 3) {
        static NSString *ID = @"morecell";
        CMTGengduoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
        cell.moreBt.text = _dataArray[indexPath.section][indexPath.row];
        return cell;
    }
    return nil;
}

#pragma mark - collectionView 的代理
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return CGSizeMake(60 *KRATE, 80);
    }
    if (indexPath.section == 1) {
        return CGSizeMake(300 *KRATE, 120);
    }
    if (indexPath.section == 2) {
        return CGSizeMake(140 * KRATE, 180);
    }
    if (indexPath.section == 3) {
        return CGSizeMake(120, 40);
    }
    return CGSizeMake(140 * KRATE, 180);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    if (section == 0) {
        return UIEdgeInsetsMake(5, 15, 5, 15);
    }
    return UIEdgeInsetsMake(5, 10, 5, 10);
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (_collectionView.contentOffset.y > 2 * self.view.frame.size.height) {
        _btn.hidden = NO;
    } else {
        _btn.hidden = YES;
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            TrendyItemsViewController *vc = [[TrendyItemsViewController alloc] init];
            CMTHeader *model = _dataArray[indexPath.section][indexPath.row];
            vc.name = model.theme_name;
            [self.navigationController pushViewController:vc animated:YES];
        } else if (indexPath.row == 1) {
            CMTDayilyViewController *vc = [[CMTDayilyViewController alloc] initWithNibName:@"CMTDayilyViewController" bundle:nil];
            CMTHeader *model = _dataArray[indexPath.section][indexPath.row];
            vc.name = model.theme_name;
            [self.navigationController pushViewController:vc animated:YES];
        } else if (indexPath.row == 2) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提醒" message:@"此模块工程师在玩命搭建中" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            [alertView show];
        } else if (indexPath.row == 3) {
            CMTWearController *vc = [[CMTWearController alloc] initWithNibName:@"CMTWearController" bundle:nil];
            
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
    if (indexPath.section == 1) {
        CMTNewWebController *vc = [[CMTNewWebController alloc] initWithNibName:@"CMTNewWebController" bundle:nil];
        ScrollModel *model = _dataArray[indexPath.section][indexPath.row];
        NSString *url = model.theme_link;
        vc.url = url;
        [self.navigationController pushViewController:vc animated:YES];
        
    }
    if (indexPath.section == 2) {
        CMTDetailController *vc = [[CMTDetailController alloc] init];
        CMTJXModel *model = _dataArray[indexPath.section][indexPath.row];
        vc.ID = model.ID;
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (indexPath.section == 3) {
        CMTSegController *vc = [[CMTSegController alloc] init];
        vc.name = _dataArray[indexPath.section][indexPath.row];
        if (indexPath.row == 0) {
            vc.URL = KYONUNGURL;
        } else {
            vc.URL = KOLDURL;
        }
        [self.navigationController pushViewController:vc animated:YES];
    }

}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0) {
        if (kind == UICollectionElementKindSectionHeader) {
            CMTScrollReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"ScrollHeader" forIndexPath:indexPath];
            view.delegate = self;
            if (_topArray.count > 0) {
                view.array = _topArray;
            }
            return view;
        }
    }
    
    if (indexPath.section == 1) {
        if (kind == UICollectionElementKindSectionHeader) {
            CMTHeaderReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"Header" forIndexPath:indexPath];
            view.title.text = @"活动精选";
            return view;
        }
    }
    
    
    if (indexPath.section == 2) {
        if (kind == UICollectionElementKindSectionHeader) {
            CMTHeaderReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"Header" forIndexPath:indexPath];
            view.title.text = @"帮帮精选";
            return view;
        }
    }
    if (indexPath.section == 3) {
        if (kind == UICollectionElementKindSectionHeader) {
            CMTHeaderReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"Header" forIndexPath:indexPath];
            view.title.text = @"更多精选服装";
            return view;
        }
    }
    return nil;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return CGSizeMake(KSCREENWIDTH, 150);
    }
    return CGSizeMake(self.view.frame.size.width, 40);
}

#pragma mark CMTScrollReusableView delegate
- (void)changeView:(NSInteger)index
{

    CMTNewWebController *vc = [[CMTNewWebController alloc] initWithNibName:@"CMTNewWebController" bundle:nil];
    ScrollModel *model = _headViewArray[index];
    NSString *url = model.theme_link;
    vc.url = url;
    [self.navigationController pushViewController:vc animated:YES];
    
}


@end
