//
//  CMTListController.h
//  CMT
//
//  Created by qianfeng on 16/12/17.
//  Copyright (c) 2016年 汪淼. All rights reserved.
//

#import "CMTRootController.h"
#import "MJRefresh.h"
#import "UIImageView+WebCache.h"

@interface CMTListController : CMTRootController <UITableViewDelegate, UITableViewDataSource>

{
    UITableView *_tableView;
    NSMutableArray *_dataArray;
    NSInteger _currentPage;//记录当前页
    NSString *_type;
}

-(void)configUI;
-(void)loadData;
//是否用上下拉刷新
-(void)addMJRefreshHasHeader:(BOOL)isHavHeader withHasFooter:(BOOL)isHavFooter;
-(void)loadMore;
-(void)reloadData;

@end
