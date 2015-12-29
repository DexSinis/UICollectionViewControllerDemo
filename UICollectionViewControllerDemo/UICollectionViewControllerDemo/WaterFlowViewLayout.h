//
//  WaterFlowViewLayout.h
//  UICollectionViewControllerDemo
//
//  Created by litt1e-p on 15/12/29.
//  Copyright © 2015年 litt1e-p. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WaterFlowViewLayout;

@protocol WaterFlowViewLayoutDelegate <UICollectionViewDelegateFlowLayout>

@required

- (NSInteger)collectionView:(UICollectionView *)collectionView
                     layout:(WaterFlowViewLayout *)layout
   numberOfColumnsInSection:(NSInteger)section;

@end

@interface WaterFlowViewLayout : UICollectionViewFlowLayout

@property (nonatomic, weak) id<WaterFlowViewLayoutDelegate> delegate;
@property (nonatomic, assign) BOOL enableStickyHeaders;

@end
