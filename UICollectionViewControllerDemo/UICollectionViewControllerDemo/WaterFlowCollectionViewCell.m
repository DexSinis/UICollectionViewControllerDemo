//
//  WaterFlowCollectionViewCell.m
//  UICollectionViewControllerDemo
//
//  Created by litt1e-p on 15/12/29.
//  Copyright © 2015年 litt1e-p. All rights reserved.
//

#import "WaterFlowCollectionViewCell.h"

@interface WaterFlowCollectionViewCell()

@property (nonatomic , strong) UIImageView *imageView;

@end

@implementation WaterFlowCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        _imageView.clipsToBounds = YES;
        [self.contentView addSubview:_imageView];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    _imageView.frame = self.contentView.bounds;
}

- (void)setImageName:(NSString *)imageName
{
    _imageView.image = [UIImage imageNamed:imageName];
}

@end
