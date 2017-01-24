# ZZHBannerDemo
一个简单的轮播图小示例，示例程序中两种思路轮播，BannerVIew  为初学阶段的5123451思路 ，PageView 利用三个UIImageView实现五险轮播
##UIScrollVIew 实现轮播图

想想以前面试官问你怎么写轮播图，我还很装逼的说5123451思路制造假象实现跳转轮播，现在想想，真是 too young too simple，于是我自己试着封装了一个利用三个UIImageVIew 思路 进行无限轮播

实现思路：默认加载三张UIImageView，无论怎么滑动永远显示中间那张，每次滑动先渲染图片在切换scrollView的contentOffSet到中间，造成无限循环的假象

- 核心代码

首先渲染三张图片  最后一张  第一张 第二张，渲染后让scrollView滑到中间图片位置，然后向右滑动 到第二张的位置  渲染三张图片为 第一张 第二张 第三张，  然后让scrollVIew滑动到中间第二张的位置，依次类推，造成循环的假象！
```

#pragma mark  更新图片 渲染
//渲染图片的方法
- (void)updateImage{
    //始终让中间的图片显示
    //图片变换顺序后 设置scrollView contentOffset 显示中间
    for (int i = 0; i < COUNT; i++) {
        ZZHImageView * imageView = self.scrollView.subviews[i];
        NSInteger index = self.pageControl.currentPage;
        if(i == 0){ 
            index --;
        }else if (i == 2){
            index++;
        }
        if (index < 0) {
            //第一张的前一张是最后一张
            index = self.imageArr.count - 1;
        } else if (index >= self.imageArr.count) {
            //最后一张的的后一张是第一张
            index = 0;
        }
        //把index赋给imageView  起到媒介作用， 后面拿到tag 就是pageControl的index
        imageView.tag = index;
        imageView.image = [UIImage imageNamed:self.imageArr[index]];
    }
//跳转到中间图片位置
    self.scrollView.contentOffset = CGPointMake(self.scrollView.frame.size.width, 0);
}

```

在scrollViewDidScroll方法中获取滑动结束后停留在最中间位置的UIImageView， 就是当前显示的图片。

```

#pragma mark - UIScrollviewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //找到位于最中间的imageView;
    //scroll滚动时 判断三个图片的x与scrollView的contentOffset的x 的绝对值最小的就是即将停在最中间的imageView
    NSInteger page = 0;
    CGFloat minDistance = MAXFLOAT;
    for (int i = 0; i<COUNT; i++) {
        ZZHImageView *imageView = self.scrollView.subviews[i];
        CGFloat distance = ABS(imageView.frame.origin.x - scrollView.contentOffset.x);
        if (distance < minDistance) {
            minDistance = distance;
            //拿到中间位置的tag 设置 pageControl 的currentPage
            page = imageView.tag;
        }
    }
//当前是第几张图片
    self.pageControl.currentPage = page;
}
//手动拖拽结束后重新渲染
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self updateImage];
}
//定时器 动画结束后重新渲染
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    [self updateImage];
}

```
