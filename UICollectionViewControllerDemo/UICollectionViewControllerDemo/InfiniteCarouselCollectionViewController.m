//
//  InfiniteCarouselCollectionViewController.m
//  UICollectionViewControllerDemo
//
//  Created by litt1e-p on 15/12/29.
//  Copyright © 2015年 litt1e-p. All rights reserved.
//

#import "InfiniteCarouselCollectionViewController.h"
#import "InfiniteCarouselCollectionViewCell.h"
#import "InfiniteCarouselModel.h"

@interface InfiniteCarouselCollectionViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic , strong) UICollectionView *collectionView;
@property (nonatomic , strong) UIPageControl *pageControl;
@property (nonatomic , strong) NSMutableArray *models;
@property (nonatomic , strong) NSTimer *timer;

@end

@implementation InfiniteCarouselCollectionViewController

static NSString *const kInfiniteCarouselCollectionViewCellID = @"kInfiniteCarouselCollectionViewCellID";
static NSInteger const kMaxSections = 100;

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self initView];
}

- (void)initView
{
    CGFloat collectionViewHeight = 150;
    CGFloat screenWidth = [UIApplication sharedApplication].keyWindow.bounds.size.width;
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(screenWidth, collectionViewHeight);
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowLayout.minimumLineSpacing = 0;
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, collectionViewHeight) collectionViewLayout:flowLayout];
    collectionView.delegate                       = self;
    collectionView.dataSource                     = self;
    collectionView.pagingEnabled                  = YES;
    collectionView.backgroundColor                = [UIColor clearColor];
    collectionView.showsHorizontalScrollIndicator = NO;
    _collectionView                               = collectionView;
    [self.view addSubview:collectionView];
    
    [self.collectionView registerClass:[InfiniteCarouselCollectionViewCell class] forCellWithReuseIdentifier:kInfiniteCarouselCollectionViewCellID];
    
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:kMaxSections / 2] atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
    
    CGFloat pageControlHeight  = 10;
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    pageControl.enabled        = NO;
    pageControl.numberOfPages  = self.models.count;
    pageControl.center         = CGPointMake(screenWidth * 0.5, collectionViewHeight - pageControlHeight);
    pageControl.bounds         = CGRectMake(0, 0, screenWidth, pageControlHeight);
    _pageControl               = pageControl;
    [self.view addSubview:pageControl];
    [self addTimer];
}

#pragma mark - timer handler 📌
- (void)addTimer
{
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:2.f target:self selector:@selector(nextpage) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    self.timer = timer;
}

- (void)removeTimer
{
    [self.timer invalidate];
    self.timer = nil;
}

- (void)nextpage
{
    NSIndexPath *currentIndexPath      = [[self.collectionView indexPathsForVisibleItems] lastObject];
    NSIndexPath *currentIndexPathReset = [NSIndexPath indexPathForItem:currentIndexPath.item inSection:kMaxSections/2];
    [self.collectionView scrollToItemAtIndexPath:currentIndexPathReset atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
    NSInteger nextItem    = currentIndexPathReset.item + 1;
    NSInteger nextSection = currentIndexPathReset.section;
    if (nextItem == self.models.count) {
        nextItem = 0;
        nextSection++;
    }
    NSIndexPath *nextIndexPath = [NSIndexPath indexPathForItem:nextItem inSection:nextSection];
    [self.collectionView scrollToItemAtIndexPath:nextIndexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
}

#pragma mark - UICollectionViewDataSource & delegate 📌
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return kMaxSections;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.models.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    InfiniteCarouselCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kInfiniteCarouselCollectionViewCellID forIndexPath:indexPath];
    cell.model = self.models[indexPath.item];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"clicked----%zi", indexPath.item);
}

#pragma mark - scrollView delegate 📌
- (void) scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self removeTimer];
}

- (void) scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self addTimer];
}

- (void) scrollViewDidScroll:(UIScrollView *)scrollView
{
    int page = (int) (scrollView.contentOffset.x/scrollView.frame.size.width+0.5)%self.models.count;
    self.pageControl.currentPage =page;
}

#pragma mark - lazy loads 📌
- (NSMutableArray *)models
{
    if (!_models) {
        self.models = [[NSMutableArray alloc] init];
        for (int i = 1; i <= 5; i++) {
            NSDictionary *dict = @{@"icon" : [NSString stringWithFormat:@"%zi.jpg", i],
                                   @"title" : [NSString stringWithFormat:@"NO.-----%zi", i]};
            [self.models addObject:[InfiniteCarouselModel modelWithDict:dict]];
        }
    }
    return _models;
}

@end
