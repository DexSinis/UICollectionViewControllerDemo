//
//  CarouselView.h
//  UICollectionViewControllerDemo
//
//  Created by litt1e-p on 15/12/29.
//  Copyright © 2015年 litt1e-p. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CarouselView : UICollectionView

@property (nonatomic, strong) NSArray *imageNames;
@property (nonatomic, copy) void(^cellDidSelectItemAtIndex)(NSInteger selectedIndex);

-(void)startTimer;
-(void)updateTimer;
-(instancetype)initWithFrame:(CGRect)frame imageNames:(NSArray *)imageNames;

@end
