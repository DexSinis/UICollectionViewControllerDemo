//
//  CalendarCollectionViewController.m
//  UICollectionViewControllerDemo
//
//  Created by litt1e-p on 15/12/30.
//  Copyright © 2015年 litt1e-p. All rights reserved.
//

#import "CalendarCollectionViewController.h"
#import "CalendarHeaderReusableView.h"
#import "CalendarCollectionViewCell.h"
#import "NSDate+Calendar.h"

@interface CalendarCollectionViewController ()<UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) NSMutableArray *visibleMonths;
@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation CalendarCollectionViewController

static NSString *const kCalendarCollectionViewCellID = @"kCalendarCollectionViewCellID";
static NSString *const kCalendarCollectionViewHeaderID = @"kCalendarCollectionViewHeaderID";

- (instancetype)init
{
    return [self initWithDate:[NSDate date]];
}

- (instancetype)initWithDate:(NSDate *)date
{
    self = [super init];
    if (self) {
        self.visibleMonths = @[date.prevMonth, date, date.nextMonth, [date dateByAddingMonth:2]].mutableCopy;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIBarButtonItem *todayButton = [[UIBarButtonItem alloc] initWithTitle:@"Current Month"
                                                                    style:UIBarButtonItemStylePlain
                                                                   target:self
                                                                   action:@selector(todayButtonDidTap)];
    
    self.navigationItem.leftBarButtonItem = todayButton;
    
    CGFloat headerHeight = [CalendarHeaderReusableView height];
    NSInteger cellWidth = CGRectGetWidth(self.view.bounds) / 7;
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.headerReferenceSize = CGSizeMake(CGRectGetWidth(self.view.bounds), headerHeight);
    layout.itemSize = CGSizeMake(cellWidth, cellWidth);
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    self.collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.scrollsToTop = NO;
    [self.collectionView registerClass:CalendarCollectionViewCell.class forCellWithReuseIdentifier:kCalendarCollectionViewCellID];
    [self.collectionView registerClass:CalendarHeaderReusableView.class
            forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                   withReuseIdentifier:kCalendarCollectionViewHeaderID];
    [self.view addSubview:self.collectionView];
    [self todayButtonDidTap];
//    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:1];
//    [self.collectionView scrollToItemAtIndexPath:indexPath
//                                atScrollPosition:UICollectionViewScrollPositionTop
//                                        animated:NO];
    self.collectionView.contentOffset = CGPointMake(0, self.collectionView.contentOffset.y - headerHeight);

}

#pragma mark - Navigation Item Actions

- (void)todayButtonDidTap
{
    NSDate *today = [NSDate date];
    self.visibleMonths = @[today.prevMonth, today, today.nextMonth, [today dateByAddingMonth:2]].mutableCopy;
    [self.collectionView reloadData];
    CGFloat sectionHeight = [self sectionHeightForMonth:self.visibleMonths.firstObject];
    [self.collectionView setContentOffset:CGPointMake(0, sectionHeight - self.collectionView.contentInset.top)
                                 animated:NO];
}

#pragma mark - UICollectionView

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.visibleMonths.count;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
           viewForSupplementaryElementOfKind:(NSString *)kind
                                 atIndexPath:(NSIndexPath *)indexPath
{
    CalendarHeaderReusableView *headerView = [collectionView
                                      dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                                      withReuseIdentifier:kCalendarCollectionViewHeaderID
                                      forIndexPath:indexPath];
    headerView.date = self.visibleMonths[indexPath.section];
    return headerView;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSDate *month = self.visibleMonths[section];
    return month.columnForFirstDayInMonth + month.numberOfDaysInMonth;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CalendarCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCalendarCollectionViewCellID forIndexPath:indexPath];
    NSDate *month = self.visibleMonths[indexPath.section];
    cell.day = indexPath.item - month.columnForFirstDayInMonth + 1;
    return cell;
}

#pragma mark - UIScrollView

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offset = scrollView.contentOffset.y + scrollView.contentInset.top;
    if (offset <= 0) {
        [self preparePrevMonth];
    } else if (offset >= scrollView.contentSize.height - CGRectGetHeight(scrollView.bounds)) {
        [self prepareNextMonth];
    }
}

#pragma mark - Prepare Month

- (CGFloat)sectionHeightForMonth:(NSDate *)month
{
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
    return month.numberOfWeeksInMonth * layout.itemSize.height + [CalendarHeaderReusableView height];
}

- (void)preparePrevMonth
{
    self.collectionView.delegate = nil;
    
    NSDate *firstMonth = self.visibleMonths.firstObject;
    [self.visibleMonths removeLastObject];
    [self.visibleMonths insertObject:firstMonth.prevMonth atIndex:0];
    
    firstMonth = self.visibleMonths.firstObject;
    CGFloat sectionHeight = [self sectionHeightForMonth:firstMonth];
    self.collectionView.contentOffset = CGPointMake(0, sectionHeight - self.collectionView.contentInset.top);
    [self.collectionView reloadData];
    
    self.collectionView.delegate = self;
}

- (void)prepareNextMonth
{
    self.collectionView.delegate = nil;
    
    NSDate *firstMonth = self.visibleMonths.firstObject;
    NSDate *lastMonth = self.visibleMonths.lastObject;
    [self.visibleMonths removeObjectAtIndex:0];
    [self.visibleMonths addObject:lastMonth.nextMonth];
    
    CGFloat sectionHeight = [self sectionHeightForMonth:firstMonth];
    self.collectionView.contentOffset = CGPointMake(0, self.collectionView.contentOffset.y - sectionHeight);
    [self.collectionView reloadData];
    
    self.collectionView.delegate = self;
}

@end
