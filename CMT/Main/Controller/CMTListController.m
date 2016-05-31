//
//  CMTListController.m
//  CMT
//
//  Created by qianfeng on 16/12/17.
//  Copyright (c) 2016年 汪淼. All rights reserved.
//

#import "CMTListController.h"

@interface CMTListController ()

@end

@implementation CMTListController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _dataArray=[NSMutableArray new];
    [self configUI];
}

-(void)configUI{
    NSLog(@"父类的configUI被调用了");
    self.automaticallyAdjustsScrollViewInsets=NO;
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 64, KSCREENWIDTH, KSCREENHEIGHT- 64) style:UITableViewStylePlain];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.backgroundColor = KBackColor;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
}

-(void)loadData{
    NSLog(@"子类需要重写loadData方法");
}

#pragma mark 下拉刷新，上拉加载更多

-(void)addMJRefreshHasHeader:(BOOL)isHavHeader withHasFooter:(BOOL)isHavFooter{
    if (isHavHeader) {
        _tableView.header=[MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(reloadData)];
        //开始加载
        [_tableView.header beginRefreshing];
    }
    if (isHavFooter) {
        _tableView.footer=[MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMore)];
    }
}

-(void)reloadData{
    NSLog(@"重新加载数据，子类需要重写");
}
-(void)loadMore{
    NSLog(@"加载更多，子类需要重写");
}

#pragma mark tableView的代理方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSLog(@"子类需要重写numberOfRowsInSection:这个方法");
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"子类需要重写cellForRowAtIndexPath:方法");
    return nil;
}

@end
