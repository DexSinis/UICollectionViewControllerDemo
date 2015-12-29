//
//  WaterFlowViewLayout2.h
//  UICollectionViewControllerDemo
//
//  Created by litt1e-p on 15/12/29.
//  Copyright © 2015年 litt1e-p. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WaterFlowViewLayout2;

@protocol WaterFlowViewLayout2Delegate <NSObject>

@required
- (CGFloat)waterflowLayout:(WaterFlowViewLayout2 *)waterflowLayout heightForItemAtIndex:(NSUInteger)index itemWidth:(CGFloat)itemWidth;

@optional
- (CGFloat)columnCountInWaterflowLayout:(WaterFlowViewLayout2 *)waterflowLayout;
- (CGFloat)columnMarginInWaterflowLayout:(WaterFlowViewLayout2 *)waterflowLayout;
- (CGFloat)rowMarginInWaterflowLayout:(WaterFlowViewLayout2 *)waterflowLayout;
- (UIEdgeInsets)edgeInsetsInWaterflowLayout:(WaterFlowViewLayout2 *)waterflowLayout;

@end

@interface WaterFlowViewLayout2 : UICollectionViewFlowLayout

@property (nonatomic, weak) id<WaterFlowViewLayout2Delegate> delegate;

@end
