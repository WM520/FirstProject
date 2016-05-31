//
//  CMTWearController.m
//  CMT
//
//  Created by qianfeng on 16/1/4.
//  Copyright © 2016年 汪淼. All rights reserved.
//

#import "CMTWearController.h"
#import "Define.h"
#import "CMTWearCell.h"
#import "CMTWearModel.h"
#import "UIBarButtonItem+HD.h"
#import "UMSocial.h"
#import "CMTGroupDetailController.h"


@interface CMTWearController () <UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UMSocialUIDelegate>
{
    UICollectionView *_collectionView;
    NSMutableArray *_dataArray;
}
@end

@implementation CMTWearController

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataArray = [NSMutableArray array];
    [self loadData];
    [self configUI];
}

- (void)configUI
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    NSLog(@"子类需要重写configUI，且需要调用父类的configUI");
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumInteritemSpacing = 10;
    flowLayout.minimumLineSpacing = 20;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 64, KSCREENWIDTH, KSCREENHEIGHT - 64) collectionViewLayout:flowLayout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_collectionView];
    
    // 注册cell
    [_collectionView registerNib:[UINib nibWithNibName:@"CMTWearCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithIcon:@"ic_setting_share_app" selectedIcon:@"ic_setting_share_app" target:self action:@selector(share)];
}

// 分享
- (void)share
{
    [UMSocialSnsService presentSnsIconSheetView:self appKey:KUMKEY shareText:@"这样的搭配好帅" shareImage:[UIImage imageNamed:@"icon.png"] shareToSnsNames:@[UMShareToSina,UMShareToFacebook, UMShareToEmail] delegate:self];
}


// 加载数据
- (void)loadData
{
    [[HttpManager shareManager] requestWithUrl:KDayWearUrl withDictionary:nil withSuccessBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSArray *array = responseObject[@"data"];
        
        for (NSDictionary *dic in array) {
            CMTWearModel *model = [[CMTWearModel alloc] initWithDictionary:dic error:nil];
            
            [_dataArray addObject:model];
            
        }
        [_collectionView reloadData];
    } withFailureBlock:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}


#pragma mark -collectionView delegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cell";
    CMTWearCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    CMTWearModel *model = _dataArray[indexPath.row];
    NSDictionary *dic = model.match;
    [cell.bigImageView sd_setImageWithURL:dic[@"big_image"]];
    if (indexPath.row ==0) {
       cell.day.text = @"今天";
    } else {
        cell.day.text = @"明天";
    }
    cell.minTemperature.text = model.lowtemp;
    cell.maxTemperature.text = model.hightemp;
    cell.detailLabel.text = dic[@"long_info"];
    cell.locationLabel.text = model.city_name;
    cell.weatherLabel.text = model.weather_type;
     
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(250, 450);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 30, 0, 30);
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    CMTGroupDetailController *vc = [[CMTGroupDetailController alloc] initWithNibName:@"CMTGroupDetailController" bundle:nil];
    CMTWearModel *model = _dataArray[indexPath.row];
    NSDictionary *dic = model.match;
    vc.number = [dic[@"collocation_id"] integerValue];
    
    [self.navigationController pushViewController:vc animated:YES];
}


@end
