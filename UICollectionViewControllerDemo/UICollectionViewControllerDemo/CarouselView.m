//
//  CarouselView.m
//  UICollectionViewControllerDemo
//
//  Created by litt1e-p on 15/12/29.
//  Copyright © 2015年 litt1e-p. All rights reserved.
//

#import "CarouselView.h"

@interface CarouselView()<UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, weak) UIPageControl *carouselPageControl;
@property (nonatomic, strong) NSTimer *timer;

@end

@implementation CarouselView

static NSString * const kCarouselViewCellID = @"kCarouselViewCellID";

- (instancetype)initWithFrame:(CGRect)frame
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize                    = frame.size;
    layout.minimumLineSpacing          = 0;
    layout.scrollDirection             = UICollectionViewScrollDirectionHorizontal;
    [self registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:kCarouselViewCellID];
    self.dataSource                     = self;
    self.delegate                       = self;
    [self startTimer];
    [layout invalidateLayout];
    return [super initWithFrame:frame collectionViewLayout:layout];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.bounces                        = NO;
    self.showsHorizontalScrollIndicator = NO;
    self.pagingEnabled                  = YES;
}

- (instancetype)initWithFrame:(CGRect)frame imageNames:(NSArray *)imageNames
{
    self.imageNames = imageNames;
    [self scrollViewDidScroll:self];
    return [self initWithFrame:frame];
}

#pragma mark - UICollectionViewDataSource,UICollectionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.imageNames.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCarouselViewCellID forIndexPath:indexPath];
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:self.imageNames[indexPath.row]]];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    cell.backgroundView = imageView;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    self.cellDidSelectItemAtIndex(indexPath.item);
}


#pragma mark - timer callback
- (void)pageChanged:(UIPageControl *)page
{
    [self.timer invalidate];
    CGFloat x = page.currentPage * self.bounds.size.width;
    [self setContentOffset:CGPointMake(x, 0) animated:YES];
    [self startTimer];
}

#pragma mark - Timer
- (void)startTimer
{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(updateTimer) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)updateTimer
{
    NSUInteger count = self.imageNames.count;
    if (count == 0) {
        return;
    }
    int page = (self.carouselPageControl.currentPage+1) % (int)count;
    self.carouselPageControl.currentPage = page;
    [self pageChanged:self.carouselPageControl];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.timer invalidate];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self startTimer];
}

#pragma mark - UIScrollView delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    int page = scrollView.contentOffset.x / scrollView.bounds.size.width + 0.5;
    self.carouselPageControl.currentPage = page;
}


#pragma mark - carouselPageControl
-(UIPageControl *)carouselPageControl
{
    if (_carouselPageControl == nil) {
        UIPageControl * carouselPageControl = [[UIPageControl alloc] init];
        carouselPageControl.numberOfPages = self.imageNames.count;
        CGSize size = [_carouselPageControl sizeForNumberOfPages:self.imageNames.count];
        CGPoint windowOrigin = [self convertPoint:self.frame.origin toView:self.window];
        carouselPageControl.bounds = CGRectMake(0, 0, size.width, size.height);
        carouselPageControl.center = CGPointMake(self.center.x, windowOrigin.y + self.frame.size.height - 10);
        [carouselPageControl addTarget:self action:@selector(pageChanged:) forControlEvents:UIControlEventValueChanged];
        [self.window addSubview:carouselPageControl];
        _carouselPageControl = carouselPageControl;
    }
    return _carouselPageControl;
}

-(NSArray *)imageNames
{
    if (_imageNames == nil) {
        _imageNames = [NSArray array];
    }
    return _imageNames;
}

@end
