//
//  CMTHeaderReusableView.h
//  CMT
//
//  Created by qianfeng on 15/12/23.
//  Copyright © 2015年 汪淼. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "SDCycleScrollView.h"

@interface CMTHeaderReusableView : UICollectionReusableView

//@property (nonatomic, strong)  SDCycleScrollView *headView;
//
//
//@property (nonatomic, copy) NSArray *array;

@property (weak, nonatomic) IBOutlet UILabel *title;

@end
