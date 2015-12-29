//
//  WaterFlowViewLayout2.m
//  UICollectionViewControllerDemo
//
//  Created by litt1e-p on 15/12/29.
//  Copyright © 2015年 litt1e-p. All rights reserved.
//

#import "WaterFlowViewLayout2.h"

@interface WaterFlowViewLayout2()

@property (nonatomic, strong) NSMutableArray *attrsArray;
@property (nonatomic, strong) NSMutableArray *columnHeights;
@property (nonatomic, assign) CGFloat contentHeight;

@property (nonatomic, assign) CGFloat rowMargin;
@property (nonatomic, assign) CGFloat columnMargin;
@property (nonatomic, assign) NSInteger columnCount;
@property (nonatomic, assign) UIEdgeInsets edgeInsets;

@end

@implementation WaterFlowViewLayout2

static NSInteger const kDefaultColumnCount = 3;
static CGFloat const kDefaultColumnMargin = 10;
static CGFloat const kDefaultRowMargin = 10;
static UIEdgeInsets const kDefaultEdgeInsets = {0, 0, 0, 0};

- (void)prepareLayout
{
    [super prepareLayout];
    self.contentHeight = 0;
    [self.columnHeights removeAllObjects];
    for (NSInteger i = 0; i < self.columnCount; i++) {
        [self.columnHeights addObject:@(self.edgeInsets.top)];
    }
    
    [self.attrsArray removeAllObjects];
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    for (NSInteger i = 0; i < count; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        UICollectionViewLayoutAttributes *attrs = [self layoutAttributesForItemAtIndexPath:indexPath];
        [self.attrsArray addObject:attrs];
    }
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    return self.attrsArray;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewLayoutAttributes *attrs = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    CGFloat collectionViewW = self.collectionView.frame.size.width;
    CGFloat w = (collectionViewW - self.edgeInsets.left - self.edgeInsets.right - (self.columnCount - 1) * self.columnMargin) / self.columnCount;
    CGFloat h = [self.delegate waterflowLayout:self heightForItemAtIndex:indexPath.item itemWidth:w];
    
    NSInteger shortestColumn = 0;
    CGFloat minColumnHeight = [self.columnHeights[0] doubleValue];
    for (NSInteger i = 1; i < self.columnCount; i++) {
        CGFloat columnHeight = [self.columnHeights[i] doubleValue];
        if (minColumnHeight > columnHeight) {
            minColumnHeight = columnHeight;
            shortestColumn = i;
        }
    }
    CGFloat x = self.edgeInsets.left + shortestColumn * (w + self.columnMargin);
    CGFloat y = minColumnHeight;
    if (y != self.edgeInsets.top) {
        y += self.rowMargin;
    }
    attrs.frame = CGRectMake(x, y, w, h);
    self.columnHeights[shortestColumn] = @(CGRectGetMaxY(attrs.frame));
    CGFloat columnHeight = [self.columnHeights[shortestColumn] doubleValue];
    if (self.contentHeight < columnHeight) {
        self.contentHeight = columnHeight;
    }
    return attrs;
}

- (CGSize)collectionViewContentSize
{
    return CGSizeMake(0, self.contentHeight + self.edgeInsets.bottom);
}

#pragma mark - lazy loads

- (CGFloat)rowMargin
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(rowMarginInWaterflowLayout:)]) {
        return [self.delegate rowMarginInWaterflowLayout:self];
    } else {
        return kDefaultRowMargin;
    }
}

- (CGFloat)columnMargin
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(columnMarginInWaterflowLayout:)]) {
        return [self.delegate columnMarginInWaterflowLayout:self];
    } else {
        return kDefaultColumnMargin;
    }
}

- (NSInteger)columnCount
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(columnCountInWaterflowLayout:)]) {
        return [self.delegate columnCountInWaterflowLayout:self];
    } else {
        return kDefaultColumnCount;
    }
}

- (UIEdgeInsets)edgeInsets
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(edgeInsetsInWaterflowLayout:)]) {
        return [self.delegate edgeInsetsInWaterflowLayout:self];
    } else {
        return kDefaultEdgeInsets;
    }
}

- (NSMutableArray *)columnHeights
{
    if (!_columnHeights) {
        _columnHeights = [NSMutableArray array];
    }
    return _columnHeights;
}

- (NSMutableArray *)attrsArray
{
    if (!_attrsArray) {
        _attrsArray = [NSMutableArray array];
    }
    return _attrsArray;
}

@end
