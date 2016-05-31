//
//  CMTDetailController.m
//  CMT
//
//  Created by qianfeng on 15/12/22.
//  Copyright © 2015年 汪淼. All rights reserved.
//

#import "CMTDetailController.h"
#import "UIView+Extension.h"
#import "UIBarButtonItem+HD.h"
#import "UMSocial.h"
#import "CMTUserComment.h"
#import "WebController.h"


@interface CMTDetailController () <UMSocialUIDelegate, UITableViewDataSource, UITableViewDelegate>
{
    UIButton *_xinxiLB;
    UIButton *_pinglunLB;
    NSDictionary *_dict;
    NSMutableArray *_userArray;
    NSInteger _count;
    NSMutableArray *_dataArray;
    UITableView *_tableView;
}

@property (nonatomic,strong)UIScrollView *topScrollerView;
@property (nonatomic,strong)UIView *titleView;
@property (nonatomic,strong)NSArray *picArr;
@property (nonatomic,weak)NSString *picUrls;
@property (nonatomic,strong)NSTimer *timer;
@end

@implementation CMTDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = KBackColor;
    _userArray = [NSMutableArray array];
    _dataArray = [NSMutableArray array];
    _count = 1;
    [self loadData];
    [self configUI];
    [self loadUserData];
    [self setTianMaoView];
}

- (void)configUI
{
    self.automaticallyAdjustsScrollViewInsets=NO;
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 64, KSCREENWIDTH, KSCREENHEIGHT- 30 - 64) style:UITableViewStylePlain];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.backgroundColor = KBackColor;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    self.title = @"商品详情";
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithIcon:@"ic_setting_share_app" selectedIcon:@"ic_setting_share_app" target:self action:@selector(share)];
    [_tableView registerNib:[UINib nibWithNibName:@"CMTUserCell" bundle:nil] forCellReuseIdentifier:@"cell"];
}

- (void)createTopScroller{
    self.topScrollerView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, KSCREENWIDTH, 320)];
    self.topScrollerView.showsHorizontalScrollIndicator = NO;
    self.topScrollerView.showsVerticalScrollIndicator = NO;
    self.topScrollerView.contentSize = CGSizeMake(_picArr.count*KSCREENWIDTH, 0);
    self.topScrollerView.pagingEnabled = YES;
    self.topScrollerView.bounces = NO;
    
    for (int i = 0; i< _picArr.count; i ++) {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(i*KSCREENWIDTH, 0, KSCREENWIDTH, 320)];
        imageView.userInteractionEnabled = YES;
        [imageView sd_setImageWithURL:[NSURL URLWithString:_picArr[i]]];
        [self.topScrollerView addSubview:imageView];
    }
    _tableView.tableHeaderView = self.topScrollerView;
    
    self.titleView = [[UIView alloc]initWithFrame:CGRectMake(0,  280,KSCREENWIDTH, 40)];
    _titleView.backgroundColor = kColor;
    _titleView.alpha = 0.63;
    [_tableView addSubview:_titleView];
    
    UILabel *titleLB = [[UILabel alloc]initWithFrame:CGRectMake(kMargin, kMargin, KSCREENWIDTH - 2*kMargin, 3*kMargin)];
    titleLB.backgroundColor = [UIColor clearColor];
    titleLB.text = _dict[@"title"];
    titleLB.font = [UIFont systemFontOfSize:12];
    titleLB.textColor = [UIColor whiteColor];
    titleLB.numberOfLines = 2;
    [_titleView addSubview:titleLB];
    [self timer_on];
}

-(void)timer_on
{
    _timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(imageChange) userInfo:nil repeats:YES] ;
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes] ;
}

-(void)imageChange
{
    int i = (self.topScrollerView.frame.size.width*0.5 + self.topScrollerView.contentOffset.x)/self.topScrollerView.frame.size.width ;
    if (i == _picArr.count-1)
    {
        i = -1 ;
    }
    i++ ;
    //设置偏移位置
    [self.topScrollerView setContentOffset:CGPointMake(i*KSCREENWIDTH, 0) animated:YES];
}
//关闭定时器
-(void)timer_off
{
    [self.timer invalidate];
    self.timer = nil ;
}
//当用户准备拖拽的时候，关闭定时器
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self timer_off];
}
//当用户停止拖拽的时候，添加一个定时器
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self timer_on];
}

// 分享
- (void)share
{
    NSString *urlStr = [NSString stringWithFormat:KDETAILURL, [self.ID integerValue]];
    [UMSocialSnsService presentSnsIconSheetView:self appKey:KUMKEY shareText:urlStr shareImage:[UIImage imageNamed:@"icon.png"] shareToSnsNames:@[UMShareToSina,UMShareToFacebook, UMShareToEmail] delegate:self];
}

- (void)loadData
{
    NSString *urlStr = [NSString stringWithFormat:KDETAILURL, [self.ID integerValue]];
    [[HttpManager shareManager]requestWithUrl:urlStr withDictionary:nil withSuccessBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
        _dict = responseObject[@"data"];
       
        self.picUrls = _dict[@"pic_urls"];
        self.picArr = [self.picUrls componentsSeparatedByString:@","];
        //        NSLog(@"%@",self.picArr);
        [_tableView reloadData];
        
        [self createTopScroller];
    } withFailureBlock:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}

- (void)loadUserData
{
    NSString *userUrl = [NSString stringWithFormat:KSOURCEURL, [self.ID integerValue]];
    [[HttpManager shareManager] requestWithUrl:userUrl withDictionary:nil withSuccessBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSArray *array = responseObject[@"data"][@"comments"];
        for (NSDictionary *dic in array) {
            CMTUserComment *model = [[CMTUserComment alloc] initWithDictionary:dic error:nil];
            [_userArray addObject:model];
        }
        
    } withFailureBlock:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}

- (void)setTianMaoView{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, KSCREENHEIGHT- 50, KSCREENWIDTH, 50)];
    view.backgroundColor = [UIColor whiteColor];
    view.alpha = 0.8;
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KSCREENWIDTH, 2)];
    lineView.backgroundColor = [UIColor grayColor];
    [view addSubview:lineView];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(3*kMargin, kMargin, 150, 30)];
    label.text = @"天猫正品 放心购买";
    label.textColor = kColor;
    [view addSubview:label];
    
    UIButton *tmBtn = [[UIButton alloc]initWithFrame:CGRectMake(label.maxX+2*kMargin, kMargin, KSCREENWIDTH/3, 3*kMargin)];
    tmBtn.layer.cornerRadius = 10;
    tmBtn.layer.masksToBounds = YES;
    tmBtn.backgroundColor = [UIColor redColor];
    [tmBtn setTitle:@"去天猫购买" forState:UIControlStateNormal];
    [tmBtn addTarget:self action:@selector(gotoTianMao:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:tmBtn];
    [self.view addSubview:view];
}

- (void)gotoTianMao:(id)sender{
    WebController *webVC = [[WebController alloc]init];
    webVC.url = _dict[@"purchaseLink"];
    [self.navigationController pushViewController:webVC animated:YES];
}

#pragma mark tableView delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 3;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        return 2;
    }else if (section == 1){
        return 1;
    }else{
            return 6;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
            UILabel *priceLB = [[UILabel alloc]initWithFrame:CGRectMake(2*kMargin, kMargin, 40, 15)];
            priceLB.text = @"价格:";
            priceLB.font = [UIFont systemFontOfSize:14];
            [cell addSubview:priceLB];
            
            UILabel *couponPriceLB = [[UILabel alloc]initWithFrame:CGRectMake(priceLB.maxX, kMargin, 70, 15)];
            couponPriceLB.text = [NSString stringWithFormat:@"￥%@",_dict[@"coupon_price"]];
            couponPriceLB.textColor = [UIColor redColor];
            couponPriceLB.font = [UIFont systemFontOfSize:14];
            couponPriceLB.textAlignment = NSTextAlignmentLeft;
            [cell addSubview:couponPriceLB];
            
            UILabel *ppriceLB = [[UILabel alloc]initWithFrame:CGRectMake(couponPriceLB.maxX+kMargin, kMargin, 60, 15)];
            ppriceLB.text = _dict[@"price"];
            ppriceLB.textColor = [UIColor grayColor];
            ppriceLB.font = [UIFont systemFontOfSize:11];
            ppriceLB.textAlignment = NSTextAlignmentLeft;
            [cell addSubview:ppriceLB];
            
            UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(couponPriceLB.maxX+kMargin, 1.8*kMargin, 40, 0.8)];
            lineView.backgroundColor = [UIColor grayColor];
            [cell addSubview:lineView];
            
            if (_dict[@"zhekou"]) {
                UILabel *zhoukouLB = [[UILabel alloc]initWithFrame:CGRectMake(ppriceLB.maxX, kMargin, 80, 15)];
                zhoukouLB.text = _dict[@"zhekou"];
                zhoukouLB.textColor = [UIColor grayColor];
                zhoukouLB.font = [UIFont systemFontOfSize:12];
                zhoukouLB.textAlignment = NSTextAlignmentLeft;
                [cell addSubview:zhoukouLB];
            }
            
            cell.selectionStyle = 0;
            return cell;
        }
        if (indexPath.row==1) {
            
            UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
            
            UILabel *tuijianLB = [[UILabel alloc]initWithFrame:CGRectMake(3*kMargin, kMargin, 70, 15)];
            tuijianLB.text = @"穿穿推荐";
            tuijianLB.textColor = kColor;
            tuijianLB.font = [UIFont systemFontOfSize:14];
            tuijianLB.textAlignment = NSTextAlignmentLeft;
            [cell addSubview:tuijianLB];
            
            UILabel *chimaLB = [[UILabel alloc]initWithFrame:CGRectMake(tuijianLB.maxX+ kMargin, kMargin+1, 70, 15)];
            chimaLB.text = @"衣服尺码:";
            chimaLB.textColor = [UIColor grayColor];
            chimaLB.font = [UIFont systemFontOfSize:13];
            chimaLB.textAlignment = NSTextAlignmentLeft;
            [cell addSubview:chimaLB];
            
            UILabel *sizeLB = [[UILabel alloc]initWithFrame:CGRectMake(chimaLB.maxX, kMargin+1, 40, 15)];
            sizeLB.text = [NSString stringWithFormat:@"%@",_dict[@"size"]];
            sizeLB.textColor = kColor;
            sizeLB.font = [UIFont systemFontOfSize:13];
            sizeLB.textAlignment = NSTextAlignmentCenter;
            [cell addSubview:sizeLB];
            
            UILabel *cankaoLB = [[UILabel alloc]initWithFrame:CGRectMake(sizeLB.maxX, kMargin+1, 100, 15)];
            cankaoLB.text = @"仅供参考";
            cankaoLB.textColor = [UIColor grayColor];
            cankaoLB.font = [UIFont systemFontOfSize:13];
            cankaoLB.textAlignment = NSTextAlignmentCenter;
            [cell addSubview:cankaoLB];
            
            cell.selectionStyle = 0;
            return cell;
        }
        
    }
    if (indexPath.section == 1){
        UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        _xinxiLB = [[UIButton alloc]initWithFrame:CGRectMake(kMargin, 15, 140 *KRATE, 15)];
        [_xinxiLB setTitle:@"商品信息" forState:UIControlStateNormal];
        [_xinxiLB setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [_xinxiLB setTitleColor:kColor forState:UIControlStateSelected];
        _xinxiLB.titleLabel.font = [UIFont systemFontOfSize:15];
        _xinxiLB.titleLabel.textAlignment = NSTextAlignmentCenter;

        [cell addSubview:_xinxiLB];
        
        
        cell.selectionStyle = 0;
        return cell;
    }
        if (indexPath.section == 2) {
            
            UITableViewCell *cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
            
            UILabel *leftLabel=[[UILabel alloc]init];
            leftLabel.frame=CGRectMake(20, 0, 100, 30);
            leftLabel.textColor=[UIColor grayColor];
            leftLabel.textAlignment=NSTextAlignmentLeft;
            leftLabel.font=[UIFont systemFontOfSize:12];
            [cell addSubview:leftLabel];
            
            UILabel *rightLabel=[[UILabel alloc]init];
            rightLabel.frame=CGRectMake(self.view.bounds.size.width-20-200, 0, 200, 30);
            rightLabel.textColor=kColor;
            rightLabel.textAlignment=NSTextAlignmentRight;
            rightLabel.font=[UIFont systemFontOfSize:12];
            [cell addSubview:rightLabel];
            
            switch (indexPath.row) {
                case 0:
                {
                    leftLabel.text=@"品牌名称:";
                    rightLabel.text=_dict[@"brand"];
                }
                    break;
                case 1:
                {
                    leftLabel.text=@"材质:";
                    rightLabel.text=_dict[@"material"];
                }
                    break;
                case 2:
                {
                    leftLabel.text=@"基础风格:";
                    rightLabel.text=_dict[@"style"];
                }
                    break;
                case 3:
                {
                    leftLabel.text=@"货号:";
                    rightLabel.text=_dict[@"num_iid"];
                }
                    break;
                case 4:
                {
                    leftLabel.text=@"款式颜色:";
                    rightLabel.text=_dict[@"color"];
                }
                    break;
                case 5:
                {
                    leftLabel.text=@"适用季节:";
                    rightLabel.text=_dict[@"season"];
                }
                    break;
                    
                default:
                    break;
            }
            
            cell.selectionStyle=0;
            return cell;
        }
    return nil;
}




- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section==2){
        return 30;
    }
    else{
        return 40;
    }
}
//设置组头高度


-(CGFloat )tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
    
}
//设置组尾高度
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 15;
    
}
//设置组尾背景
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view=[[UIView alloc]init];
    view.backgroundColor=[UIColor colorWithRed:236/255.0 green:236/255.0 blue:236/255.0 alpha:1];
    return view;
    
}

@end

