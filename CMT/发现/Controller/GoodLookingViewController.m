//
//  GoodLookingViewController.m
//  CMT
//
//  Created by qianfeng on 15/12/22.
//  Copyright (c) 2015年 汪淼. All rights reserved.
//

#import "GoodLookingViewController.h"
#import "GoodLookingCell.h"
#import "GoodLookingModel.h"
#import "UIBarButtonItem+HD.h"

@interface GoodLookingViewController ()

@end

@implementation GoodLookingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)configUI {
    [super configUI];
    _currentPage = 1;
    
    [self addTitleView:_name];
    [self addMJRefreshHasHeader:YES withHasFooter:YES];
    
    [_tableView registerNib:[UINib nibWithNibName:@"GoodLookingCell" bundle:nil] forCellReuseIdentifier:@"GoodLookingCell"];

}


- (void)loadData {
    NSString *strURL = [NSString stringWithFormat:KHaoKanMe,_currentPage];
    [[HttpManager shareManager] requestWithUrl:strURL withDictionary:nil withSuccessBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
        [_tableView.header endRefreshing];
        [_tableView.footer endRefreshing];
        if (_currentPage==1) {
            [_dataArray removeAllObjects];
        }
        NSArray *data = [responseObject objectForKey:@"data"];
        for (NSDictionary *dict in data) {
            GoodLookingModel *model = [[GoodLookingModel alloc] initWithDictionary:dict error:nil];
            [_dataArray addObject:model];
        }
        [_tableView reloadData];
    } withFailureBlock:^(AFHTTPRequestOperation *operation, NSError *error) {
        [_tableView.header endRefreshing];
        [_tableView.footer endRefreshing];
    }];
    
}

- (void)reloadData {
    _currentPage = 1;
    [self loadData];
}

- (void)loadMore {
    _currentPage += 2;
    [self loadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"GoodLookingCell";
    GoodLookingCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    GoodLookingModel *model = _dataArray[indexPath.row];
    [cell.iconImage sd_setImageWithURL:[NSURL URLWithString:model.head_pic]];
    cell.nameLabel.text = model.nick_name;
    cell.timeLabel.text = model.create_time;
    [cell.image sd_setImageWithURL:[NSURL URLWithString:model.image]];
    cell.contentLabel.text = model.comment;
    cell.likesLabel.text = model.like_count;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 420;
}


@end
