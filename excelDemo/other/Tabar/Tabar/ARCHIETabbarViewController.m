//
//  ARCHIETabbarViewController.m
//  ARCHIE
//
//  Created by 黄明鹏 on 16/11/26.
//  Copyright © 2016年 ARCHIE. All rights reserved.
//
#import "UIImage+UIImage.h"
#import "ARCHIETabbarViewController.h"
#import "ARCHIENavViewController.h"
#import "firstViewController.h"
#import "secondViewController.h"


@interface ARCHIETabbarViewController ()

@end

@implementation ARCHIETabbarViewController

//只加载一次
+(void)load{
    
    NSMutableDictionary *AttsNor = [NSMutableDictionary dictionary];
    AttsNor[NSFontAttributeName] = [UIFont systemFontOfSize:15];
    UITabBarItem *itme = [UITabBarItem appearance];
    [itme setTitleTextAttributes:AttsNor forState:UIControlStateNormal];
    
    NSMutableDictionary *Atts = [NSMutableDictionary dictionary];
    Atts[NSForegroundColorAttributeName] = [UIColor blackColor];
    [itme setTitleTextAttributes:Atts forState:UIControlStateSelected];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self setUp];
    
    UIImageView *dotImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"personinfo_unread@2x.png"]];
    dotImage.backgroundColor = [UIColor clearColor];
    
    
    CGRect tabFrame = self.tabBar.frame;
    
    CGFloat x = ceilf(0.54 * tabFrame.size.width);
    
    CGFloat y = ceilf(0.2 * tabFrame.size.height);
    
    dotImage.frame = CGRectMake(x, y, 10, 10);
    
    
}

-(void)setUp{
    
    
    firstViewController *firstVC = [[firstViewController alloc]init];
    UIImage *newImage = [UIImage imageNamed:@"classification_1"];
    [self controllView:firstVC image:newImage selectImage:[UIImage imagewithName:@"classification_2"] title:@"1"];
       firstVC.tabBarItem.badgeValue = @"1";
    
    secondViewController *secondVC = [[secondViewController alloc]init];
    UIImage *alImage = [UIImage imageNamed:@"recommendation_1"];
    [self controllView:secondVC image:alImage selectImage:[UIImage imagewithName:@"recommendation_2"] title:@"2"];

}
-(void)controllView:(UIViewController*)vc image:(UIImage*)image selectImage:(UIImage*)selectImage title:(NSString*)tile{
    
    ARCHIENavViewController *naVC = [[ARCHIENavViewController alloc]initWithRootViewController:vc];
    naVC.tabBarItem.image = image;
    naVC.tabBarItem.selectedImage = selectImage;
    naVC.tabBarItem.title = tile;
    
    [self addChildViewController:naVC];
}


@end
