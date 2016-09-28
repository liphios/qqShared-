//
//  ViewController.m
//  分享测试
//
//  Created by 李鹏辉 on 16/9/28.
//  Copyright © 2016年 company. All rights reserved.
//

#import "ViewController.h"
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>
@interface ViewController ()<TencentSessionDelegate>
@property (nonatomic, strong) TencentOAuth *tencentOAuth;
@end

#define Width [UIScreen mainScreen].bounds.size.width
#define Height [UIScreen mainScreen].bounds.size.height
#define RandomColor [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1.0]
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray *btnArr = @[@"分享到qq",@"分享到qq空间"];
    for (int i = 0; i < 2; i++) {
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
        btn.frame = CGRectMake(Width / 2 - 50, (i+1)*100, 100, 30);
        btn.tintColor = RandomColor;
        [btn setTitle:btnArr[i] forState:UIControlStateNormal];
        btn.tag = i;
        [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
        
    }
}

//点击了按钮的响应事件

- (void)clickBtn:(UIButton *)btn{
    
    
    switch (btn.tag) {
        case 0://分享到QQ
            [self showMediaNewsWithScene:0];
            break;
            
        case 1://分享到QQ空间
            [self showMediaNewsWithScene:1];
            break;
        default:
            break;
    }
    
    
}



//分享到qq和qq空间的消息
- (void)showMediaNewsWithScene:(int)scene {
    if (![TencentOAuth iphoneQQInstalled]) {
        NSLog(@"请移步App Store去下载腾讯QQ客户端");
    }else {
        self.tencentOAuth = [[TencentOAuth alloc] initWithAppId:@"1104987830" andDelegate:self];
        QQApiNewsObject *newsObj = [QQApiNewsObject
                                    objectWithURL:[NSURL URLWithString:@"www.baidu.com"]
                                    title:@"李易峰撞车了"
                                    description:@"李易峰的兰博基尼被撞了李易峰的兰博基尼被撞了李易峰的兰博基尼被撞了"
                                    previewImageURL:nil];
        SendMessageToQQReq *req = [SendMessageToQQReq reqWithContent:newsObj];
        if (scene == 0) {
            NSLog(@"QQ好友列表分享 - %d",[QQApiInterface sendReq:req]);
        }else if (scene == 1){
            NSLog(@"QQ空间分享 - %d",[QQApiInterface SendReqToQZone:req]);
        }
    }
}


@end
