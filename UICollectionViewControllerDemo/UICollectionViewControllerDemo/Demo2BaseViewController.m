//
//  Demo2BaseViewController.m
//  UICollectionViewControllerDemo
//
//  Created by litt1e-p on 15/12/28.
//  Copyright © 2015年 litt1e-p. All rights reserved.
//

#import "Demo2BaseViewController.h"

@interface Demo2BaseViewController ()

@end

@implementation Demo2BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initRightBarBtn];
}

- (void)initRightBarBtn
{
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"Demo1" style:UIBarButtonItemStylePlain target:self action:@selector(switchToDemo1)];
    self.navigationItem.rightBarButtonItem = item;
}

- (void)switchToDemo1
{
    UIStoryboard *demo1Sb = [UIStoryboard storyboardWithName:@"Demo1" bundle:nil];
    [UIApplication sharedApplication].keyWindow.rootViewController = [demo1Sb instantiateInitialViewController];
}

@end
