//
//  ParallaxCollectionViewController.m
//  UICollectionViewControllerDemo
//
//  Created by xzc on 15/12/29.
//  Copyright © 2015年 litt1e-p. All rights reserved.
//

#import "ParallaxCollectionViewController.h"
#import "ParallaxCollectionHeaderView.h"
#import "ParallaxCollectionViewCell.h"
#import "ParallaxViewLayout.h"

@interface ParallaxCollectionViewController ()<UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic , strong) UICollectionView *collectionView;

@end

@implementation ParallaxCollectionViewController

static NSString *const kParallaxCollectionViewCellID = @"kParallaxCollectionViewCellID";
static NSString *const kParallaxCollectionViewHeaderViewID = @"kParallaxCollectionViewHeaderViewID";

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Parallax";
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self initView];
}

- (void)initView
{
    ParallaxViewLayout *layout = [[ParallaxViewLayout alloc] init];
    layout.itemSize = CGSizeMake(self.view.bounds.size.width, 40);
    layout.headerReferenceSize = CGSizeMake(self.view.bounds.size.width, 200);
    
    _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    _collectionView.backgroundColor = [UIColor clearColor];
    _collectionView.alwaysBounceVertical = YES;
    _collectionView.showsVerticalScrollIndicator = NO;
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    [self.view addSubview:_collectionView];
    
    [_collectionView registerClass:[ParallaxCollectionViewCell class] forCellWithReuseIdentifier:kParallaxCollectionViewCellID];
    [_collectionView registerClass:[ParallaxCollectionHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kParallaxCollectionViewHeaderViewID];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 20;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if (kind == UICollectionElementKindSectionHeader) {
        ParallaxCollectionHeaderView *headView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:kParallaxCollectionViewHeaderViewID forIndexPath:indexPath];
        headView.iconName = @"1.jpg";
        return headView;
    }
    return nil;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ParallaxCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kParallaxCollectionViewCellID forIndexPath:indexPath];
    cell.title = [NSString stringWithFormat:@"row----%zi", indexPath.row];
    return cell;
}

@end
