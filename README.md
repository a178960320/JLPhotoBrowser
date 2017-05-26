# JLPhotoBrowser是一款看大图的第三方库，简单实用。

![img](http://recordit.co/7Zti1jMOxD.gif)

## 如何使用

>1、 下载Demo,在需要看大图的页面导入JLPhotoBrowser.h、JLPhoto.h。
JLPhoto是用于存储图片的信息，包括以下属性：
```Objective-C
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
```

>2、 给photos赋值。
```Objective-C

NSArray *bigUrls = @[@"",@"",@""];图片地址数组

NSMutableArray *photos = [[NSMutableArray alloc] init];

for (int i = 0; i<count; i++) {
        // 替换为中等尺寸图片
        NSString *url = bigUrls[i];
        
        JLPhoto *photo = [[JLPhoto alloc] init];
        
        photo.url = url; // 图片路径
        
        photo.srcImageView = [self.view viewWithTag:i + 100]; // 来源于哪个UIImageView
        
        photo.index = tap.view.tag - 100;
        
        if (i == tap.view.tag - 100) {
        
            photo.isFirstShow = YES; //决定是不是第一个显示的图片。
        }
        [photos addObject:photo];
}

```

>3、 初始化JLPhotoBrowser
```Objective-C
    //初始化
    JLPhotoBrowser *browser = [[JLPhotoBrowser alloc] init];
    
    browser.currentIndex = tap.view.tag - 100; // 弹出相册时显示的第一张图片是第几张
    
    browser.Photos = photos; // 设置所有的图片
    //显示相册
    [browser show];
```

