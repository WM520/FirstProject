//
//  TrendyItemsViewController.m
//  CMT
//
//  Created by qianfeng on 15/12/22.
//  Copyright (c) 2015年 汪淼. All rights reserved.
//

#import "TrendyItemsViewController.h"
#import "TrendyItemsCell.h"
#import "TrendyItemsModel.h"
#import "UIBarButtonItem+HD.h"
#import "CMTDetailController.h"


@interface TrendyItemsViewController ()

@end

@implementation TrendyItemsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _currentPage = 1;
}

- (void)configUI {
    [super configUI];
    [self addTitleView:_name];
    [self addMJRefreshHasHeader:YES withHasFooter:YES];
    _tableView.backgroundColor = KBackColor;
    [_tableView registerNib:[UINib nibWithNibName:@"TrendyItemsCell" bundle:nil] forCellReuseIdentifier:@"TrendyItemsCell"];
}

- (void)reloadData {
    _currentPage = 1;
    [self loadData];
}

- (void)loadMore {
    _currentPage++;
    [self loadData];
}

- (void)loadData {
    NSString *strURL = [NSString stringWithFormat:KChaoPinZhuanQu,_currentPage];
    [[HttpManager shareManager] requestWithUrl:strURL withDictionary:nil withSuccessBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
        [_tableView.header endRefreshing];
        [_tableView.footer endRefreshing];
        if (_currentPage==1) {
            [_dataArray removeAllObjects];
        }
        NSArray *itemDetail = [responseObject objectForKey:@"data"][@"itemDetail"];
        for (NSDictionary *dict in itemDetail) {
            TrendyItemsModel *model = [[TrendyItemsModel alloc] initWithDictionary:dict error:nil];
            [_dataArray addObject:model];
        }
        [_tableView reloadData];
    } withFailureBlock:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"TrendyItemsCell";
    TrendyItemsCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    TrendyItemsModel *model = _dataArray[indexPath.row];
    cell.likesLabel.text = model.saveCount;
    cell.nameLabel.text = model.description1;
    cell.desLabel.text = model.title;
    cell.priceLabel.text = model.price;
    [cell.image sd_setImageWithURL:[NSURL URLWithString:model.pic_url]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 350;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TrendyItemsModel *model = _dataArray[indexPath.row];
    CMTDetailController *vc = [[CMTDetailController alloc] init];
    vc.ID = model._id;
    [self.navigationController pushViewController:vc animated:YES];
}



@end
