//
//  ViewController.m
//  Banner
//
//  Created by cm on 15/11/12.
//  Copyright © 2015年 cm. All rights reserved.
//

#import "ViewController.h"
#import "BannerView.h"

@interface ViewController ()<BannerViewProtocol>
@property (weak, nonatomic) IBOutlet BannerView *banner;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    BannerView *banner = [[BannerView alloc] initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, 80)];
//    banner.imageArray = @[[UIColor redColor],[UIColor greenColor],[UIColor blueColor]];
//    [self.view addSubview:banner];
    self.banner.imageArray = @[[UIImage imageNamed:@"image0"],[UIImage imageNamed:@"image1"],[UIImage imageNamed:@"image2"]];
    self.banner.delegate = self;

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    TTViewController *ttController = [[TTViewController alloc] initWithNibName:@"TTViewController" bundle:nil];
//    [self presentViewController:ttController animated:YES completion:nil];
}

- (void)bannerView:(BannerView*)bannerView didSelectIndex:(NSInteger)index{
    NSLog(@"banner click");
}


@end
