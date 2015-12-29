//
//  CircleCollectionViewController.m
//  UICollectionViewControllerDemo
//
//  Created by litt1e-p on 15/12/28.
//  Copyright © 2015年 litt1e-p. All rights reserved.
//

#import "CircleCollectionViewController.h"
#import "CircleCollectionViewCell.h"
#import "CircleViewLayout.h"

@interface CircleCollectionViewController ()<UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *imageNames;

@end

@implementation CircleCollectionViewController

static NSString * const kCircleCollectionViewCellID = @"kCircleCollectionViewCellID";

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Circle";
    [self initCollectionView];
}

- (void)initCollectionView
{
    CircleViewLayout *layout = [[CircleViewLayout alloc] init];
    CGFloat collectionW = self.view.frame.size.width;
    CGFloat collectionH = 400;
    CGRect frame = CGRectMake(0, 150, collectionW, collectionH);
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:layout];
    collectionView.dataSource = self;
    collectionView.delegate = self;
    [self.view addSubview:collectionView];
    self.collectionView = collectionView;
    
    [collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([CircleCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:kCircleCollectionViewCellID];
}

#pragma mark - <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.imageNames.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CircleCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCircleCollectionViewCellID forIndexPath:indexPath];
    cell.imageName = self.imageNames[indexPath.item];
    return cell;
}

#pragma mark - <UICollectionViewDelegate>
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self.imageNames removeObjectAtIndex:indexPath.item];
    [self.collectionView deleteItemsAtIndexPaths:@[indexPath]];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    self.imageNames = nil;
    [self.collectionView reloadData];
}

- (NSMutableArray *)imageNames
{
    if (!_imageNames) {
        _imageNames = [NSMutableArray array];
        for (int i = 0; i<20; i++) {
            [_imageNames addObject:[NSString stringWithFormat:@"%zd", i + 1]];
        }
    }
    return _imageNames;
}

@end
