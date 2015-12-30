//
//  SubscriptionLabelCollectionReusableView.m
//  UICollectionViewControllerDemo
//
//  Created by litt1e-p on 15/12/30.
//  Copyright © 2015年 litt1e-p. All rights reserved.
//

#import "SubscriptionLabelCollectionReusableView.h"

@implementation SubscriptionLabelCollectionReusableView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self = [self sharedInit];
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
    self.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.titleLabel      = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, self.frame.size.width - 10, self.frame.size.height)];
    [self addSubview:self.titleLabel];
    return self;
}

@end
