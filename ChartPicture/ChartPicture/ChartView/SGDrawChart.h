//
//  SGDrawChart.h
//  ChartPicture
//
//  Created by 红点 on 2018/3/20.
//  Copyright © 2018年 Coder. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SGDrawChart : UIView

/**
 画柱状图

 @param x_itemArray x轴标注
 @param y_itemArray y轴标注
 @param y_dataArray 数据
 */
- (void)drawBarGraphicWithX_ItemArray:(NSArray *)x_itemArray WithY_itemArray:(NSArray *)y_itemArray WithYDataArray:(NSArray *)y_dataArray;


/**
  画折线图

 @param x_itemArray x轴标注
 @param y_itemArray y轴标注
 @param y_dataArray 数据
 */
- (void)drawBrokenLineWithX_ItemArray:(NSArray *)x_itemArray WithY_itemArray:(NSArray *)y_itemArray WithYDataArray:(NSArray *)y_dataArray;

/**
 画饼状图
 
 @param x_itemArray x轴标注
 @param y_itemArray y轴标注
 @param y_dataArray 数据
 */
- (void)drawPieChartWithX_ItemArray:(NSArray *)x_itemArray WithY_itemArray:(NSArray *)y_itemArray WithYDataArray:(NSArray *)y_dataArray;


/**
 根据点画距 x轴 y轴的虚线
 @param point 点
 */
- (void)drawDottedLine:(CGPoint)point;

@end
