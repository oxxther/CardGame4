//
//  ZOXXMainScene.m
//  CardGame4
//
//  Created by macos on 2020/4/14.
//  Copyright © 2020 oxxther. All rights reserved.
//

//  1.初始化我方角色和敌方角色
//  2.初始化hp、内力、武器、防具
//  3.初始化手牌
//  4.进入战斗流程
//  5.进入结算流程

#import "ZOXXMainScene.h"

@implementation ZOXXMainScene{
    SKSpriteNode *_WanJiaSpriteNode;
    SKSpriteNode *_LaoDaSpriteNode;
    SKSpriteNode *_DuelSpriteNode;
    SKNode *_StartEffect;
    
    //游戏数据类
    ZOXXPlayer *_wanjia;
    ZOXXPlayer *_laoda;
}

- (void)didMoveToView:(SKView *)view {
   
    //创建游戏管理对象
    ZOXXGameManager *gm = [[ZOXXGameManager alloc] init];
    //设置管理场景
    gm.scene = self;
    
    //初始化我方和敌方数据
    [gm createWanJiaPlayer];
    [gm createLaoDaPlayer];
    
    //游戏开场动画
    [gm gameStart:^{
        [gm initLaoDaShouPai];
        [gm initWanJiaShouPai:^{
            NSLog(@"准备进入摸排阶段");
            [gm enterDrawCardWithNum:2 complish:^{
                NSLog(@"准备进入决斗阶段");
                [gm enterUseCard];
            }];
        }];
    }];
    
}

@end
