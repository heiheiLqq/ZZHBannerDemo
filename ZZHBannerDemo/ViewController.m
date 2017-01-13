//
//  ViewController.m
//  轮播图封装练习
//
//  Created by zzh on 2017/1/12.
//  Copyright © 2017年 zzh. All rights reserved.
//

#import "ViewController.h"
#import "ZZHBannerView.h"
#import "ZZHPageView.h"
@interface ViewController ()<ZZHBannerViewDelegate,ZZHPageViewDelegate>

@end

@implementation ViewController


-(void)viewDidLoad{
    
    [super viewDidLoad];
    ZZHPageView * pageView = [ZZHPageView pageView];
    pageView.frame = CGRectMake(30, 50, 300, 130);
    
    pageView.imageArr = @[@"img_00",@"img_01",@"img_02",@"img_03",@"img_04"];
    pageView.selectColor = [UIColor orangeColor];
    pageView.normalColor = [UIColor grayColor];
    pageView.delegate = self;
    [self.view addSubview:pageView];
    pageView.clickBlock=^(NSInteger index){
        
        
        NSLog(@"我是block的回调点击事件，%ld",index);
    };
    
    
    ZZHBannerView * bannerView = [ZZHBannerView bannerView];
    bannerView.frame = CGRectMake(30, 100, 300, 130);
    bannerView.center = self.view.center;
    bannerView.imageArr = @[@"img_00",@"img_01",@"img_02",@"img_03",@"img_04"];
    bannerView.selectColor = [UIColor orangeColor];
    bannerView.normalColor = [UIColor grayColor];
    bannerView.delegate = self;
    [self.view addSubview:bannerView];
    
    bannerView.clickBlock=^(NSInteger index){
        
        
        NSLog(@"我是block的回调点击事件，%ld",index);
    };
    
    
}
-(void)pageViewDidClick:(NSInteger)index{
    
    NSLog(@"我是代理的回调点击事件%ld",index);
    
}


-(void)bannerViewDidClick:(NSInteger)index{
    
    NSLog(@"我是代理的回调点击事件%ld",index);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
