//
//  HorizontalImageViewController.m
//  LinearCollectionViewController
//
//  Created by litt1e-p on 15/12/28.
//  Copyright © 2015年 litt1e-p. All rights reserved.
//

#import "LinearCollectionViewController.h"
#import "LinearCollectionViewCell.h"
#import "LinearLayout.h"

@interface LinearCollectionViewController ()<UICollectionViewDataSource, UICollectionViewDelegate>

@end

@implementation LinearCollectionViewController

static NSString *const kLinearCollectionViewCellID = @"kLinearCollectionViewCellID";

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initCollectionView];
}

- (void)initCollectionView
{
    LinearLayout *layout = [[LinearLayout alloc] init];
    layout.itemSize = CGSizeMake(100, 100);
    
    CGRect frame = (CGRect){{0, self.view.frame.size.height * 0.3}, {self.view.frame.size.width, 220}};
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:layout];
    collectionView.backgroundColor = [UIColor purpleColor];
    collectionView.showsHorizontalScrollIndicator = NO;
    collectionView.dataSource = self;
    collectionView.delegate = self;
    [self.view addSubview:collectionView];
    [collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([LinearCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:kLinearCollectionViewCellID];
}

#pragma mark - collection dataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 40;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    LinearCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kLinearCollectionViewCellID forIndexPath:indexPath];
    cell.imageName = [NSString stringWithFormat:@"zd", indexPath.item];
    return cell;
}

#pragma mark - collection delegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"clicked %zd", indexPath.item);
}

@end
