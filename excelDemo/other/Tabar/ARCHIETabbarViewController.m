//
//  ARCHIETabbarViewController.m
//  ARCHIE
//
//  Created by 黄明鹏 on 16/11/26.
//  Copyright © 2016年 ARCHIE. All rights reserved.
//

#import "ARCHIETabbarViewController.h"
#import "ARCHIENavViewController.h"
//#import "ARCHIEMineViewController.h"
#import "DemoMeController.h"
#import "RootViewController.h"
#import "ARCHIERmViewController.h"
#import "ARCHIEAdressListViewController.h"

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
    
//    [self.tabBar addSubview:dotImage];
    
}

-(void)setUp{
    //工作台
    RootViewController *wsVC = [[RootViewController alloc]init];
    wsVC.tabBarItem.enabled = NO;
    [self addChildViewController:wsVC];
    UIImage *ecImage = [UIImage imageNamed:@"recommendation_1"];
    //    self.tabBarItem.badgeValue = @"5";
    [self controllView:wsVC image:ecImage selectImage:[UIImage imagewithName:@"recommendation_2"] title:@"工作台"];
    
    //提醒
    ARCHIERmViewController *rmVC = [[ARCHIERmViewController alloc]init];
    UIImage *newImage = [UIImage imageNamed:@"classification_1"];
    [self controllView:rmVC image:newImage selectImage:[UIImage imagewithName:@"classification_2"] title:@"提醒"];
       rmVC.tabBarItem.badgeValue = @"1";
    //通讯录
    ARCHIEAdressListViewController *alVC = [[ARCHIEAdressListViewController alloc]init];
    UIImage *alImage = [UIImage imageNamed:@"adress_list_unselect"];
    [self controllView:alVC image:alImage selectImage:[UIImage imagewithName:@"adress_list_select"] title:@"通讯录"];
    
    // 我
    DemoMeController *mineVC = [[DemoMeController alloc]init];
    UIImage *ftImage = [UIImage imageNamed:@"my_1"];
    [self controllView:mineVC image:ftImage selectImage:[UIImage imagewithName:@"my_2"] title:@"我"];
    
    
}
-(void)controllView:(UIViewController*)vc image:(UIImage*)image selectImage:(UIImage*)selectImage title:(NSString*)tile{
    
    ARCHIENavViewController *naVC = [[ARCHIENavViewController alloc]initWithRootViewController:vc];
    naVC.tabBarItem.image = image;
    naVC.tabBarItem.selectedImage = selectImage;
    naVC.tabBarItem.title = tile;
    
    [self addChildViewController:naVC];
}


@end
