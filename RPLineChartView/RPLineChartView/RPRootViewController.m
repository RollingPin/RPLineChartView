
//
//  RPRootViewController.m
//  RPLineChartView
//
//  Created by Tao on 2018/8/16.
//  Copyright © 2018年 Tao. All rights reserved.
//

#import "RPRootViewController.h"
#import "RPScrollView.h"
#import "UIView+Ext.h"

@interface RPRootViewController ()<RPScrollViewDelegate>

@end

@implementation RPRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    RPScrollView * lineScrollView = [[RPScrollView alloc]initWithFrame:CGRectMake(0, 100, self.view.width, 300)];
    lineScrollView.rpScrollDelegate = self;
    lineScrollView.dataArr =
    [NSArray arrayWithObjects:@"100",@"200",@"300",@"200",@"500",@"100",@"600",@"0",@"200",@"300",@"200",@"500",@"100",@"600",@"0"@"200",@"300",@"200",@"500",@"100",@"600",@"0", nil];
    [self.view addSubview:lineScrollView];
}

- (void)didSelectPoint_scrollIndex:(NSInteger)index withPointDataNum:(CGFloat )dataInfoNum
{
    NSLog(@"-======>>>%ld\n%f",(long)index,dataInfoNum);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
