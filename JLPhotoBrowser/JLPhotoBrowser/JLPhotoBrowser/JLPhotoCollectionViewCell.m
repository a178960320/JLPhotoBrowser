//
//  JLPhotoCollectionViewCell.m
//  JLPhotoBrowser
//
//  Created by 住梦iOS on 2017/5/25.
//  Copyright © 2017年 qiongjiwuxian. All rights reserved.
//

#import "JLPhotoCollectionViewCell.h"
#import "JLPhotoBrowser.h"
#import "UIImageView+WebCache.h"


///屏幕宽度
#define SCREEN_W [UIScreen mainScreen].bounds.size.width
///屏幕高度
#define SCREEN_H [UIScreen mainScreen].bounds.size.height

@interface JLPhotoCollectionViewCell()


@end


@implementation JLPhotoCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self.contentView addSubview:self.myImageView];
    }
    return self;
}
#pragma mark - setPhoto

-(void)setPhoto:(JLPhoto *)photo{
    _photo = photo;
    
    
    
    
    //如果是本地图片直接赋值
    if (photo.image) {
        self.myImageView.image = photo.image;
        //如果是第一个展示
        if (photo.isFirstShow) {
            
            self.myImageView.frame = [photo.srcImageView convertRect:photo.srcImageView.bounds toView:nil];
            
            [self stratAnimation:photo.image];
        }else{
            self.myImageView.frame = CGRectMake(5, 0, SCREEN_W, [self getHeightWithMaxWidth:SCREEN_W image:photo.image]);
            self.myImageView.center = [UIApplication sharedApplication].keyWindow.center;
        }
        
        
    }else{
        //如果是第一次显示且是gif
        if (photo.isFirstShow && ([[NSURL URLWithString:photo.url].absoluteString hasSuffix:@"gif"] || photo.srcImageView.image.images )){
            self.myImageView.image = photo.srcImageView.image;
            
            self.myImageView.frame = [photo.srcImageView convertRect:photo.srcImageView.bounds toView:nil];
            
            [self stratAnimation:photo.srcImageView.image];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.35 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self loadPic:photo];
            });
        }else{
            [self loadPic:photo];
        }
        
        
    }
}


#pragma mark - 懒加载
-(UIImageView *)myImageView{
    if (!_myImageView) {
        _myImageView = [UIImageView new];
    }
    return _myImageView;
}


//根据比例返回高度
-(CGFloat) getHeightWithMaxWidth:(CGFloat) width
                           image:(UIImage *) image{
    CGFloat imgX = CGImageGetWidth(image.CGImage);
    CGFloat imgY = CGImageGetHeight(image.CGImage);
    
    CGFloat H = imgY/imgX * width;
    return H;
}
//开始动画
-(void)stratAnimation:(UIImage *)image{
    [UIView animateWithDuration:0.35 animations:^{
        
        self.myImageView.frame = CGRectMake(5, 0, [UIScreen mainScreen].bounds.size.width, [self getHeightWithMaxWidth:[UIScreen mainScreen].bounds.size.width image:image]);
        
        self.myImageView.center = [UIApplication sharedApplication].keyWindow.center;
        
        self.bigSuperView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:1];
        
    } completion:^(BOOL finished) {
        self.photo.isFirstShow = NO;
    }];
}
//加载图片
-(void)loadPic:(JLPhoto *)photo{
    [self.myImageView sd_setImageWithURL:[NSURL URLWithString:photo.url] placeholderImage:photo.srcImageView.image options:SDWebImageRetryFailed|SDWebImageLowPriority progress:^(NSInteger receivedSize , NSInteger expectedSize) {
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType , NSURL *imageUrl) {
        if (image) {
            photo.image = image;
            self.myImageView.image = image;
            //如果是第一个展示,并且不是gif
            if (photo.isFirstShow  && !image.images) {
                
                self.myImageView.frame = [photo.srcImageView convertRect:photo.srcImageView.bounds toView:nil];
                
                [self stratAnimation:image];
            }else{
                self.myImageView.frame = CGRectMake(5, 0, SCREEN_W, [self getHeightWithMaxWidth:SCREEN_W image:photo.image]);
                self.myImageView.center = [UIApplication sharedApplication].keyWindow.center;
            }
        }else{
            
            if (photo.isFirstShow) {
                self.myImageView.frame = [photo.srcImageView convertRect:photo.srcImageView.bounds toView:nil];
                [self stratAnimation:photo.srcImageView.image];
            }else{
                self.myImageView.frame = CGRectMake(5, 0, SCREEN_W, [self getHeightWithMaxWidth:SCREEN_W image:photo.srcImageView.image]);
                self.myImageView.center = [UIApplication sharedApplication].keyWindow.center;
            }
        }
    }];

}
@end
