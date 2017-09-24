//
//  ViewController.m
//  NSString Test
//
//  Created by AC-1502001 on 16/10/25.
//  Copyright © 2016年 AC. All rights reserved.
//
/**
 
 
 
 ************************************    方法一    ***********************************
 
 
 
 */
#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];


    //1.创建label
    UILabel *contentLab = [[UILabel alloc]initWithFrame:CGRectMake(20, 64,300, 100)];
    contentLab.font = [UIFont systemFontOfSize:15];
    contentLab.backgroundColor = [UIColor greenColor];
    contentLab.numberOfLines = 0;
    contentLab.text = @"写信告诉我 今天海是什么颜色;夜夜陪着你的海 心情又如何";
    [self.view addSubview:contentLab];
 
 
    /**
     封装的方法
    2. 判断当前对象的内容 是否 需要多行显示*/
    CGFloat lineSpacing = 0;
    if ([self isNeedMultiLineWithStr:contentLab.text withHeight:100 withWidth:300 withFont:15]) {

        NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];

        //只有多行显示才设置行间距 否则会错位
        paraStyle.lineSpacing = 5;
        NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc]initWithString:contentLab.text
                                                                                           attributes:@{NSParagraphStyleAttributeName:paraStyle,NSFontAttributeName:[UIFont systemFontOfSize:15]}];
        contentLab.attributedText = attributeString;
        
        lineSpacing = paraStyle.lineSpacing;
    }
 
    //3.获取高度 重置坐标
    CGFloat Height = [self getTextHeightWithStr:contentLab.text
                                      withWidth:300
                                withLineSpacing:lineSpacing
                                       withFont:15];

    contentLab.frame = CGRectMake(0,64, 300, Height);
    
   
    
}
#pragma mark - ---------------------------------------------------------------
/**
 判断是否超过一行

 @param str    文本内容
 @param height 文本高度
 @param width  文本宽度
 @param font   文本描述

 @return 返回判断结果
 */
-(BOOL)isNeedMultiLineWithStr:(NSString *)str
                   withHeight:(CGFloat)height
                    withWidth:(CGFloat)width
                     withFont:(CGFloat)font
{
    
    CGFloat myWidth = [str boundingRectWithSize:CGSizeMake(MAXFLOAT,400)
                                               options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin
                                            attributes:@{NSFontAttributeName :[UIFont systemFontOfSize:font]}
                                               context:nil].size.width;
    
    
    if (myWidth <= width) {
        return NO;
    }
    else{
        return YES;
    }
}
#pragma mark - ---------------------------------------------------------------
/**
 计算文本高度

 @param str         富文本内容
 @param width       lab宽度
 @param lineSpacing 行间距(没有行间距就传0)
 @param font        文本字体大小
 
 @return 文本高度
 */
-(CGFloat)getTextHeightWithStr:(NSString *)str
                  withWidth:(CGFloat)width
            withLineSpacing:(CGFloat)lineSpacing
                   withFont:(CGFloat)font
{
    if (!str || str.length == 0) {
        return 0;
    }
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc]init];
    paraStyle.lineSpacing = lineSpacing;
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc]initWithString:str
                                                                                       attributes:@{NSParagraphStyleAttributeName:paraStyle,NSFontAttributeName:[UIFont systemFontOfSize:font]}];

    
    CGRect rect = [attributeString boundingRectWithSize:CGSizeMake(width, MAXFLOAT)
                                                   options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                                   context:nil];
 
    return rect.size.height;
}


@end
