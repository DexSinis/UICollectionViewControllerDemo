//
//  Demo1BaseViewController.m
//  UICollectionViewControllerDemo
//
//  Created by litt1e-p on 15/12/28.
//  Copyright © 2015年 litt1e-p. All rights reserved.
//

#import "Demo1BaseViewController.h"

@interface Demo1BaseViewController ()

@end

@implementation Demo1BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initRightBarBtn];
}

- (void)initRightBarBtn
{
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"Demo2" style:UIBarButtonItemStylePlain target:self action:@selector(switchToDemo2)];
    self.navigationItem.rightBarButtonItem = item;
}

- (void)switchToDemo2
{
    UIStoryboard *demo2Sb = [UIStoryboard storyboardWithName:@"Demo2" bundle:nil];
    [UIApplication sharedApplication].keyWindow.rootViewController = [demo2Sb instantiateInitialViewController];
}

@end
