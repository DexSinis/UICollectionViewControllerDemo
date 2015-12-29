//
//  ParallaxCollectionHeaderView.m
//  UICollectionViewControllerDemo
//
//  Created by litt1e-p on 15/12/29.
//  Copyright © 2015年 litt1e-p. All rights reserved.
//

#import "ParallaxCollectionHeaderView.h"

@interface ParallaxCollectionHeaderView()

@property (nonatomic , strong) UIImageView *iconView;

@end

@implementation ParallaxCollectionHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _iconView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _iconView.contentMode = UIViewContentModeScaleAspectFill;
        _iconView.clipsToBounds = YES;
        [self addSubview:_iconView];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    _iconView.frame = self.bounds;
}

- (void)setIconName:(NSString *)iconName
{
    _iconView.image = [UIImage imageNamed:iconName];
}

@end
