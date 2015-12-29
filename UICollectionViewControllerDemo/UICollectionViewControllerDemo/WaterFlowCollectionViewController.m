//
//  WaterFlowCollectionViewController.m
//  UICollectionViewControllerDemo
//
//  Created by litt1e-p on 15/12/28.
//  Copyright © 2015年 litt1e-p. All rights reserved.
//

#import "WaterFlowCollectionViewController.h"
#import "WaterFlowCollectionViewCell.h"
#import "WaterFlowViewLayout.h"

@interface WaterFlowCollectionViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,WaterFlowViewLayoutDelegate>
{
    NSMutableArray *dataList;
    NSMutableArray *sectionOne;
    NSMutableArray  *heightArr;
}

@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation WaterFlowCollectionViewController

static NSString *const kWaterFlowCollectionViewCellID = @"kWaterFlowCollectionViewCellID";

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initData];
    [self initView];
}

- (void)initData
{
    if(!dataList)
        dataList = [[NSMutableArray alloc] initWithCapacity:0];
    [dataList removeAllObjects];
    
    if (!heightArr) {
        heightArr = [[NSMutableArray alloc] initWithCapacity:0];
    }
    [heightArr removeAllObjects];
    
    for (int i = 1; i <= 20; i++) {
        [dataList addObject:[NSString stringWithFormat:@"%zi.jpg", i]];
        CGFloat height = 100 + (arc4random()%100);
        [heightArr addObject:[NSString stringWithFormat:@"%f",height]];
    }
}

- (void)initView
{
    WaterFlowViewLayout *layout = [[WaterFlowViewLayout alloc] init];
    layout.delegate = self;
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:collectionView];
    _collectionView = collectionView;
    [self.collectionView registerClass:[WaterFlowCollectionViewCell class] forCellWithReuseIdentifier:kWaterFlowCollectionViewCellID];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return dataList.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView layout:(WaterFlowViewLayout *)layout numberOfColumnsInSection:(NSInteger)section
{
    return 3;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    WaterFlowCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kWaterFlowCollectionViewCellID forIndexPath:indexPath];
    cell.imageName = dataList[indexPath.row];
    return cell;
}

#pragma mark - UICollectionView Delegate Methods

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 5;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 5;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(5, 5, 5, 5);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = [[heightArr objectAtIndex:indexPath.row] floatValue];
    return CGSizeMake(100, height);
}

@end
