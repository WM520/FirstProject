//
//  CMTScrollReusableView.m
//  CMT
//
//  Created by qianfeng on 15/12/28.
//  Copyright © 2015年 汪淼. All rights reserved.
//

#import "CMTScrollReusableView.h"
#import "UIImageView+WebCache.h"
#import "ScrollModel.h"
#define KWidth self.bounds.size.width
#define Kheight  self.bounds.size.height

@interface CMTScrollReusableView () <UIScrollViewDelegate>
{
    UIScrollView *_headScrollView;
}

@property (nonatomic, strong) SDCycleScrollView *cycleScrollView;
@end


@implementation CMTScrollReusableView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void)setArray:(NSArray *)array
{
    _array = array;
    self.cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0,self.bounds.size.width, self.bounds.size.height) imageURLStringsGroup:array];
    self.cycleScrollView.infiniteLoop = YES;
    
    self.cycleScrollView.delegate = self;
    
    self.cycleScrollView.dotColor = [UIColor orangeColor];
    
    self.cycleScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleClassic;

    [self addSubview:self.cycleScrollView];
    
}

#pragma mark  cycleScrollView delegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index

{
    [self.delegate changeView:index];
}

@end
