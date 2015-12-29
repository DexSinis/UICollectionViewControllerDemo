//
//  ParallaxCollectionViewCell.m
//  UICollectionViewControllerDemo
//
//  Created by xzc on 15/12/29.
//  Copyright © 2015年 litt1e-p. All rights reserved.
//

#import "ParallaxCollectionViewCell.h"

@interface ParallaxCollectionViewCell()

@property (nonatomic , strong) UILabel *titleLabel;

@end

@implementation ParallaxCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _titleLabel      = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.font = [UIFont systemFontOfSize:18];
        [self.contentView addSubview:_titleLabel];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    _titleLabel.frame = CGRectMake(CGRectGetWidth(self.contentView.frame)/2-100, CGRectGetHeight(self.contentView.frame)/2-10, 200, 20);
}

- (void)setTitle:(NSString *)title{
    _titleLabel.text = title;
}

@end
