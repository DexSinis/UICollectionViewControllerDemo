//
//  InfiniteCarouselModel.m
//  UICollectionViewControllerDemo
//
//  Created by litt1e-p on 15/12/29.
//  Copyright © 2015年 litt1e-p. All rights reserved.
//

#import "InfiniteCarouselModel.h"

@implementation InfiniteCarouselModel

- (id)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        self.title = dict[@"title"];
        self.icon  = dict[@"icon"];
    }
    return self;
}

+ (id)modelWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}

@end
