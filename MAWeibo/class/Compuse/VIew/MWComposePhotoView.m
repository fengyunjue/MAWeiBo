//
//  MWComposePhotoView.m
//  MAWeibo
//
//  Created by admin on 14-11-3.
//  Copyright (c) 2014年 mage. All rights reserved.
//

#import "MWComposePhotoView.h"
@interface MWComposePhotoView()<UIAlertViewDelegate>

@property (nonatomic ,weak) UIImageView *imageView;

@property (nonatomic ,weak) UIImageView *deleteImageView;

@end

@implementation MWComposePhotoView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageWithName:@"compose_pic_add"]];
        [self addSubview:imageView];
        self.imageView = imageView;
        imageView.userInteractionEnabled = YES;
        [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(add:)]];
    }
    return self;
}
/**
 *  添加图片事件
 */
-(void)add:(UITapGestureRecognizer *)pan
{
    if ([self.degelate respondsToSelector:@selector(composePhotoViewAddButton:)]) {
        [self.degelate composePhotoViewAddButton:self];
    }
}

/**
 *  添加图片
 */
- (void)addImage:(UIImage *)image
{
    UIImageView *imageView = [[UIImageView alloc]initWithImage:image];
    imageView.userInteractionEnabled = YES;
     [imageView addGestureRecognizer:[[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(deleteImage:)]];
    [self insertSubview:imageView belowSubview:self.imageView];
}
/**
 *  删除图片事件
 */
- (void)deleteImage:(UILongPressGestureRecognizer *)recognizer
{
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"是否确定删除此照片" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alert show];
    }
    self.deleteImageView = (UIImageView *)recognizer.view;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        [self.deleteImageView removeFromSuperview];
    }
}

- (void)layoutSubviews
{
    CGFloat viewBorder = 5;
    CGFloat imageViewW = 70;
    CGFloat imageViewH = imageViewW;
    for (int i = 0; i < self.subviews.count; i++) {
        int col = i % 3;
        int row = i / 3;
        UIImageView *imageView = self.subviews[i];
        
        imageView.frame = CGRectMake((imageViewW + viewBorder) * col, (imageViewH + viewBorder) * row, imageViewW, imageViewH);
    }
    
}

- (NSArray *)images
{
    NSMutableArray *array = [NSMutableArray arrayWithArray:self.subviews];
    [array removeLastObject];
    return array;
}

@end
