//
//  InfiniteCarouselModel.h
//  UICollectionViewControllerDemo
//
//  Created by litt1e-p on 15/12/29.
//  Copyright © 2015年 litt1e-p. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface InfiniteCarouselModel : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *icon;

- (id)initWithDict:(NSDictionary *)dict;
+ (id)modelWithDict:(NSDictionary *)dict;

@end
