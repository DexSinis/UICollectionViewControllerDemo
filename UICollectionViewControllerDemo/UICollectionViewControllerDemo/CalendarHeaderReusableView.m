//
//  CalendarHeaderReusableView.m
//  UICollectionViewControllerDemo
//
//  Created by litt1e-p on 15/12/30.
//  Copyright © 2015年 litt1e-p. All rights reserved.
//

#import "CalendarHeaderReusableView.h"
#import "NSDate+Calendar.h"

@interface CalendarHeaderReusableView()

@property (nonatomic, strong) UILabel *monthLabel;

@end

@implementation CalendarHeaderReusableView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor groupTableViewBackgroundColor];
        self.monthLabel      = [[UILabel alloc] init];
        self.monthLabel.font = [UIFont systemFontOfSize:14];
        [self addSubview:self.monthLabel];
    }
    return self;
}

+ (CGFloat)height
{
    return 30;
}

+ (NSDateFormatter *)formatter
{
    static NSDateFormatter *formatter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = [NSDateFormatter dateFormatFromTemplate:@"yyyyMMM"
                                                               options:0
                                                                locale:[NSLocale currentLocale]];
    });
    return formatter;
}

- (void)setDate:(NSDate *)date
{
    _date                = date;
    self.monthLabel.text = [self.class.formatter stringFromDate:date];
    [self setNeedsLayout];
}

- (void)layoutSubviews
{
    [self.monthLabel sizeToFit];
    self.monthLabel.center = CGPointMake(self.monthLabel.center.x, CGRectGetHeight(self.bounds) / 2);
}

@end
