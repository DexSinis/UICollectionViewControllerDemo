//
//  WaterFlowCollectionViewCell2.m
//  UICollectionViewControllerDemo
//
//  Created by litt1e-p on 15/12/29.
//  Copyright © 2015年 litt1e-p. All rights reserved.
//

#import "WaterFlowCollectionViewCell2.h"

@interface WaterFlowCollectionViewCell2()


@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation WaterFlowCollectionViewCell2

- (void)awakeFromNib {
    self.imageView.layer.borderColor = [UIColor whiteColor].CGColor;
    self.imageView.layer.borderWidth = 10;
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    self.imageView.clipsToBounds = YES;
}

- (void)setImageName:(NSString *)imageName
{
    _imageName = [imageName copy];
    self.imageView.image = [UIImage imageNamed:imageName];
}

@end
