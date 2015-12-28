//
//  CircleCollectionViewCell.m
//  UICollectionViewControllerDemo
//
//  Created by litt1e-p on 15/12/28.
//  Copyright © 2015年 litt1e-p. All rights reserved.
//

#import "CircleCollectionViewCell.h"

@interface CircleCollectionViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation CircleCollectionViewCell

- (void)awakeFromNib {
    self.imageView.layer.borderColor = [UIColor whiteColor].CGColor;
    self.imageView.layer.borderWidth = 5;
}

- (void)setImageName:(NSString *)imageName
{
    _imageName = [imageName copy];
    self.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.jpg", imageName]];
    //    self.imageView.image = [UIImage imageNamed:imageName];
}

@end
