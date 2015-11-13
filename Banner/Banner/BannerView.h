//
//  Bannner.h
//  Banner
//
//  Created by cm on 15/11/12.
//  Copyright © 2015年 cm. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BannerView;
@protocol BannerViewProtocol <NSObject>
- (void)bannerView:(BannerView*)bannerView didSelectIndex:(NSInteger)index;

@end

@interface BannerView : UIView
@property(strong, nonatomic)NSArray *imageArray;
@property(strong, nonatomic)UIColor *currentPointColor;
@property(strong, nonatomic)UIColor *pointColor;

@property(weak, nonatomic)id<BannerViewProtocol>delegate;



@end
