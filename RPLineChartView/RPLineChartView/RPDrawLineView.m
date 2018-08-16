

//
//  RPDrawLineView.m
//  RPLineChartView
//
//  Created by Tao on 2018/8/16.
//  Copyright © 2018年 Tao. All rights reserved.
//

#import "RPDrawLineView.h"
#import "UIView+Ext.h"

#define DefaultLineColor [UIColor blackColor]
#define DefaultLineW 3
#define DefaultIsCurve NO
#define DefaultCurveRatio 0.5

@interface RPDrawLineView ()

@property (nonatomic, strong) UILabel * pointLabel;

@end

@implementation RPDrawLineView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = frame;
//        self.backgroundColor = [UIColor orangeColor];
        
        //默认
        _lineColor = DefaultLineColor;
        _lineW = DefaultLineW;
        _isCurve = DefaultIsCurve;
        _curveRatio = DefaultCurveRatio;
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    CGFloat maxValue = [[self.dataArr valueForKeyPath:@"@max.floatValue"] floatValue];
    CGFloat minValue = [[self.dataArr valueForKeyPath:@"@min.floatValue"] floatValue];
    CGFloat numAll = fabs(maxValue)+fabs(minValue);
    CGFloat numAll_half = numAll/2;
    CGFloat line_frameH = self.height-50;
    CGFloat ratio = line_frameH/numAll;
    
    //使用贝瑟尔曲线实现
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    [path setLineWidth:self.lineW];
    [path setLineJoinStyle:kCGLineJoinRound];
    [path setLineCapStyle:kCGLineCapRound];
    
    UIColor *color = self.lineColor;
    [color set];
    
    [self addSubview:self.pointLabel];
    
    for (int i = 0; i<self.dataArr.count; i++) {
        if (i+1==self.dataArr.count) { return; }
        
        CGFloat theNum = [self.dataArr[i] floatValue];
        CGFloat nextNum = [self.dataArr[i+1] floatValue];
        
        CGFloat beginPointY = self.height/2+(numAll_half*ratio-theNum*ratio);
        CGFloat endPointY = self.height/2+(numAll_half*ratio-nextNum*ratio);
        
        if (minValue < 0) {
            CGFloat chNum_theNum = theNum+fabs(minValue);
            CGFloat chNum_nextNum = nextNum+fabs(minValue);
            
            beginPointY = self.height/2+(numAll_half*ratio-chNum_theNum*ratio);
            endPointY = self.height/2+(numAll_half*ratio-chNum_nextNum*ratio);
        }
        
        if (self.isCurve) {
            
            if (self.curveRatio>1) { self.curveRatio = 1;}
            if (self.curveRatio<0) { self.curveRatio = 0;}
            [path moveToPoint:CGPointMake(self.superview.width/2+80*i, beginPointY)];
            [path addCurveToPoint:CGPointMake(self.superview.width/2+80*(i+1), endPointY) controlPoint1:CGPointMake(self.superview.width/2+80*i+80*self.curveRatio, beginPointY) controlPoint2:CGPointMake(self.superview.width/2+80*(i+1)-80*self.curveRatio, endPointY)];
            [path stroke];
        }else{
            
            
            [path moveToPoint:CGPointMake(self.superview.width/2+80*i, beginPointY)];
            [path addLineToPoint:CGPointMake(self.superview.width/2+80*(i+1), endPointY)];
            [path stroke];
        }
        
        UIButton * pointBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        pointBtn.frame =CGRectMake(0, 0, 16, 16);
        pointBtn.tag = 1000+i;
        pointBtn.layer.cornerRadius = pointBtn.width/2;
        pointBtn.layer.masksToBounds = YES;
        pointBtn.center = CGPointMake(self.superview.width/2+80*i, beginPointY);
        [pointBtn setBackgroundColor:[UIColor redColor]];
        [pointBtn setTitle:@"中" forState:UIControlStateSelected];
        pointBtn.titleLabel.font = [UIFont systemFontOfSize:10];
        [pointBtn addTarget:self action:@selector(pointBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:pointBtn];
        if (i == 0) {
            pointBtn.selected = YES;
            if (pointBtn.Y<= self.height/2) {
                self.pointLabel.center = CGPointMake(pointBtn.centerX, pointBtn.Y-10);
            }else{
                self.pointLabel.center = CGPointMake(pointBtn.centerX, pointBtn.bottomY+10);
            }
            self.pointLabel.text = [NSString stringWithFormat:@"%0.2f",theNum];
        }
        if (i == self.dataArr.count-2) {
            UIButton * pointBtn_sub = [UIButton buttonWithType:UIButtonTypeCustom];
            pointBtn_sub.frame =CGRectMake(0, 0, 16, 16);
            pointBtn_sub.tag = 1000+self.dataArr.count-1;
            pointBtn_sub.center = CGPointMake(self.superview.width/2+80*(i+1), endPointY);
            pointBtn_sub.layer.cornerRadius = pointBtn.width/2;
            pointBtn_sub.layer.masksToBounds = YES;
            [pointBtn_sub setBackgroundColor:[UIColor redColor]];
            [pointBtn_sub setTitle:@"中" forState:UIControlStateSelected];
            pointBtn_sub.titleLabel.font = [UIFont systemFontOfSize:10];
            [pointBtn_sub addTarget:self action:@selector(pointBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:pointBtn_sub];
        }
    }
    
}

- (void)pointBtnClick:(UIButton *)btn
{
    if ([self.delegate respondsToSelector:@selector(didSelectPointIndex:withPointDataNum:)]) {
        [self.delegate didSelectPointIndex:btn.tag-1000 withPointDataNum:[self.dataArr[btn.tag-1000] floatValue]];
    }
    
    if (btn.selected == YES) {
        return;
    }
    
    CGFloat theNum = [self.dataArr[btn.tag-1000] floatValue];
    if (btn.Y<= self.height/2) {
        self.pointLabel.center = CGPointMake(btn.centerX, btn.Y-10);
    }else{
        self.pointLabel.center = CGPointMake(btn.centerX, btn.bottomY+10);
    }
    self.pointLabel.text = [NSString stringWithFormat:@"%0.2f",theNum];
    
    for (int i = 0; i<self.dataArr.count; i++) {
        UIButton * a_btn = [self viewWithTag:1000+i];
        a_btn.selected = NO;
    }
    btn.selected = YES;
}

- (UILabel *)pointLabel
{
    if (_pointLabel == nil) {
        _pointLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 35, 16)];
        _pointLabel.font = [UIFont systemFontOfSize:10];
        _pointLabel.textColor = [UIColor whiteColor];
        _pointLabel.backgroundColor = [UIColor grayColor];
        _pointLabel.textAlignment = NSTextAlignmentCenter;
        
    }
    return _pointLabel;
}

- (void)setDataArr:(NSArray *)dataArr
{
    if (_dataArr != dataArr) {
        _dataArr = dataArr;
    }
}
- (void)setLineColor:(UIColor *)lineColor
{
    if (_lineColor != lineColor) {
        _lineColor = lineColor;
    }
}
- (void)setLineW:(CGFloat)lineW
{
    if (_lineW != lineW) {
        _lineW = lineW;
    }
}
- (void)setIsCurve:(BOOL)isCurve
{
    if (_isCurve != isCurve) {
        _isCurve = isCurve;
    }
}
- (void)setCurveRatio:(CGFloat )curveRatio
{
    if (_curveRatio != curveRatio) {
        _curveRatio = curveRatio;
    }
}
@end
