
//
//  RPScrollView.m
//  RPLineChartView
//
//  Created by Tao on 2018/8/16.
//  Copyright © 2018年 Tao. All rights reserved.
//

#import "RPScrollView.h"
#import "UIView+Ext.h"
#import "RPDrawLineView.h"

@interface RPScrollView ()<RPDrawLineViewDelegate>

@property (nonatomic, strong) RPDrawLineView * drawLineView;

@end

@implementation RPScrollView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = frame;
//        self.backgroundColor = [UIColor whiteColor];
        
    }
    return self;
}
- (void)setLineView
{
    self.drawLineView = [[RPDrawLineView alloc]initWithFrame:CGRectMake(0, 0, self.width/2+80*self.dataArr.count, self.height)];
    self.drawLineView.backgroundColor = [UIColor orangeColor];
    self.drawLineView.isCurve = YES;
    self.drawLineView.lineColor = [UIColor blueColor];
    self.drawLineView.lineW = 6;
    self.drawLineView.curveRatio = 0.2;
    self.drawLineView.dataArr = self.dataArr;
    self.drawLineView.delegate = self;
    [self addSubview:self.drawLineView];
}
- (void)didSelectPointIndex:(NSInteger)index withPointDataNum:(CGFloat)dataInfoNum
{
    [UIView animateWithDuration:0.3f animations:^{
        self.contentOffset = CGPointMake(80*index, 0);
    }];
    
    if ([self.rpScrollDelegate respondsToSelector:@selector(didSelectPoint_scrollIndex:withPointDataNum:)]) {
        [self.rpScrollDelegate didSelectPoint_scrollIndex:index withPointDataNum:dataInfoNum];
    }
}

- (void)setDataArr:(NSArray *)dataArr
{
    if (_dataArr != dataArr) {
        _dataArr = dataArr;
        self.contentSize = CGSizeMake(self.width/2+80*(dataArr.count-1)+30, 0);
        [self setLineView];
    }
}


@end
