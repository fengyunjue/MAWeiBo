//
//  MWPhotos.m
//  MAWeibo
//
//  Created by admin on 14-10-31.
//  Copyright (c) 2014年 mage. All rights reserved.
//

#import "MWPhotosView.h"
#import "UIImageView+WebCache.h"
#import "MWPhoto.h"
#import "MWPhotoView.h"
#import "MJPhotoBrowser.h"
#import "MJPhoto.h"


#define MWPhotosViewWH 60
#define MWPhotosViewBorder 5

@implementation MWPhotosView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        // 初始化子视图
        for (NSInteger i = 0; i < 9; i++) {
            MWPhotoView *imageView  = [[MWPhotoView alloc]init];
            [self addSubview:imageView];
            
            [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick:)]];
            imageView.tag = i;
        }
    }
    return self;
}

- (void)tapClick:(UITapGestureRecognizer *)gestureRecognizer
{
    int count = self.photos.count;
    // 1.封装图片数据
    NSMutableArray *photos = [NSMutableArray arrayWithCapacity:count];
    for (int i = 0; i<count; i++) {
        // 替换为中等尺寸图片
        MWPhoto *ph = self.photos[i];
        NSString *url = [ph.thumbnail_pic stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"bmiddle"];
        MJPhoto *photo = [[MJPhoto alloc] init];
        photo.url = [NSURL URLWithString:url]; // 图片路径
        photo.srcImageView = self.subviews[i]; // 来源于哪个UIImageView
        [photos addObject:photo];
    }
    
    // 2.显示相册
    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
    browser.currentPhotoIndex = gestureRecognizer.view.tag; // 弹出相册时显示的第一张图片是？
    browser.photos = photos; // 设置所有的图片
    [browser show];
}



- (void)setPhotos:(NSArray *)photos
{
    _photos = photos;
    // 最大的列数
    int MaxColumns = (photos.count == 4) ? 2 : 3;
    
    for (NSInteger i = 0; i < self.subviews.count; i++) {
        MWPhotoView *photoView = self.subviews[i];
        if (i < photos.count) {
            
            photoView.hidden = NO;
            // 传递模型数据
            photoView.photo = photos[i];
            // 列数
            int col = i % MaxColumns;
            // 行数
            int row = i / MaxColumns;
            CGFloat PhotoX = col * (MWPhotosViewWH + MWPhotosViewBorder);
            CGFloat PhotoY = row * (MWPhotosViewWH + MWPhotosViewBorder);
            photoView.frame = CGRectMake(PhotoX, PhotoY, MWPhotosViewWH, MWPhotosViewWH);
            
            if (photos.count == 1) {
                photoView.contentMode = UIViewContentModeScaleAspectFit;
                photoView.clipsToBounds = NO;
            }else{
                photoView.contentMode = UIViewContentModeScaleAspectFill;
                photoView.clipsToBounds = YES;
            }
            
        }else{
            photoView.hidden = YES;
        }
    }
    
}


+ (CGSize)MWPhotosViewRectWithImageCount:(NSInteger)count
{
    int MaxColumns = (count == 4) ? 2 : 3;
    
    int row = (count + MaxColumns - 1) / MaxColumns;
    int col = count >= MaxColumns ? MaxColumns : count;
    
    CGFloat photoW = col * (MWPhotosViewBorder + MWPhotosViewWH) - MWPhotosViewBorder;
    CGFloat photoH = row * (MWPhotosViewBorder + MWPhotosViewWH) - MWPhotosViewBorder;
    return CGSizeMake(photoW, photoH);
}



@end
