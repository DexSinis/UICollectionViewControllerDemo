//
//  SubscriptionLabelCollectionViewCell.m
//  UICollectionViewControllerDemo
//
//  Created by litt1e-p on 15/12/30.
//  Copyright © 2015年 litt1e-p. All rights reserved.
//

#import "SubscriptionLabelCollectionViewCell.h"

@implementation SubscriptionLabelCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (id)initWithCoder: (NSCoder *)aDecoder
{
    self = [super initWithCoder: aDecoder];
    if (self) {
        self = [self sharedInit];
    }
    return self;
}

- (id)sharedInit
{
    [self setup];
    return self;
}

- (void)setup
{
    self.titleLabel                     = [UILabel new];
    self.titleLabel.frame               = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
    self.titleLabel.textAlignment       = NSTextAlignmentCenter;
    self.titleLabel.font                = [UIFont systemFontOfSize:14];
    self.titleLabel.layer.cornerRadius  = 5.0;
    self.titleLabel.backgroundColor     = [UIColor whiteColor];
    self.titleLabel.layer.borderWidth   = 1;
    self.titleLabel.layer.masksToBounds = YES;
    
    [self.contentView addSubview:self.titleLabel];
}

@end
