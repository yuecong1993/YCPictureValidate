//
//  CaptchaView.h
//  图片验证码
//
//  Created by yishanmen on 16/9/30.
//  Copyright © 2016年 yishanmen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CaptchaView : UIView

@property (nonatomic,strong) NSArray  *changeArray; //材料数组
@property (nonatomic,strong) NSMutableString  *changeString; //验证字符串

@end
