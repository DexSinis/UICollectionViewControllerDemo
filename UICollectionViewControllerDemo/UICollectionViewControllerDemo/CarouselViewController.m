//
//  CarouselViewController.m
//  UICollectionViewControllerDemo
//
//  Created by litt1e-p on 15/12/29.
//  Copyright © 2015年 litt1e-p. All rights reserved.
//

#import "CarouselViewController.h"
#import "CarouselView.h"

@interface CarouselViewController ()

@end

@implementation CarouselViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor]; 
    self.title = @"Carousel";
    NSMutableArray *images = [NSMutableArray array];
    for (int i = 1; i < 5; i++) {
        NSString *imageName = [NSString stringWithFormat:@"%zd.jpg", i];
        [images addObject:imageName];
    }
    self.edgesForExtendedLayout = UIRectEdgeNone;
    CarouselView *carouselView = [[CarouselView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 150) imageNames:images];
    [self.view addSubview:carouselView];
    carouselView.cellDidSelectItemAtIndex = ^(NSInteger selectedIndex) {
        NSLog(@"indexPath === %ld", selectedIndex);
    };
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    for (UIView *subView in [UIApplication sharedApplication].keyWindow.subviews) {
        if ([subView isKindOfClass:[UIPageControl class]]) {
            [subView removeFromSuperview];
        }
    }
}

@end
