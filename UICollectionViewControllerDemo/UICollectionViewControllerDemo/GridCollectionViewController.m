//
//  GridCollectionViewController.m
//  UICollectionViewControllerDemo
//
//  Created by litt1e-p on 15/12/28.
//  Copyright © 2015年 litt1e-p. All rights reserved.
//

#import "GridCollectionViewController.h"
#import "GridCollectionViewCell.h"
#import "GridViewLayout.h"

@interface GridCollectionViewController ()<UICollectionViewDataSource, UICollectionViewDelegate>

@end

@implementation GridCollectionViewController

static NSString * const kGridCollectionViewCellID = @"kGridCollectionViewCellID";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Grid";
    [self initCollectionView];
}

- (void)initCollectionView
{
    GridViewLayout *layout = [[GridViewLayout alloc] init];
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    [self.view addSubview:collectionView];
    [collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([GridCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:kGridCollectionViewCellID];
}

#pragma mark - <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 20;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    GridCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kGridCollectionViewCellID forIndexPath:indexPath];
    cell.imageName = [NSString stringWithFormat:@"%zd", indexPath.item + 1];
    return cell;
}

#pragma mark - <UICollectionViewDelegate>
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"------%zd", indexPath.item);
}

@end
