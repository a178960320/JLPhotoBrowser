//
//  JLPhotoBrowser.h
//  JLPhotoBrowser
//
//  Created by 住梦iOS on 2017/5/25.
//  Copyright © 2017年 qiongjiwuxian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JLPhoto.h"

@interface JLPhotoBrowser : UIViewController

@property (nonatomic,strong) NSArray <JLPhoto *>*Photos;

@property (nonatomic,assign) NSInteger currentIndex;

-(void)show;

@end
