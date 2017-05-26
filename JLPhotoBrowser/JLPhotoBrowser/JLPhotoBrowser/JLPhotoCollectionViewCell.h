//
//  JLPhotoCollectionViewCell.h
//  JLPhotoBrowser
//
//  Created by 住梦iOS on 2017/5/25.
//  Copyright © 2017年 qiongjiwuxian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JLPhoto.h"

@interface JLPhotoCollectionViewCell : UICollectionViewCell

//图片
@property(nonatomic,strong) JLPhoto *photo;
//图片视图
@property (nonatomic,strong) UIImageView *myImageView;
//祖父视图
@property (nonatomic,strong) UIView *bigSuperView;


//初始化方法
-(instancetype)initWithFrame:(CGRect)frame;


@end
