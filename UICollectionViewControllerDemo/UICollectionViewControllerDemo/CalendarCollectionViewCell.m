//
//  CalendarCollectionViewCell.m
//  UICollectionViewControllerDemo
//
//  Created by litt1e-p on 15/12/30.
//  Copyright © 2015年 litt1e-p. All rights reserved.
//

#import "CalendarCollectionViewCell.h"

@interface CalendarCollectionViewCell()

@property (nonatomic, strong) UILabel *dayLabel;

@end

@implementation CalendarCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.dayLabel = [[UILabel alloc] initWithFrame:self.bounds];
        self.dayLabel.font = [UIFont systemFontOfSize:18];
        [self.contentView addSubview:self.dayLabel];
    }
    return self;
}

- (void)setDay:(NSInteger)day
{
    if (day > 0) {
        if (!self.userInteractionEnabled) {
            self.userInteractionEnabled = YES;
        }
        if (self.dayLabel.hidden) {
            self.dayLabel.hidden = NO;
        }
        if (_day != day) {
            self.dayLabel.text = [NSString stringWithFormat:@"%ld", (long)day];
        }
    } else {
        if (self.userInteractionEnabled) {
            self.userInteractionEnabled = NO;
        }
        if (!self.dayLabel.hidden) {
            self.dayLabel.hidden = YES;
        }
    }
    _day = day;
    [self setNeedsLayout];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.dayLabel sizeToFit];
    self.dayLabel.center = CGPointMake(CGRectGetWidth(self.bounds) / 2, CGRectGetHeight(self.bounds) / 2);
}

@end
