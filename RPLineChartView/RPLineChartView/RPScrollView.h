//
//  RPScrollView.h
//  RPLineChartView
//
//  Created by Tao on 2018/8/16.
//  Copyright © 2018年 Tao. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RPScrollViewDelegate <NSObject>
/**
 *  点击线上的点_回调
 */
- (void)didSelectPoint_scrollIndex:(NSInteger )index withPointDataNum:(CGFloat )dataInfoNum;

@end

@interface RPScrollView : UIScrollView

/**
 *  数据源
 */
@property (nonatomic, strong) NSArray * dataArr;

/**
 *  代理回调
 */
@property (nonatomic, assign)id<RPScrollViewDelegate> rpScrollDelegate;


@end
