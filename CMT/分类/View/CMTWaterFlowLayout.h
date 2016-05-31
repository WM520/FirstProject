//
//  CMTWaterFlowLayout.h
//  CMT
//
//  Created by qianfeng on 15/12/20.
//  Copyright (c) 2015年 汪淼. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CMTWaterFlowLayout;
@protocol CMTWaterFlowLayoutDelegate <NSObject>

-(CGFloat)ZWwaterFlow:(CMTWaterFlowLayout*)waterFlow heightForWidth:(CGFloat)width atIndexPath:(NSIndexPath*)indexPath;

@end



@interface CMTWaterFlowLayout : UICollectionViewFlowLayout

@property(nonatomic,assign)UIEdgeInsets inset;
@property(nonatomic,assign)CGFloat rowMagrin;
@property(nonatomic,assign)CGFloat colMagrin;
@property(nonatomic,assign)CGFloat colCount;
@property(nonatomic,weak)id<CMTWaterFlowLayoutDelegate>degelate;

@end
