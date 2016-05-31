//
//  CMTScrollReusableView.h
//  CMT
//
//  Created by qianfeng on 15/12/28.
//  Copyright © 2015年 汪淼. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDCycleScrollView.h"


@protocol CMTScrollReusableViewDelegate <NSObject>

- (void)changeView:(NSInteger )index;

@end


@interface CMTScrollReusableView : UICollectionReusableView <SDCycleScrollViewDelegate>

@property (nonatomic, copy) NSArray *array;

@property (nonatomic, weak) id<CMTScrollReusableViewDelegate> delegate;

@end
