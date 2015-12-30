//
//  NSDate+Calendar.h
//  UICollectionViewControllerDemo
//
//  Created by litt1e-p on 15/12/30.
//  Copyright © 2015年 litt1e-p. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Calendar)

- (NSInteger)year;
- (NSInteger)month;
- (NSInteger)day;
- (NSDate *)prevMonth;
- (NSDate *)nextMonth;
- (NSDate *)dateByAddingMonth:(NSInteger)month;
- (NSDate *)firstDateOfMonth;
- (NSInteger)firstWeekdayOfMonth;
- (NSInteger)columnForFirstDayInMonth;
- (NSInteger)numberOfWeeksInMonth;
- (NSInteger)numberOfDaysInMonth;

@end
