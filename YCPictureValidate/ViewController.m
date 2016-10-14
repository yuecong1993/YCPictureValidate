//
//  ViewController.m
//  图片验证码
//
//  Created by yishanmen on 16/9/30.
//  Copyright © 2016年 yishanmen. All rights reserved.
//

#import "ViewController.h"
#import "CaptchaView.h"

@interface ViewController () <UITextFieldDelegate,UIAlertViewDelegate>
{
    CaptchaView *_captchaView;
    UITextField *_input;
    
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _captchaView = [[CaptchaView alloc] initWithFrame:CGRectMake(20, 40, 150, 40)];
    [self.view addSubview:_captchaView];
    
    //提示文字
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(190, 40, 200, 40)];
    label.text = @"点击图片更换验证码";
    label.font = [UIFont boldSystemFontOfSize:14];
    label.textColor = [UIColor grayColor];
    [self.view addSubview:label];
    
    //添加输入框
    _input = [[UITextField alloc] initWithFrame:CGRectMake(20, 100, 150, 40)];
    _input.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _input.layer.borderWidth = 2.0;
    _input.layer.cornerRadius = 5.0;
    _input.font = [UIFont systemFontOfSize:19];
    _input.placeholder = @"请输入验证码";
    _input.clearButtonMode = UITextFieldViewModeWhileEditing;
    _input.backgroundColor = [UIColor clearColor];
    _input.textAlignment = NSTextAlignmentCenter;
    _input.returnKeyType = UIReturnKeyDone;
    _input.delegate = self;
    [self.view addSubview:_input];
    
}



#pragma mark 输入框协议中方法,点击return按钮
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    
    //判断输入的是否为验证图片显示的验证码 不区分大小写的验证
    int result1 = [_input.text compare:_captchaView.changeString options:NSCaseInsensitiveSearch];
    
    if (result1 == 0) {
        //正确弹出警告款提示正确
        
        UIAlertView *alview = [[UIAlertView alloc] initWithTitle:@"恭喜您 ^o^" message:@"验证成功" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alview show];
    }
    else
    {
        //验证不匹配，验证码和输入框晃动
        CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.x"];
        anim.repeatCount = 1;
        anim.values = @[@-20, @20, @-20];
        [_captchaView.layer addAnimation:anim forKey:nil];
        [_input.layer addAnimation:anim forKey:nil];
    }
    return YES;
}

#pragma mark 警告框中方法
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //清空输入框内容，收回键盘
    if (buttonIndex==0) {
        _input.text = @"";
        [_input resignFirstResponder];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
