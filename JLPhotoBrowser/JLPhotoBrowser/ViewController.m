//
//  ViewController.m
//  JLPhotoBrowser
//
//  Created by 住梦iOS on 2017/5/25.
//  Copyright © 2017年 qiongjiwuxian. All rights reserved.
//

#import "ViewController.h"
#import "UIImageView+WebCache.h"
#import "JLPhotoBrowser.h"

@interface ViewController ()

@end

@implementation ViewController{
    NSArray *_urls;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _urls = @[@"https://ss0.baidu.com/94o3dSag_xI4khGko9WTAnF6hhy/image/h%3D200/sign=390a6d90bcfd5266b82b3b149b199799/8601a18b87d6277f26ee534322381f30e824fcc9.jpg",@"https://ss1.baidu.com/-4o3dSag_xI4khGko9WTAnF6hhy/image/h%3D200/sign=a26ec95df7faaf519be386bfbc5594ed/4610b912c8fcc3ceaf88a8489845d688d43f2004.jpg",@"https://ss0.baidu.com/94o3dSag_xI4khGko9WTAnF6hhy/image/h%3D200/sign=d9cdd8413a4e251ffdf7e3f89787c9c2/72f082025aafa40fd302b4a6a164034f79f01980.jpg",@"https://ss0.baidu.com/7Po3dSag_xI4khGko9WTAnF6hhy/image/h%3D200/sign=8a78ab5a9aef76c6cfd2fc2bad17fdf6/f9dcd100baa1cd111d2e0b5bb312c8fcc3ce2d34.jpg",@"https://ss1.baidu.com/-4o3dSag_xI4khGko9WTAnF6hhy/image/h%3D200/sign=0b9c7c052f1f95cab9f595b6f9167fc5/83025aafa40f4bfb677be72f094f78f0f7361825.jpg",@"https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=351109312,2084066331&fm=23&gp=0.jpg"];
    
    

    
    // 1.创建6个UIImageView
    UIImage *placeholder = [UIImage imageNamed:@"timeline_image_loading.png"];
    CGFloat width = 100;
    CGFloat height = 100;
    CGFloat margin = 20;
    CGFloat startX = (self.view.frame.size.width - 3 * width - 2 * margin) * 0.5;
    CGFloat startY = 50;
    for (int i = 0; i<6; i++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        [self.view addSubview:imageView];
        
        // 计算位置
        int row = i/3;
        int column = i%3;
        CGFloat x = startX + column * (width + margin);
        CGFloat y = startY + row * (height + margin);
        imageView.frame = CGRectMake(x, y, width, height);
        
        // 下载图片
        [imageView sd_setImageWithURL:[NSURL URLWithString:_urls[i]] placeholderImage:placeholder];
        
        // 事件监听
        imageView.tag = i + 100;
        imageView.userInteractionEnabled = YES;
        [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImage:)]];
        
        // 内容模式
        imageView.clipsToBounds = YES;
        imageView.contentMode = UIViewContentModeScaleAspectFill;
    }
}


- (void)tapImage:(UITapGestureRecognizer *)tap
{
    
    NSArray *bigUrls = @[@"http://imgsrc.baidu.com/imgad/pic/item/d01373f082025aafb71898eef1edab64034f1ae8.jpg",@"http://imgsrc.baidu.com/imgad/pic/item/09fa513d269759eed82111e9b8fb43166d22df9b.jpg",@"http://imgsrc.baidu.com/imgad/pic/item/42a98226cffc1e171814dc144090f603738de968.jpg",@"http://imgsrc.baidu.com/imgad/pic/item/9d82d158ccbf6c81dc725dcab63eb13533fa404e.jpg",@"http://imgsrc.baidu.com/imgad/pic/item/50da81cb39dbb6fd002eaf030324ab18972b3799.jpg",@"http://ww2.sinaimg.cn/large/85cccab3gw1etewruvn0ug20ci0711l2.jpg"];
    NSInteger count = bigUrls.count;
    // 1.封装图片数据
    NSMutableArray *photos = [NSMutableArray arrayWithCapacity:count];
    for (int i = 0; i<count; i++) {
        // 替换为中等尺寸图片
        NSString *url = bigUrls[i];
        JLPhoto *photo = [[JLPhoto alloc] init];
        photo.url = url; // 图片路径
        photo.srcImageView = [self.view viewWithTag:i + 100]; // 来源于哪个UIImageView
        photo.index = tap.view.tag - 100;
        if (i == tap.view.tag - 100) {
            photo.isFirstShow = YES;
        }
        [photos addObject:photo];
    }
    
    // 2.显示相册
    JLPhotoBrowser *browser = [[JLPhotoBrowser alloc] init];
    browser.currentIndex = tap.view.tag - 100; // 弹出相册时显示的第一张图片是？
    browser.Photos = photos; // 设置所有的图片
    [browser show];
}



@end
