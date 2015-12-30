//
//  CalendarHeaderReusableView.h
//  UICollectionViewControllerDemo
//
//  Created by litt1e-p on 15/12/30.
//  Copyright © 2015年 litt1e-p. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CalendarHeaderReusableView : UICollectionReusableView

@property (nonatomic, weak) NSDate *date;
+ (CGFloat)height;

@end
