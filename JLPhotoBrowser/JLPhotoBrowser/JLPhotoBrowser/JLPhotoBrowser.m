//
//  JLPhotoBrowser.m
//  JLPhotoBrowser
//
//  Created by 住梦iOS on 2017/5/25.
//  Copyright © 2017年 qiongjiwuxian. All rights reserved.
//

#import "JLPhotoBrowser.h"
#import "JLPhotoCollectionViewCell.h"

///屏幕宽度
#define SCREEN_W [UIScreen mainScreen].bounds.size.width
///屏幕高度
#define SCREEN_H [UIScreen mainScreen].bounds.size.height

@interface JLPhotoBrowser ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong) UICollectionView *collectionView;

@property (nonatomic,strong) UILabel *titleLabel;



@end

@implementation JLPhotoBrowser

#pragma mark - 懒加载
-(UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumLineSpacing = 10;
        layout.minimumInteritemSpacing = 10;
        layout.itemSize = CGSizeMake(SCREEN_W, SCREEN_H);
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(-5, 0, SCREEN_W + 10, SCREEN_H) collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.pagingEnabled = YES;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.backgroundColor = [UIColor clearColor];
        
        [_collectionView registerClass:[JLPhotoCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    }
    return _collectionView;
}
-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake((SCREEN_W - 100)/2, 20, 100, 44)];
        
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        
        _titleLabel.font = [UIFont systemFontOfSize:20];
        
        _titleLabel.textColor = [UIColor whiteColor];
    }
    return _titleLabel;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.1];
    
    [self.view addSubview:self.collectionView];
    
    [self.view addSubview:self.titleLabel];
    
    self.titleLabel.text = [NSString stringWithFormat:@"%ld / %ld",self.currentIndex + 1,self.Photos.count];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
//页面显示
-(void)show{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    [window addSubview:self.view];
    
    [window.rootViewController addChildViewController:self];
}
#pragma mark - collectionView 协议
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    JLPhotoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.bigSuperView = self.view;
    
    
    cell.photo = self.Photos[indexPath.row];
    
    
    
    
    
    return cell;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.Photos.count;
}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 5, 0, 5);
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    JLPhotoCollectionViewCell *cell = (JLPhotoCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    
    if (cell.myImageView.frame.size.width != SCREEN_W) {
        return;
    }
    [self dissmiss:cell.myImageView index:indexPath.row];
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    self.titleLabel.text = [NSString stringWithFormat:@"%ld / %ld",(NSInteger)scrollView.contentOffset.x/(NSInteger)self.collectionView.frame.size.width + 1,self.Photos.count];
}
#pragma mark - set Index
-(void)setCurrentIndex:(NSInteger)currentIndex{
    _currentIndex = currentIndex;
    
    
    self.collectionView.contentOffset = CGPointMake(currentIndex * self.collectionView.frame.size.width, 0);
    
    
}

#pragma mark - 回去的动画
-(void)dissmiss:(UIImageView *)imageView
          index:(NSInteger)index{
    self.titleLabel.hidden = YES;
    //如果是gif图，则显示第一张
    if (self.Photos[index].image.images) {
        imageView.image = self.Photos[index].image.images[0];
    }
    
    
    [UIView animateWithDuration:0.35 animations:^{
        imageView.frame =  [self.Photos[index].srcImageView convertRect:self.Photos[index].srcImageView.bounds toView:nil];
        self.view.backgroundColor = [UIColor colorWithRed:0 green:0  blue:0 alpha:0.1];
    } completion:^(BOOL finished) {
        [self.view removeFromSuperview];
        [self removeFromParentViewController];
    }];
}
@end
