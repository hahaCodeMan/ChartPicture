//
//  ViewController.m
//  ChartPicture
//
//  Created by 红点 on 2018/3/20.
//  Copyright © 2018年 Coder. All rights reserved.
//

#import "ViewController.h"
#import "SGDrawChart.h"

#define SCREENW    [UIScreen mainScreen].bounds.size.width
#define SCREENH   [UIScreen mainScreen].bounds.size.height

@interface ViewController ()
@property (nonatomic, strong) SGDrawChart *chartView;
@property(nonatomic, strong)NSArray *x_arr;//x轴标注数组
@property(nonatomic, strong)NSArray *y_arr;//y轴标注数组
@property(nonatomic, strong)NSArray *data_arr;//数据数组
@end
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.x_arr = @[@"北京", @"上海", @"广州", @"深圳", @"武汉", @"成都", @"南京"];
    self.y_arr = @[@"0", @"10", @"20", @"30", @"40", @"50", @"60",@"70", @"80", @"90", @"100"];
    self.data_arr = @[@"30", @"70", @"90", @"50", @"60", @"20",@"60"];
    self.chartView = [[SGDrawChart alloc] initWithFrame:CGRectMake(0, 50,SCREENW , SCREENW)];
    [self.view addSubview:self.chartView];
 
    //画柱状图
    [self.chartView drawBarGraphicWithX_ItemArray:self.x_arr WithY_itemArray:self.y_arr WithYDataArray:self.data_arr];
}


- (IBAction)handleClickAction:(id)sender {
    UIButton *button = (UIButton *)sender;
    NSInteger tag = button.tag;
    switch (tag) {
        case 200:{
            //画柱状图
            [self.chartView drawBarGraphicWithX_ItemArray:self.x_arr WithY_itemArray:self.y_arr WithYDataArray:self.data_arr];
        }
            break;
        case 201:{
            //折线图
            [self.chartView drawBrokenLineWithX_ItemArray:self.x_arr WithY_itemArray:self.y_arr WithYDataArray:self.data_arr];
        }
            break;
        case 202:{
            //饼状图
            [self.chartView drawPieChartWithX_ItemArray:self.x_arr WithY_itemArray:self.y_arr WithYDataArray:self.data_arr];
        }
            break;
        default:
            break;
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
