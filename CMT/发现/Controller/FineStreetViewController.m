//
//  FineStreetViewController.m
//  CMT
//
//  Created by qianfeng on 15/12/22.
//  Copyright (c) 2015年 汪淼. All rights reserved.
//

#import "FineStreetViewController.h"
#import "FineStreetViewController1.h"
#import "FineStreetViewController2.h"
#import "FineStreetViewController3.h"
#import "UIBarButtonItem+HD.h"
#import "SegmentTapView.h"
#import "FlipTableView.h"


@interface FineStreetViewController () <SegmentTapViewDelegate,FlipTableViewDelegate>

@property (nonatomic, strong)SegmentTapView *segment;
@property (nonatomic, strong)FlipTableView *flipView;
@property (strong, nonatomic) NSMutableArray *controllsArray;
@end

@implementation FineStreetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addTitleView:_name];
  
    [self initFlipTableView];
}

-(void)initFlipTableView
{
   
    NSArray *array = @[@"9块9",@"19块9",@"29块9"];
    self.segment = [[SegmentTapView alloc] initWithFrame:CGRectMake(0, 64, KSCREENWIDTH, 40) withDataArray:array withFont:15];
    self.segment.delegate = self;
    [self.view addSubview:self.segment];
    if (!self.controllsArray) {
        self.controllsArray = [[NSMutableArray alloc] init];
    }
    // 1
    FineStreetViewController1 *vc1 = [[FineStreetViewController1 alloc] init];
    vc1.changBlock = ^(UIViewController *vc) {
        [self.navigationController pushViewController:vc animated:YES];
    };
    FineStreetViewController2 *vc2 = [[FineStreetViewController2 alloc] init];
    vc2.changBlock = ^(UIViewController *vc) {
        [self.navigationController pushViewController:vc animated:YES];
    };
    FineStreetViewController3 *vc3 = [[FineStreetViewController3 alloc] init];
    vc3.changBlock = ^(UIViewController *vc) {
        [self.navigationController pushViewController:vc animated:YES];
    };

    [self.controllsArray addObject:vc1];
    [self.controllsArray addObject:vc2];
    [self.controllsArray addObject:vc3];

    
    self.flipView = [[FlipTableView alloc] initWithFrame:CGRectMake(0, 104, KSCREENWIDTH, [UIApplication sharedApplication].keyWindow.bounds.size.height - 104) withArray:_controllsArray];
    self.flipView.delegate = self;
    [self.view addSubview:self.flipView];
}

#pragma mark -------- select Index
-(void)selectedIndex:(NSInteger)index
{
    [self.flipView selectIndex:index];
    
}
-(void)scrollChangeToIndex:(NSInteger)index
{
    [self.segment selectIndex:index];
}


@end
