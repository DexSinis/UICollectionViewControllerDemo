//
//  SubscriptionLabelCollectionViewController.m
//  UICollectionViewControllerDemo
//
//  Created by litt1e-p on 15/12/30.
//  Copyright © 2015年 litt1e-p. All rights reserved.
//

#import "SubscriptionLabelCollectionViewController.h"
#import "SubscriptionLabelCollectionReusableView.h"
#import "SubscriptionLabelCollectionViewCell.h"
#import "SubscriptionLabelViewLayout.h"

typedef void(^IsLimitWidth)(BOOL yesOrNo, id data);

@interface SubscriptionLabelCollectionViewController ()<UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray   *dataSource;

@end

@implementation SubscriptionLabelCollectionViewController

static NSString * const kSubscriptionLabelCollectionViewCellID       = @"kSubscriptionLabelCollectionViewCellID";
static NSString * const kSubscriptionLabelCollectionViewHeaderViewID = @"kSubscriptionLabelCollectionViewHeaderViewID";
static CGFloat const kCollectionViewCellsHorizonMargin               = 12;
static CGFloat const kCollectionViewCellHeight                       = 30;
static CGFloat const kCollectionViewToLeftMargin                     = 16;
static CGFloat const kCollectionViewToTopMargin                      = 12;
static CGFloat const kCollectionViewToRightMargin                    = 16;
static CGFloat const kCollectionViewToBottomtMargin                  = 10;
static CGFloat const kCellBtnCenterToBorderMargin                    = 19;

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.dataSource = [NSMutableArray array];
    NSMutableArray *array1 = [@[@"recommendation", @"hotspot", @"car",@"finance", @"society", @"film stars", @"IT tech", @"mobile apps"] mutableCopy];
    
    [self.dataSource addObject:array1];
    NSMutableArray * array2 = [@[@"e-commerce", @"big data", @"stock", @"food security", @"custom labels"] mutableCopy];
    
    [self.dataSource addObject:array2];
    [self initCollectionView];
}

- (void)initCollectionView
{
    CGRect collectionViewFrame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-40);
    SubscriptionLabelViewLayout * layout = [[SubscriptionLabelViewLayout alloc] init];
    self.collectionView = [[UICollectionView alloc] initWithFrame:collectionViewFrame collectionViewLayout:layout];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.collectionView registerClass:[SubscriptionLabelCollectionViewCell class] forCellWithReuseIdentifier:kSubscriptionLabelCollectionViewCellID];
    self.collectionView.allowsMultipleSelection = YES;
    
    [self.collectionView registerClass:[SubscriptionLabelCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kSubscriptionLabelCollectionViewHeaderViewID];
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.contentInset = UIEdgeInsetsMake(15, 0, 0, 0);
    self.collectionView.scrollsToTop = NO;
    //self.collectionView.scrollEnabled = NO;
    [self.view addSubview:self.collectionView];
    
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return [self.dataSource count];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSMutableArray * array = self.dataSource[section];
    return array.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SubscriptionLabelCollectionViewCell *cell = (SubscriptionLabelCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:kSubscriptionLabelCollectionViewCellID forIndexPath:indexPath];
    cell.titleLabel.frame = CGRectMake(0, 0, cell.frame.size.width, cell.frame.size.height);
    NSMutableArray *array = self.dataSource[indexPath.section];
    NSString *text = array[indexPath.row];
    cell.titleLabel.text = text;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%ld", indexPath.row);
    
    NSMutableArray *array1 = indexPath.section == 0 ? self.dataSource[1] : self.dataSource[0];
    NSMutableArray *array2 = indexPath.section == 1 ? self.dataSource[1] : self.dataSource[0];
    [array1 addObject:array2[indexPath.row]];
    [array2 removeObjectAtIndex:indexPath.row];
    [self.collectionView reloadData];
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
           viewForSupplementaryElementOfKind:(NSString *)kind
                                 atIndexPath:(NSIndexPath *)indexPath
{
    if ([kind isEqual:UICollectionElementKindSectionHeader]) {
        SubscriptionLabelCollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kSubscriptionLabelCollectionViewHeaderViewID forIndexPath:indexPath];
        NSString * str = indexPath.section == 0 ? @"my subscriptions" : @"unsubscriptions";
        headerView.titleLabel.text = str;
        return (UICollectionReusableView *)headerView;
    }
    return nil;
}

- (CGFloat)getCollectionCellWidthText:(NSString *)text
{
    CGFloat cellWidth;
    CGSize size = [text sizeWithAttributes: @{NSFontAttributeName: [UIFont systemFontOfSize:13]}];
    cellWidth   = ceilf(size.width) + kCellBtnCenterToBorderMargin;
    cellWidth   = [self checkCellLimitWidth:cellWidth isLimitWidth:nil];
    return cellWidth;
}

- (CGFloat)checkCellLimitWidth:(CGFloat)cellWidth isLimitWidth:(IsLimitWidth)isLimitWidth
{
    CGFloat limitWidth = (CGRectGetWidth(self.collectionView.frame)-kCollectionViewToLeftMargin-kCollectionViewToRightMargin);
    if (cellWidth >= limitWidth) {
        cellWidth = limitWidth;
        isLimitWidth ? isLimitWidth(YES,@(cellWidth)) : nil;
        return cellWidth;
    }
    isLimitWidth ? isLimitWidth(NO,@(cellWidth)) : nil;
    return cellWidth;
}

#pragma mark - UICollectionViewDelegateLeftAlignedLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableArray * array = self.dataSource[indexPath.section];
    NSString *text = array[indexPath.row];
    float cellWidth = [self getCollectionCellWidthText:text];
    return CGSizeMake(cellWidth, kCollectionViewCellHeight);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return kCollectionViewCellsHorizonMargin;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake([UIScreen mainScreen].bounds.size.width - 50, 38);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(kCollectionViewToTopMargin, kCollectionViewToLeftMargin, kCollectionViewToBottomtMargin, kCollectionViewToRightMargin);
}

@end
