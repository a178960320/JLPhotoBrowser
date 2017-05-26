//
//  JLPhoto.h
//  JLPhotoBrowser
//
//  Created by 住梦iOS on 2017/5/25.
//  Copyright © 2017年 qiongjiwuxian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JLPhoto : NSObject

//图片链接
@property (nonatomic,strong) NSString *url;
//完整图片
@property (nonatomic,strong) UIImage *image;
//图片来源的imageView
@property (nonatomic,strong) UIImageView *srcImageView;
//是否第一个显示
@property (nonatomic,assign) BOOL isFirstShow;
//索引
@property (nonatomic,assign) NSInteger index;

@end
