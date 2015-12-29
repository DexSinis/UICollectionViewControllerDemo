//
//  WaterFlowCollectionViewController2.m
//  UICollectionViewControllerDemo
//
//  Created by litt1e-p on 15/12/29.
//  Copyright © 2015年 litt1e-p. All rights reserved.
//

#import "WaterFlowCollectionViewController2.h"
#import "WaterFlowViewLayout2.h"
#import "WaterFlowCollectionViewCell2.h"

@interface WaterFlowCollectionViewController2 ()<UICollectionViewDataSource, WaterFlowViewLayout2Delegate>

@property (nonatomic, strong) NSMutableArray *images;
@property (nonatomic, strong) NSMutableArray *heights;
@property (nonatomic, weak) UICollectionView *collectionView;

@end

@implementation WaterFlowCollectionViewController2

static NSString * const kWaterFlowCollectionViewCell2ID = @"kWaterFlowCollectionViewCell2ID";

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initLayout];
}

- (void)initLayout
{
    WaterFlowViewLayout2 *layout = [[WaterFlowViewLayout2 alloc] init];
    layout.delegate = self;
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    collectionView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    collectionView.dataSource = self;
    [self.view addSubview:collectionView];
    [collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([WaterFlowCollectionViewCell2 class]) bundle:nil] forCellWithReuseIdentifier:kWaterFlowCollectionViewCell2ID];
    self.collectionView = collectionView;
}

#pragma mark - <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.images.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    WaterFlowCollectionViewCell2 *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kWaterFlowCollectionViewCell2ID forIndexPath:indexPath];
    cell.imageName = self.images[indexPath.item];
    return cell;
}

#pragma mark - <WaterflowLayoutDelegate>
- (CGFloat)waterflowLayout:(WaterFlowViewLayout2 *)waterflowLayout heightForItemAtIndex:(NSUInteger)index itemWidth:(CGFloat)itemWidth
{
    return [self.heights[index] floatValue];
}

- (CGFloat)rowMarginInWaterflowLayout:(WaterFlowViewLayout2 *)waterflowLayout
{
    return 10;
}

- (CGFloat)columnMarginInWaterflowLayout:(WaterFlowViewLayout2 *)waterflowLayout
{
    return 10;
}

- (CGFloat)columnCountInWaterflowLayout:(WaterFlowViewLayout2 *)waterflowLayout
{
    return 2;
}

#pragma mark - lazy loads
- (NSMutableArray *)images
{
    if (!_images) {
        _images = [NSMutableArray array];
        for (int i = 1; i <= 20; i++) {
            [_images addObject:[NSString stringWithFormat:@"%zi.jpg", i]];
        }
    }
    return _images;
}

- (NSMutableArray *)heights
{
    if (!_heights) {
        _heights = [NSMutableArray array];
        for (int i = 1; i <= 20; i++) {
            CGFloat height = 100 + (arc4random()%100);
            [_heights addObject:[NSString stringWithFormat:@"%f",height]];
        }
    }
    return _heights;
}

@end
