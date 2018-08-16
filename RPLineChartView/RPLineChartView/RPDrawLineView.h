//
//  RPDrawLineView.h
//  RPLineChartView
//
//  Created by Tao on 2018/8/16.
//  Copyright © 2018年 Tao. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RPDrawLineViewDelegate <NSObject>
/**
 *  点击线上的点_回调
 */
- (void)didSelectPointIndex:(NSInteger )index withPointDataNum:(CGFloat )dataInfoNum;

@end

@interface RPDrawLineView : UIView

/**
 *  数据源
 */
@property (nonatomic, strong) NSArray * dataArr;

/**
 *  线的颜色
 */
@property (nonatomic, strong) UIColor * lineColor;
/**
 *  线的宽度
 */
@property (nonatomic, assign) CGFloat lineW;
/**
 *  是否是曲线
 */
@property (nonatomic, assign) BOOL isCurve;
/**
 *  曲线圆弧度
 *  范围 0 - 1
 *  此参数只在 isCurve=YES 时有效
 */
@property (nonatomic, assign) CGFloat curveRatio;

/**
 *  代理回调
 */
@property (nonatomic, assign)id<RPDrawLineViewDelegate> delegate;

@end
