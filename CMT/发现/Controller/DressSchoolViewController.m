//
//  DressSchoolViewController.m
//  CMT
//
//  Created by qianfeng on 15/12/21.
//  Copyright (c) 2015年 汪淼. All rights reserved.
//

#import "DressSchoolViewController.h"
#import "DressSchoolCell.h"
#import "DressSchoolModel.h"
#import "CMTWebController.h"
#import "UIBarButtonItem+HD.h"
#import "UMSocial.h"

@interface DressSchoolViewController ()<UMSocialUIDelegate>

@end

@implementation DressSchoolViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)configUI {
    [super configUI];
    _currentPage = 1;
    
    [self addTitleView:_name];
    [self addMJRefreshHasHeader:YES withHasFooter:YES];
    [_tableView registerNib:[UINib nibWithNibName:@"DressSchoolCell" bundle:nil] forCellReuseIdentifier:@"DressSchoolCell"];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithIcon:@"ic_setting_share_app" selectedIcon:@"ic_setting_share_app" target:self action:@selector(share)];
}

// 分享
- (void)share
{
    [UMSocialSnsService presentSnsIconSheetView:self appKey:KUMKEY shareText:@"这样的搭配好帅" shareImage:[UIImage imageNamed:@"icon.png"] shareToSnsNames:@[UMShareToSina,UMShareToFacebook, UMShareToEmail] delegate:self];
}



- (void)loadData {
    NSString *strURL = [NSString stringWithFormat:KChuanYiXueTang,_currentPage];
    [[HttpManager shareManager] requestWithUrl:strURL withDictionary:nil withSuccessBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
        [_tableView.header endRefreshing];
        [_tableView.footer endRefreshing];
        if (_currentPage==1) {
            [_dataArray removeAllObjects];
        }
        NSArray *data = [responseObject objectForKey:@"data"];
        for (NSDictionary *dict in data) {
            DressSchoolModel *model = [[DressSchoolModel alloc] initWithDictionary:dict error:nil];
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
    _currentPage++;
    [self loadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"DressSchoolCell";
    DressSchoolCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    DressSchoolModel *model = _dataArray[indexPath.row];
    cell.titieLabel.text = model.title;
    cell.desLabel.text = model.info;
    [cell.image sd_setImageWithURL:[NSURL URLWithString:model.image]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 240;
} 

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CMTWebController *vc = [[CMTWebController alloc] init];
    DressSchoolModel *model = _dataArray[indexPath.row];
    vc.ID = model.dress_school_id;
    
    [self.navigationController pushViewController:vc animated:YES];
}

@end
