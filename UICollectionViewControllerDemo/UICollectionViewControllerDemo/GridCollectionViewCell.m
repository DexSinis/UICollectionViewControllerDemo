//
//  GridCollectionViewCell.m
//  UICollectionViewControllerDemo
//
//  Created by litt1e-p on 15/12/28.
//  Copyright © 2015年 litt1e-p. All rights reserved.
//

#import "GridCollectionViewCell.h"

@interface GridCollectionViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;


@end

@implementation GridCollectionViewCell

- (void)awakeFromNib {
    self.imageView.layer.borderColor = [UIColor whiteColor].CGColor;
    self.imageView.layer.borderWidth = 10;
}

- (void)setImageName:(NSString *)imageName
{
    _imageName = [imageName copy];
    self.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.jpg", imageName]];
    //    self.imageView.image = [UIImage imageNamed: imageName];
}

@end
