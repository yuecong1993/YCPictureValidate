//
//  CaptchaView.m
//  图片验证码
//
//  Created by yishanmen on 16/9/30.
//  Copyright © 2016年 yishanmen. All rights reserved.
//

#import "CaptchaView.h"

#define kRandomColor  [UIColor colorWithRed:arc4random() % 256 / 256.0 green:arc4random() % 256 / 256.0 blue:arc4random() % 256 / 256.0 alpha:1.0];
#define kLineCount 6
#define kLineWidth 1.0
#define kCharCount 6
#define kFontSize [UIFont systemFontOfSize:arc4random() % 5 + 15]

@implementation CaptchaView

-(instancetype)initWithFrame:(CGRect)frame{
   
    if (self = [super initWithFrame:frame]) {
        self.layer.cornerRadius = 5.0;
        self.layer.masksToBounds = YES;
        self.backgroundColor = kRandomColor;
        
        //显示一个随机验证码
        [self changeCaptcha];
    }
    
    return self;
}

#pragma mark 点击更换验证码
- (void)changeCaptcha{
    
    //<一>从字符数组中随机抽取相应数量的字符，组成验证码字符串
    self.changeArray = [[NSArray alloc] initWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z",@"a",@"b",@"c",@"d",@"e",@"f",@"g",@"h",@"i",@"j",@"k",@"l",@"m",@"n",@"o",@"p",@"q",@"r",@"s",@"t",@"u",@"v",@"w",@"x",@"y",@"z",nil];
    
        //如果能确定最大需要的容量，使用initWithCapacity:来设置，好处是当元素个数不超过容量时，添加元素不需要重新分配内存
    NSMutableString *getStr = [[NSMutableString alloc] initWithCapacity:kCharCount];
    self.changeString = [[NSMutableString alloc] initWithCapacity:kCharCount];

    //随机从数组中选取需要个数的字符，然后拼接为一个字符串
    for (int i = 0; i<kCharCount; i++) {
        NSInteger index = arc4random() %([self.changeArray count] - 1);
        getStr = [self.changeArray objectAtIndex:index];
        
        self.changeString = (NSMutableString *)[self.changeString stringByAppendingString:getStr];
    }
}

#pragma mark 点击view时调用，因为当前类自身就是UIView，点击更换验证码可以直接写到这个方法中，不用再额外添加手势
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    [self changeCaptcha];
    
    //setNeedsDisplay调用drawRect方法来实现view的绘制
    [self setNeedsDisplay];

}

#pragma mark 绘制界面（1.UIView初始化后自动调用； 2.调用setNeedsDisplay方法时会自动调用）
- (void)drawRect:(CGRect)rect{
   
    //重写父类方法,首先调用父类的方法
    [super drawRect:rect];
    
    self.backgroundColor = kRandomColor;
    
    //获得要显示验证码字符串，根据长度，计算每个字符显示的大概位置
    NSString *text = [NSString stringWithFormat:@"%@",self.changeString];
    CGSize cSize = [@"S" sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20]}]; int width = rect.size.width / text.length - cSize.width;
    int height = rect.size.height - cSize.height;
    CGPoint point;
    
    //依次绘制每一个字符,可以设置显示的每个字符的字体大小、颜色、样式等
    float pX, pY;
    for (int i = 0; i < text.length; i++)
    {
        pX = arc4random() % width + rect.size.width / text.length * i;
        pY = arc4random() % height;
        point = CGPointMake(pX, pY);
        unichar c = [text characterAtIndex:i];
        NSString *textC = [NSString stringWithFormat:@"%C", c];
        
        [textC drawAtPoint:point withAttributes:@{NSFontAttributeName:kFontSize}];
    }

    //调用drawRect：之前，系统会向栈中压入一个CGContextRef，调用UIGraphicsGetCurrentContext()会取栈顶的CGContextRef
    CGContextRef context = UIGraphicsGetCurrentContext();
    //设置画线宽度
    CGContextSetLineWidth(context, kLineWidth);
    
    //绘制干扰的彩色直线
    for(int i = 0; i < kLineCount; i++)
    {
        //设置线的随机颜色
        UIColor *color = kRandomColor;
        CGContextSetStrokeColorWithColor(context, [color CGColor]);
        //设置线的起点
        pX = arc4random() % (int)rect.size.width;
        pY = arc4random() % (int)rect.size.height;
        CGContextMoveToPoint(context, pX, pY);
        //设置线终点
        pX = arc4random() % (int)rect.size.width;
        pY = arc4random() % (int)rect.size.height;
        CGContextAddLineToPoint(context, pX, pY);
        //画线
        CGContextStrokePath(context);
    }
}

@end
