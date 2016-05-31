//
//  CMTFindController.m
//  CMT
//
//  Created by qianfeng on 16/12/17.
//  Copyright (c) 2016年 汪淼. All rights reserved.
//

#import "CMTFindController.h"
#import "FindCell.h"
#import "FindModel.h"
#import "FineStreetViewController.h"
#import "TrendyItemsViewController.h"
#import "DressSchoolViewController.h"
#import "LoversSpaceViewController.h"
#import "GoodLookingViewController.h"
@interface CMTFindController ()

@end

@implementation CMTFindController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addTitleView:@"发现"];
}
- (void)configUI {
    [super configUI];
    [self loadData];
    [_tableView registerNib:[UINib nibWithNibName:@"FindCell" bundle:nil] forCellReuseIdentifier:@"FindCell"];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)loadData {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Find.plist" ofType:nil];
    NSArray *array = [NSMutableArray arrayWithContentsOfFile:path];
    for (NSDictionary *dict in array) {
        FindModel *model = [[FindModel alloc] initWithDictionary:dict error:nil];
        [_dataArray addObject:model];
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"FindCell";
    FindCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    FindModel *model = _dataArray[indexPath.row];
    cell.nameLabel.text = model.name;
    cell.desLabel.text = model.describe;
    cell.imageView.image = [UIImage imageNamed:model.image];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    switch (indexPath.row) {
        case 0:{
            FindModel *model = _dataArray[0];
            FineStreetViewController *FSVC = [[FineStreetViewController alloc] init];
            FSVC.name = model.name;
            FSVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:FSVC animated:YES];
        }
            break;
        case 1:{
            FindModel *model = _dataArray[1];
            TrendyItemsViewController *TIVC = [[TrendyItemsViewController alloc] init];
            TIVC.name = model.name;
            TIVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:TIVC animated:YES];
        }
            break;
        case 2:{
            FindModel *model = _dataArray[2];
            LoversSpaceViewController *LSVC = [[LoversSpaceViewController alloc] init];
            LSVC.name = model.name;
            LSVC.URL = KQingLvKongJian;
            LSVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:LSVC animated:YES];
        }
            break;
        case 3:{
            FindModel *model = _dataArray[3];
            DressSchoolViewController *DSVC = [[DressSchoolViewController alloc] init];
            DSVC.name = model.name;
            DSVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:DSVC animated:YES];
        }
            break;
        case 4:{
            FindModel *model = _dataArray[4];
            GoodLookingViewController *GLVC = [[GoodLookingViewController alloc] init];
            GLVC.name = model.name;
            GLVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:GLVC animated:YES];
        }
            break;
            
        default:
            break;
    }
}

@end
