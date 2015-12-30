//
//  InfiniteCarouselCollectionViewCell.m
//  UICollectionViewControllerDemo
//
//  Created by litt1e-p on 15/12/29.
//  Copyright © 2015年 litt1e-p. All rights reserved.
//

#import "InfiniteCarouselCollectionViewCell.h"
#import "InfiniteCarouselModel.h"

@interface InfiniteCarouselCollectionViewCell()

@property (weak , nonatomic)  UILabel *label;
@property (weak , nonatomic)  UIImageView *imageView;

@end

@implementation InfiniteCarouselCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self =[super initWithFrame:frame];
    if (self) {
        UIImageView *img = [[UIImageView alloc] init];
        [self.contentView addSubview:img];
        self.imageView = img;
        
        UILabel *lab = [[UILabel alloc] init];
        [self.contentView addSubview:lab];
        self.label = lab;
    }
    
    return self;
}


-(void)setModel:(InfiniteCarouselModel *)model
{
    _model                     = model;
    self.imageView.image       = [UIImage imageNamed:_model.icon];
    self.label.text            = _model.title;
    CGFloat screenWidth        = self.contentView.frame.size.width;
    self.imageView.frame       = CGRectMake(0, 0, screenWidth, 200);
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    self.label.frame           = CGRectMake(0, 0, screenWidth, 200);
    self.label.font            = [UIFont systemFontOfSize:30];
    self.label.textAlignment   = NSTextAlignmentCenter;
    self.label.textColor       = [UIColor whiteColor];
}

@end
