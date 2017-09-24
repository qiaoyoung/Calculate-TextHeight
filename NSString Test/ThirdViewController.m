//
//  ThirdViewController.m
//  NSString Test
//
//  Created by AC-1502001 on 16/10/26.
//  Copyright © 2016年 AC. All rights reserved.
//
/**
 
 
 
 ************************************    方法三    ***********************************
 
 
 
 */
#import "ThirdViewController.h"

@interface ThirdViewController ()

@end

@implementation ThirdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    //1.创建label
    UILabel *contentLab = [[UILabel alloc]initWithFrame:CGRectMake(20, 64,300, 100)];
    contentLab.font = [UIFont systemFontOfSize:15];
    contentLab.backgroundColor = [UIColor greenColor];
    contentLab.numberOfLines = 0;
    contentLab.text = @"写信告诉我 今天海是什么颜色;爷爷陪着你的海 心情又如何";
    [self.view addSubview:contentLab];
      
    /**
     封装的方法
     2. 判断当前对象的内容 是否 需要多行显示
    
     当文本中有'汉字' 且 '一行' 就可以显示完的时候,此时设置行间距就会导致计算不准确,出现错位情况,必须加上判断条件.
     */
    if ([self isNeedMultiLineWithStr:contentLab.text
                              Height:100
                               Width:300
                                Font:15]) {
    
        NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
        
        //只有多行显示才设置行间距 否则会错位
        paraStyle.lineSpacing = 5;
        NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc]initWithString:contentLab.text
                                                                                           attributes:@{NSParagraphStyleAttributeName:paraStyle,NSFontAttributeName:[UIFont systemFontOfSize:15]}];
        contentLab.attributedText = attributeString;
        
    }
    
    //3.计算Size (只此一步,短小精悍)
    CGSize size = [contentLab sizeThatFits:CGSizeMake(contentLab.frame.size.width, CGFLOAT_MAX)];

    contentLab.frame = CGRectMake(0,64, 300, size.height);
    
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
                       Height:(CGFloat)height
                        Width:(CGFloat)width
                         Font:(CGFloat)font
{
    
    CGFloat myWidth = [str boundingRectWithSize:CGSizeMake(MAXFLOAT,height)
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


@end
