# RPLineChartView
一个简单的折线图View.支持直线和曲线,曲度可调

# ScreenShot
![image](https://github.com/RollingPin/RPLineChartView/blob/master/RPLineChartView/RPLineChartView/gif_RPLineChartView.gif)

# summary

折线部分属性可调,持续更新中...
```
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
```

通过此代理方法可获取标签点击事件
```
@protocol RPScrollViewDelegate <NSObject>

- (void)didSelectPoint_scrollIndex:(NSInteger )index withPointDataNum:(CGFloat )dataInfoNum;

@end
```

QQ: 1355582130@qq.com 欢迎指正
