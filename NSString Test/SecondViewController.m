//
//  SecondViewController.m
//  NSString Test
//
//  Created by AC-1502001 on 16/10/25.
//  Copyright © 2016年 AC. All rights reserved.
//
/**
 
 
              
     ************************************    方法二    ***********************************
 
 
 
 */
#import "SecondViewController.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    
    //1.创建label
    UILabel *contentLab = [[UILabel alloc]initWithFrame:CGRectMake(20, 64,300, 20)];
    contentLab.font = [UIFont systemFontOfSize:15];
    contentLab.backgroundColor = [UIColor greenColor];
    contentLab.numberOfLines = 0;
    contentLab.text = @"单行就可以显示";
    [self.view addSubview:contentLab];
    

    //2.获取高度 重置坐标
    CGFloat Height = [self getTextHeightWithStr:contentLab.text
                                      withWidth:300
                                withLineSpacing:10//(预设的行间距)
                                       withFont:15];
    

    contentLab.frame = CGRectMake(20,64, 300, Height);
    
    
    
    //3.如果包含汉字的文本一行就可以显示完,就不需要设置富文本,否则会出现文本错位的问题.
    
    //但是什么时候一行显示 还需要自己判断,而且估算的不是十分准确  比较麻烦
    
    //我在此处的处理方法是把 计算出来的Height 和 2倍的font高度做比较,如果是多行显示,文本高度加上行间距肯定大于2倍的font,满足条件,就是 多行,设置行间距.
 
    if (Height > 2*contentLab.font.lineHeight){//多行显示
        
        NSMutableParagraphStyle *paraStyle  = [[NSMutableParagraphStyle alloc] init];
        paraStyle.lineSpacing = 10;
        NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc]initWithString:contentLab.text
                                                                                              attributes:@{NSParagraphStyleAttributeName:paraStyle,NSFontAttributeName:[UIFont systemFontOfSize:15]}];
        contentLab.attributedText = attributeString;
    }
 
    /**
     出现问题的条件:
     条件一:当前文本内容'一行'就可以显示完全
     条件二:文本当中包含'汉字'
     结果:计算出来的高度即使只有一行,也会包'含行间距'
     
     解决办法:
     在封装方法中:
     条件一: '文本高度' - '字体高度',如果只有一行,'差'肯定 <= 行间距
     条件二: 文本中有汉字
     */
    
}
#pragma mark - ---------------------------------------------------------------
/**
 计算文本高度
 
 @param str         文本内容
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

    if ((rect.size.height - [UIFont systemFontOfSize:font].lineHeight)  <= lineSpacing){
        if ([self containChinese:str]){
            rect.size.height -= lineSpacing;
        }
    }
    return rect.size.height;
}
//判断是否包含中文
- (BOOL)containChinese:(NSString *)str {
    for(int i=0; i< [str length];i++){
        int a = [str characterAtIndex:i];
        if( a > 0x4e00 && a < 0x9fff){
            return YES;
        }
    }
    return NO;
}



@end
