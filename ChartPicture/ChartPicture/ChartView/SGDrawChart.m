//
//  SGDrawChart.m
//  ChartPicture
//
//  Created by 红点 on 2018/3/20.
//  Copyright © 2018年 Coder. All rights reserved.
//

#import "SGDrawChart.h"
//间距
#define margin 30
// 颜色RGB
#define SGColor(r, g, b)  [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define SGColorRGBA(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]
// 随机色
#define SGRandomColor  SGColor(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))

@interface SGDrawChart()
//view的宽度
@property (nonatomic, assign) CGFloat viewW;
//view的高度
@property (nonatomic, assign) CGFloat viewH;
@end

@implementation SGDrawChart
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.viewW = frame.size.width;
        self.viewH = frame.size.height;
    }
    return self;
}


//画坐标轴
- (void)drawCoordinateWithXArray:(NSArray *)x_itemArray WithYArray:(NSArray *)y_itemArray{
    CAShapeLayer *layer = [CAShapeLayer layer];
    UIBezierPath *path = [UIBezierPath bezierPath];
    //坐标轴原点
    CGPoint rPoint = CGPointMake(1.3*margin, self.viewH-margin);
    //画y轴
    [path moveToPoint:rPoint];
    [path addLineToPoint:CGPointMake(1.3*margin, margin)];
    //画y轴的箭头
    [path moveToPoint:CGPointMake(1.3*margin, margin)];
    [path addLineToPoint:CGPointMake(1.3*margin - 5, margin + 5)];
    [path moveToPoint:CGPointMake(1.3*margin, margin)];
    [path addLineToPoint:CGPointMake(1.3*margin+5, margin+5)];
    //画x轴
    [path moveToPoint:rPoint];
    [path addLineToPoint:CGPointMake(self.viewW - 0.8*margin, self.viewH-margin)];
    //画x轴的箭头
    [path moveToPoint:CGPointMake(self.viewW-0.8*margin, self.viewH-margin)];
    [path addLineToPoint:CGPointMake(self.viewW-0.8*margin-5, self.viewH-margin - 5)];
    [path moveToPoint:CGPointMake(self.viewW-0.8*margin, self.viewH-margin)];
    [path addLineToPoint:CGPointMake(self.viewW-0.8*margin-5, self.viewH-margin + 5)];
    
    //画x轴的标度
    for (int i = 0; i < x_itemArray.count; i++) {
        [path moveToPoint:CGPointMake(1.3*margin+(self.viewW - 2*margin)/(x_itemArray.count+1)*(i+1), self.viewH-margin)];
        [path addLineToPoint:CGPointMake(1.3*margin+(self.viewW - 2*margin)/(x_itemArray.count+1)*(i+1), self.viewH-margin-3)];
    }
    
    //画y轴上的标度
    for (int i=0; i<y_itemArray.count; i++) {
        [path moveToPoint:CGPointMake(1.3*margin, margin+(self.viewH-2*margin)/(y_itemArray.count + 1)*(i+1))];
        [path addLineToPoint:CGPointMake(1.3*margin+3, margin+(self.viewH-2*margin)/(y_itemArray.count + 1)*(i+1))];
    }
    
    layer.path = path.CGPath;
    layer.strokeColor = [UIColor blackColor].CGColor;
    layer.lineWidth = 2.0;
    [self.layer addSublayer:layer];
    
    //为x轴添加标注
    for (int i = 0; i < x_itemArray.count; i++) {
        CGFloat xLWidth = ((self.viewW-2*margin)/(x_itemArray.count+1)) <= 25 ? ((self.viewW-2*margin)/(x_itemArray.count+1)) : 25;
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(1.3*margin+(self.viewW-2*margin)/(x_itemArray.count+1)*(i+1)-xLWidth/2, self.viewH-margin, xLWidth, 20)];
        lab.text = x_itemArray[i];
        lab.textColor = [UIColor blackColor];
        lab.adjustsFontSizeToFitWidth = YES;
        lab.textAlignment = NSTextAlignmentCenter;
        [self addSubview:lab];
    }
    //给y轴添加标注label
    for (int i = 0; i < y_itemArray.count; i++) {
        CGFloat yLHeight = (self.viewH-2*margin)/11 <= 20 ? (self.viewH-2*margin)/11 : 20;
        CGFloat yLWidth = yLHeight*2 >= 25 ? 25 : yLHeight*2;
        CGFloat size = (self.viewH-2*margin)/11 <= 20 ? 7 : 12;
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(1.3*margin-yLWidth-5, margin+(self.viewH-2*margin)/(y_itemArray.count+1)*(y_itemArray.count-i+0.5), yLWidth, yLHeight)];
        lab.text = [NSString stringWithFormat:@"%d", 10*i];
        lab.textColor = [UIColor blackColor];
        lab.font = [UIFont boldSystemFontOfSize:size];
        lab.textAlignment = NSTextAlignmentCenter;
        [self addSubview:lab];
    }
}

//画柱状图
- (void)drawBarGraphicWithX_ItemArray:(NSArray *)x_itemArray WithY_itemArray:(NSArray *)y_itemArray WithYDataArray:(NSArray *)y_dataArray{
    //将子视图先清理
    [self initDrawView];
    //画坐标轴
    [self drawCoordinateWithXArray:x_itemArray WithYArray:y_itemArray];
    //画柱状图
    for (int i = 0; i < y_dataArray.count; i++) {
        //获取y轴的基本单位（仅适用于数字）
        CGFloat space = [y_itemArray[1] floatValue]- [y_itemArray[0] floatValue];
        int num = [y_dataArray[i] floatValue]/space;
        UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(1.3*margin+(self.viewW - 2*margin)/(x_itemArray.count+1)*(i+1), self.viewH-margin-(self.viewH-2*margin)/(y_itemArray.count + 1) *num, 0.8*((self.viewW-2*margin)/(x_itemArray.count+1)), (self.viewH-2*margin)/(y_itemArray.count + 1)*num)];
        CAShapeLayer *layer = [CAShapeLayer layer];
        layer.path = path.CGPath;
        //填充随机颜色
        layer.fillColor = SGRandomColor.CGColor;
        [self.layer addSublayer:layer];
    }
   
}


//画折线图
- (void)drawBrokenLineWithX_ItemArray:(NSArray *)x_itemArray WithY_itemArray:(NSArray *)y_itemArray WithYDataArray:(NSArray *)y_dataArray {
    //清除绘制view
    [self initDrawView];
    //绘制坐标轴
    [self drawCoordinateWithXArray:x_itemArray WithYArray:y_itemArray];
    //起点坐标
    CGPoint startPoint =  CGPointMake(1.3*margin+(self.viewW-2*margin)/(x_itemArray.count+1), self.viewH-margin-(self.viewH-2*margin)/11*[y_dataArray[0] floatValue]/10);
    CGPoint endPoint;
    for (int i = 0; i < y_dataArray.count; i++) {
        endPoint = CGPointMake(1.3*margin+(self.viewW-2*margin)/(x_itemArray.count+1)*(i+1), self.viewH-margin-(self.viewH-2*margin)/11*[y_dataArray[i] floatValue]/10);
        //根据两点画线
        UIBezierPath *path = [UIBezierPath bezierPath];
        [path moveToPoint:startPoint];
        //这句话可以画弧度
      //  [path addArcWithCenter:endPoint radius:1.5 startAngle:0 endAngle:2*M_PI clockwise:YES];
        [path addLineToPoint:endPoint];
        CAShapeLayer *layer = [CAShapeLayer layer];
        layer.path = path.CGPath;
        layer.strokeColor = [UIColor redColor].CGColor;
        layer.lineWidth = 1.0;
        [self.layer addSublayer:layer];
        //画虚线
        [self drawDottedLine:startPoint];
        startPoint = endPoint;
    }
}


//绘制饼状图
- (void)drawPieChartWithX_ItemArray:(NSArray *)x_itemArray WithY_itemArray:(NSArray *)y_itemArray WithYDataArray:(NSArray *)y_dataArray {
    [self initDrawView];
    //设置圆的中点
    CGPoint yPoint = CGPointMake(self.viewW/2.0, self.viewH/2.0);
    CGFloat startAngle = 0;
    CGFloat endAngle;
    //设置半径
    float r = self.viewH /3;
    //求和
    CGFloat sum = 0;
    for (int i = 0; i < y_dataArray.count; i++) {
        CGFloat data = [y_dataArray[i] floatValue];
        sum += data;
    }
    
    //求每一份的占比
    for (int i = 0; i < y_dataArray.count; i++) {
        CGFloat data = [y_dataArray[i] floatValue];
        float percent = data/sum;
        //结束的弧度
        endAngle = startAngle+percent * 2*M_PI;
        //绘制
        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        //clockwise YES顺时针
        UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:yPoint radius:r startAngle:startAngle endAngle:endAngle clockwise:YES];
        [path addLineToPoint:yPoint];
        [path closePath];
        //绘制文字 label
        CGFloat bLWidth = self.viewW/6>= 40?40:self.viewH/6;
        CGFloat fontSize = self.viewH/6>= 40? 9: 5;
        CGFloat lab_x = yPoint.x + (r + bLWidth/2) * cos((startAngle + (endAngle - startAngle)/2)) - bLWidth/2;
        CGFloat lab_y = yPoint.y + (r + bLWidth*3/8) * sin((startAngle + (endAngle - startAngle)/2)) - bLWidth*3/8;
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(lab_x, lab_y, bLWidth, bLWidth*3/4)];
        lab.text = [NSString stringWithFormat:@"%@\n%.2f%@",x_itemArray[i],percent*100,@"%"];
        lab.textColor = [UIColor blackColor];
        lab.numberOfLines = 0;
        lab.font = [UIFont boldSystemFontOfSize:fontSize];
        lab.textAlignment = NSTextAlignmentCenter;
        [self addSubview:lab];
        shapeLayer.path = path.CGPath;
        shapeLayer.fillColor = SGRandomColor.CGColor;
        [self.layer addSublayer:shapeLayer];
        startAngle = endAngle;
    }
    
}


//画虚线
- (void)drawDottedLine:(CGPoint)point {
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    [shapeLayer setStrokeColor:[UIColor blackColor].CGColor];
    [shapeLayer setLineWidth:1.0];
    [shapeLayer setLineJoin:kCALineJoinRound];
    //设置虚线的线宽和间距
    [shapeLayer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:2], [NSNumber numberWithInt:3], nil]];
    //创建虚线绘制路径
    CGMutablePathRef path = CGPathCreateMutable();
    
    //设置y轴方向的虚线
    CGPathMoveToPoint(path, NULL, point.x, point.y);
    CGPathAddLineToPoint(path, NULL, point.x, self.viewH-margin);
    
    //设置x轴的虚线
    CGPathMoveToPoint(path, NULL, point.x, point.y);
    CGPathAddLineToPoint(path, NULL, 1.3*margin, point.y);
    
    //设置虚线绘制路径
    [shapeLayer setPath:path];
    CGPathRelease(path);
    [self.layer addSublayer:shapeLayer];
}



- (void)initDrawView{
    [self.layer.sublayers makeObjectsPerformSelector:@selector(removeFromSuperlayer)];
}

@end
