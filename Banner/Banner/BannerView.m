//
//  Bannner.m
//  Banner
//
//  Created by cm on 15/11/12.
//  Copyright © 2015年 cm. All rights reserved.
//

#import "BannerView.h"

#define ScreenWidth [UIScreen mainScreen].bounds.size.width

@interface BannerView ()<UIScrollViewDelegate>
@property(strong, nonatomic)UIScrollView *scrollView;
@property(strong, nonatomic)UIImageView *leftImage;
@property(strong, nonatomic)UIImageView *rightImage;
@property(strong, nonatomic)UIImageView *centerImage;
@property(strong, nonatomic)UIPageControl *pageControl;

@property(weak, nonatomic)NSTimer *timer;

@property(assign, nonatomic)NSInteger currentIndex;

@end

@implementation BannerView

#pragma mark - life cycle
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self settingInit];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self settingInit];
    }
    return self;
}

- (void)settingInit{
    _currentIndex = 0;
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, self.frame.size.height)];
    _scrollView.contentOffset = CGPointMake(ScreenWidth, 0);
    _scrollView.pagingEnabled = YES;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.delegate = self;
    _scrollView.contentSize = CGSizeMake(ScreenWidth * 3, self.frame.size.height);
    _scrollView.contentOffset = CGPointMake(ScreenWidth, 0);

    [self addSubview:_scrollView];
    
    NSInteger width = ScreenWidth;
    _leftImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, width, self.frame.size.width)];
    [_scrollView addSubview:_leftImage];
    
    _centerImage = [[UIImageView alloc] initWithFrame:CGRectMake(width, 0, width, self.frame.size.width)];
    [_scrollView addSubview:_centerImage];
    
    _rightImage = [[UIImageView alloc] initWithFrame:CGRectMake(2*width, 0, width, self.frame.size.width)];
    [_scrollView addSubview:_rightImage];
}

- (void)drawRect:(CGRect)rect{
    [self startTimer];
}

#pragma mark - setter getter
- (void)setImageArray:(NSArray *)imageArray{
    _imageArray = imageArray;
    
    NSInteger count = [imageArray count];
    _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(ScreenWidth - 20 * count, self.bounds.size.height - 30, 20 * count, 30)];
    _pageControl.numberOfPages = count;
    _pageControl.currentPage = 0;
    _pageControl.hidesForSinglePage = YES;
    [self addSubview:_pageControl];
    
    self.leftImage.image = imageArray[count - 1];
    self.centerImage.image = imageArray[0];
    self.rightImage.image = imageArray[1];

}

- (void)setCurrentPointColor:(UIColor *)currentPointColor{
    self.pageControl.currentPageIndicatorTintColor = currentPointColor;
}

- (void)setPointColor:(UIColor *)pointColor{
    self.pageControl.pageIndicatorTintColor = pointColor;
}

- (void)setDelegate:(id<BannerViewProtocol>)delegate{
    _delegate = delegate;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
    [self addGestureRecognizer:tap];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
    [self stopTimer];
    self.userInteractionEnabled = NO;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if (scrollView.contentOffset.x >= 2 * ScreenWidth) {
        self.currentIndex = (self.currentIndex + 1)%[self.imageArray count];
    }else if(scrollView.contentOffset.x < ScreenWidth){
        self.currentIndex = (self.currentIndex - 1 + [self.imageArray count])%[self.imageArray count];
    }
    
    NSInteger leftIndex = (self.currentIndex - 1 + [self.imageArray count])%[self.imageArray count];
    NSInteger rightIndex = (self.currentIndex + 1)%[self.imageArray count];
    self.leftImage.image = self.imageArray[leftIndex];
    self.centerImage.image = self.imageArray[self.currentIndex];
    self.rightImage.image = self.imageArray[rightIndex];
    
    scrollView.contentOffset = CGPointMake(scrollView.frame.size.width, 0);
    self.pageControl.currentPage = self.currentIndex;
    self.userInteractionEnabled = YES;
    [self startTimer];
}

#pragma mark - event response
- (void)tap{
    if ([self.delegate respondsToSelector:@selector(bannerView:didSelectIndex:)]) {
        [self.delegate bannerView:self didSelectIndex:self.currentIndex];
    }
}

#pragma mark - private
- (void)nextPage{
    self.currentIndex = (self.currentIndex + 1)%[self.imageArray count];
    self.pageControl.currentPage = self.currentIndex;
    self.centerImage.image = self.imageArray[self.currentIndex];
}

- (void)startTimer{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
}

- (void)stopTimer{
    [self.timer invalidate];
    self.timer = nil;
}


@end
