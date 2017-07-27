//
//  ARCHIENavViewController.m
//  ARCHIE
//
//  Created by 黄明鹏 on 16/11/26.
//  Copyright © 2016年 ARCHIE. All rights reserved.
//

#import "ARCHIENavViewController.h"

@interface ARCHIENavViewController ()

@end

@implementation ARCHIENavViewController
+(void)load{
    UINavigationBar *bar = [UINavigationBar appearanceWhenContainedIn:self, nil];
    [bar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];
    
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    
    //设置字体大小
    NSMutableDictionary *Att = [NSMutableDictionary dictionary];
    Att[NSFontAttributeName] =[UIFont systemFontOfSize:18];
    [bar setTitleTextAttributes:Att];
     
}
     
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
         
         if (self.childViewControllers.count>0) {
             
             UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
             
             [backBtn setTitle:@"返回" forState:UIControlStateNormal];
             [backBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
             [backBtn setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
             [backBtn setImage:[UIImage imageNamed:@"navigationButtonReturn"] forState:UIControlStateNormal];
             [backBtn setImage:[UIImage imageNamed:@"navigationButtonReturnClick"] forState:UIControlStateHighlighted];
             [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
             [backBtn sizeToFit];
             UIView *contenView =[[UIView alloc]initWithFrame:backBtn.bounds];
             [contenView addSubview:backBtn];
             backBtn.contentEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 10);
             viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:contenView];
             
         }
         [super pushViewController:viewController animated:YES];
         
     }
-(void)back{
         
    [self  popViewControllerAnimated:YES];
    }
- (void)viewDidLoad {
    [super viewDidLoad];

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
