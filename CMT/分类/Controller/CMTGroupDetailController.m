//
//  CMTGroupDetailController.m
//  CMT
//
//  Created by qianfeng on 15/12/24.
//  Copyright © 2015年 汪淼. All rights reserved.
//

#import "CMTGroupDetailController.h"
#import "UIBarButtonItem+HD.h"
#import "UMSocial.h"
#import "DPitemModel.h"
#import "UIView+Extension.h"
#import "DPitemCell.h"
#import "CMTDetailController.h"

@interface CMTGroupDetailController () <UMSocialUIDelegate>
@property (nonatomic,strong) NSDictionary *dataDict;
@property (nonatomic, assign)CGFloat viewHeight;
@property (nonatomic, strong)NSArray *tags;
@property (nonatomic,assign) CGFloat headViewHight;
@end

@implementation CMTGroupDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"搭配详情";
    self.view.backgroundColor = [UIColor colorWithRed:184/255.0 green:233/255.0 blue:255/255.0 alpha:1];
    [self loadData];
    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (void)configUI
{
    [super configUI];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithIcon:@"ic_setting_share_app" selectedIcon:@"ic_setting_share_app" target:self action:@selector(share)];
}

- (void)loadData{
    NSString *url = [NSString stringWithFormat:KGROUPDETAIL,self.number];
    [[HttpManager shareManager]requestWithUrl:url withDictionary:nil withSuccessBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
        self.dataDict = responseObject[@"data"];
        NSArray *array = self.dataDict[@"singleItems"];
        for (NSDictionary *dict in array) {
            DPitemModel *model = [[DPitemModel alloc]initWithDict:dict];
            [_dataArray addObject:model];
        }
        [_tableView reloadData];
        [self createTableViewHeaderView];
        [self createTableViewFooderView];
    }
    withFailureBlock:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}

// 分享
- (void)share
{
    [UMSocialSnsService presentSnsIconSheetView:self appKey:KUMKEY shareText:@"这样的搭配好帅" shareImage:[UIImage imageNamed:@"icon.png"] shareToSnsNames:@[UMShareToSina,UMShareToFacebook, UMShareToEmail] delegate:self];
}

- (void)createTableViewHeaderView{
    UIView *headerView = [[UIView alloc]init];
    _headViewHight = KSCREENWIDTH * [self.dataDict[@"height"] integerValue]/[self.dataDict[@"width"] integerValue];
    headerView.frame = CGRectMake(0, 0, KSCREENWIDTH, _headViewHight+30);
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, KSCREENWIDTH, _headViewHight)];
    [imageView sd_setImageWithURL:[NSURL URLWithString:self.dataDict[@"big_image"]]];
    [headerView addSubview:imageView];
    
    UILabel *infoLB = [[UILabel alloc]initWithFrame:CGRectMake(0, _headViewHight-50, KSCREENWIDTH, 52)];
    infoLB.backgroundColor = [UIColor colorWithRed:167/255.0 green:167/255.0 blue:167/255.0 alpha:0.7];
    infoLB.text = self.dataDict[@"info"];
    infoLB.textColor = [UIColor whiteColor];
    infoLB.textAlignment = NSTextAlignmentCenter;
    infoLB.font = kFont(18);
    [headerView addSubview:infoLB];
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(12, imageView.maxY+10, 10, 10)];
    view.backgroundColor = kdpBtnColor; 
    UILabel *lianjieLB = [[UILabel alloc]initWithFrame:CGRectMake(30, imageView.maxY, KSCREENWIDTH, 30)];
    lianjieLB.backgroundColor = [UIColor clearColor];
    lianjieLB.text = @"单品购买链接";
    lianjieLB.textColor = [UIColor grayColor];
    [headerView addSubview:view];
    
    [headerView addSubview:lianjieLB];
    _tableView.tableHeaderView = headerView;
    
}

- (void)createTableViewFooderView{
    UIView *fooderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KSCREENWIDTH, 300)];
    UIView *lineView0 = [[UIView alloc]initWithFrame:CGRectMake(kMargin, kMargin/2, KSCREENWIDTH-2*kMargin, 1)];
    lineView0.backgroundColor = [UIColor grayColor];
    [fooderView addSubview:lineView0];
    _tags = self.dataDict[@"tags"];
    UILabel *long_infoLB = [[UILabel alloc]initWithFrame:CGRectMake(kMargin, kMargin, KSCREENWIDTH-2*kMargin, 200)];
    long_infoLB.text = self.dataDict[@"long_info"];
    long_infoLB.font = kFont(12);
    long_infoLB.numberOfLines=0;
    
    CGFloat long_infoLBH = [self.dataDict[@"long_info"] boundingRectWithSize:CGSizeMake(KSCREENWIDTH, MAXFLOAT) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : kFont(12)} context:nil].size.height;
    
    CGRect oldInfoFrame=long_infoLB.frame;
    oldInfoFrame.size.height=long_infoLBH;
    long_infoLB.frame=oldInfoFrame;
    
    [fooderView addSubview:long_infoLB];
    _viewHeight=long_infoLB.maxY + 100;
    
    //调整lineView高度
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(kMargin, 100, KSCREENWIDTH-2*kMargin, 1)];
    lineView.backgroundColor = [UIColor grayColor];
    CGRect oldLineViewFrame=lineView.frame;
    oldLineViewFrame.origin.y=long_infoLB.maxY + 20;
    lineView.frame=oldLineViewFrame;
    [fooderView addSubview:lineView];
    for (int i=0; i<_tags.count; i++) {
        CGFloat space=10;
        CGFloat width=50;
        CGFloat btnHeight=20;
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame=CGRectMake(i*(space + width)+5, long_infoLB.maxY + 40, width, btnHeight);
        [btn setTitle:[_tags[i] valueForKey:@"tagName"] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor colorWithRed:23/255.0 green:167/255.0 blue:188/255.0 alpha:1] forState:UIControlStateNormal];
        btn.titleLabel.font=[UIFont systemFontOfSize:12];
        btn.layer.borderColor=[UIColor colorWithRed:23/255.0 green:167/255.0 blue:188/255.0 alpha:1].CGColor;
        btn.layer.borderWidth=1;
        btn.layer.cornerRadius=10;
        [fooderView addSubview:btn];
        
        CGRect selfViewFrame=fooderView.frame;
        selfViewFrame.size.height=long_infoLB.maxY  + 80;
        fooderView.frame=selfViewFrame;
    }
    
    _tableView.tableFooterView = fooderView;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DPitemCell *cell = [DPitemCell cellInitWithTableView:tableView];
    cell.model = _dataArray[indexPath.row];
    cell.selectionStyle = 0;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return [DPitemCell cellHight];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    DPitemModel *model = _dataArray[indexPath.row];
    CMTDetailController *dtVC = [[CMTDetailController alloc]init];
    dtVC.ID = [NSNumber numberWithInteger:[model.item_id integerValue]];
    
    [self.navigationController pushViewController:dtVC animated:YES];
    
    
}



@end
