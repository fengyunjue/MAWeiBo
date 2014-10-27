//
//  MWNewFeatureViewController.m
//  MAWeibo
//
//  Created by admin on 14-10-26.
//  Copyright (c) 2014年 mage. All rights reserved.
//

#import "MWNewFeatureViewController.h"
#import "MWTabBarViewController.h"

#define IWNewfeatureImageCount 3

@interface MWNewFeatureViewController ()<UIScrollViewDelegate>

@property (nonatomic, weak) UIPageControl *pageControl;

@end

@implementation MWNewFeatureViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 1.加载ScrollView
    [self setupScrollView];
    
    // 2. 加载pageControl
    [self setuppageControl];

}
/**
 *  加载pageControl
 */
- (void)setuppageControl
{
    CGFloat width = self.view.frame.size.width;
    CGFloat height = self.view.frame.size.height;
    // 设置分页控制器
    UIPageControl *pageControl = [[UIPageControl alloc]init];
    [pageControl setCenter:CGPointMake(width * 0.5, height - 30)];
    [pageControl setNumberOfPages:3];
    [pageControl setCurrentPage:0];
    [pageControl setCurrentPageIndicatorTintColor:[UIColor colorWithPatternImage:[UIImage imageWithName:@"new_feature_pagecontrol_checked_point"]]];
    [pageControl setPageIndicatorTintColor:[UIColor colorWithPatternImage:[UIImage imageWithName:@"new_feature_pagecontrol_point"]]];
    
    self.pageControl = pageControl;
    [self.view addSubview:pageControl];
}

/**
 *  加载ScrollView
 */
- (void)setupScrollView
{
    // 初始化ScrollView
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:self.view.frame];
    CGFloat width = self.view.frame.size.width;
    CGFloat height = self.view.frame.size.height;
    // 加载图片
    for (NSInteger index = 0; index < IWNewfeatureImageCount; index++) {
        UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageWithName:[NSString stringWithFormat:@"new_feature_%d",index + 1]]];
        [imageView setFrame:CGRectMake(index * width, 0, imageView.image.size.width, imageView.image.size.height)];
        [scrollView addSubview:imageView];
        
        if (index == IWNewfeatureImageCount - 1) {
            [self setupButton:imageView];
        }
    }
    // 设置contentSize
    [scrollView setContentSize:CGSizeMake(width * 3, height)];
    // 设置允许分页
    scrollView.pagingEnabled = YES;
    // 取消弹簧
    scrollView.bounces = NO;
    // 取消提示条
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.delegate = self;
    
    [self.view addSubview:scrollView];
}
- (void)setupButton:(UIImageView *)imageView
{
    CGFloat width = self.view.frame.size.width;
    CGFloat height = self.view.frame.size.height;
    
    // 0. 让imageView能跟用户交互
    imageView.userInteractionEnabled = YES;
    // 1. 添加开始按钮
    UIButton *button = [[UIButton alloc]init];
    [button setBackgroundImage:[UIImage imageWithName:@"new_feature_finish_button"] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageWithName:@"new_feature_finish_button_highlighted"] forState:UIControlStateHighlighted];
    button.center = CGPointMake(width * 0.5, height * 0.6);
    button.bounds = (CGRect){CGPointZero, button.currentBackgroundImage.size};
    [button setTitle:@"开始微博" forState:UIControlStateNormal];
    // 2. 添加监听事件
    [button addTarget:self action:@selector(start:) forControlEvents:UIControlEventTouchUpInside];
    [imageView addSubview:button];
    
    // 3.添加分享按钮checkbox
    UIButton *checkbox = [[UIButton alloc]init];
    checkbox.selected = YES;
    // 设置标题
    [checkbox setTitle:@"分享给大家" forState:UIControlStateNormal];
    [checkbox setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    // 设置图片
    [checkbox setImage:[UIImage imageWithName:@"new_feature_share_false"] forState:UIControlStateNormal];
    [checkbox setImage:[UIImage imageWithName:@"new_feature_share_true"] forState:UIControlStateSelected];
    // 设置文字与图片的间距
    checkbox.imageEdgeInsets =UIEdgeInsetsMake(0, 0, 0, 10);
    // 设置位置
    checkbox.bounds = CGRectMake(0, 0, 200, 50);
    checkbox.center = CGPointMake(width * 0.5, height * 0.5);
    checkbox.titleLabel.font = [UIFont systemFontOfSize:15];
    
    [checkbox addTarget:self action:@selector(checkClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [imageView addSubview:checkbox];

}

- (void)checkClick:(UIButton *)button
{
    button.selected = !button.isSelected;
}

- (void)start:(UIButton *)button
{
    [UIApplication sharedApplication].statusBarHidden = NO;
    [UIApplication sharedApplication].keyWindow.rootViewController = [[MWTabBarViewController alloc]init];
}

/**
 *  ScrollView滚动时就会执行
 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    double pageDouble = scrollView.contentOffset.x / self.view.frame.size.width;
    int pageInt = (int)(pageDouble + 0.5);
    
    self.pageControl.currentPage = pageInt;
    
}


@end
