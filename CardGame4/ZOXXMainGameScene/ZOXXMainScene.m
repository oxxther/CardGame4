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
#import "GameViewController.h"
#import "ZOXXSelectLevelScene.h"
#import "ZOXXAlertViewController.h"
#import "ZOXXSpriteButton.h"

@implementation ZOXXMainScene{
    SKNode *_backNode;
    SKNode *_SKGuide1;
    SKNode *_SKGuide2;
    ZOXXGameManager *_gm;
}

- (void)didMoveToView:(SKView *)view {
   
    _backNode = [self.scene childNodeWithName:@"//LaoDaDetail//LaoDaBeiJing//LaoDaExitArea"];
    _SKGuide1 = [self.scene childNodeWithName:@"//SKGuide1"];
    _SKGuide2 = [self.scene childNodeWithName:@"//SKGuide2"];
    
    //创建游戏管理对象
    ZOXXGameManager *gm = [[ZOXXGameManager alloc] init];
    [gm setEndGame:^{
        self->_SKGuide2.hidden = YES;
        self->_SKGuide1.hidden = YES;
    }];
    _gm = gm;
    //设置管理场景
    gm.scene = self;
    
    //初始化我方和敌方数据
    [gm createWanJiaPlayer];
    [gm createLaoDaPlayer];
    
    _SKGuide1.hidden = YES;
    _SKGuide2.hidden = YES;
    
    
    //游戏开场动画
    [gm gameStart:^{
        [gm initLaoDaShouPai];
        [gm initWanJiaShouPai:^{
            NSLog(@"准备进入摸排阶段");
            [gm enterDrawCardWithNum:2 complish:^{
                NSLog(@"准备进入出牌阶段");
                [gm enterUseCard];
                [gm showDesktop];
            }];
        }];
    }];
    
}

- (void)show1{
    _SKGuide1.hidden = NO;
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    for (UITouch *t in touches) {
        CGPoint p = [t locationInNode:self];
        SKNode *node = [self nodeAtPoint:p];
        if (node == _backNode) {
            
            ZOXXAlertViewController *vc = [[ZOXXAlertViewController alloc] initWithTitle:@"是否退出该关卡?" andLeftBtnTxt:@"确定" andRightBtnTxt:@"取消" andLeftBlock:^{
                //返回上一界面
                GameViewController *rootViewController = (GameViewController *)[UIApplication sharedApplication].delegate.window.rootViewController;
                ZOXXSelectLevelScene *scene = (ZOXXSelectLevelScene *)[SKScene nodeWithFileNamed:@"ZOXXSelectLevelScene"];
                scene.scaleMode = SKSceneScaleModeFill;
                SKView *skView = (SKView *)rootViewController.view;
                SKTransition *tr = [SKTransition moveInWithDirection:SKTransitionDirectionLeft duration:0.25];
                [skView presentScene:scene transition:tr];
            } andRightBlock:^{
                
            }];
            
            GameViewController *rootViewController = (GameViewController *)[UIApplication sharedApplication].delegate.window.rootViewController;
            [rootViewController presentViewController:vc animated:NO completion:nil];
        }
        
        if (node == _SKGuide1) {
            NSArray * aa = [self nodesAtPoint:p];
            for (SKNode *node in aa) {
                if ([node isMemberOfClass:[ZOXXCard class]]) {
                    [node touchesEnded:touches withEvent:event];
                    //隐藏第一张
                    _SKGuide1.hidden = YES;
                    //出现第二张
                    _SKGuide2.hidden = NO;
                }
            }
        }
        
        if (node == _SKGuide2) {
            NSArray * aa = [self nodesAtPoint:p];
            for (SKNode *node in aa) {
                if ([node isMemberOfClass:[ZOXXSpriteButton class]]) {
                    [node touchesEnded:touches withEvent:event];
//                    //隐藏第二张
                    _SKGuide2.hidden = YES;
//                    _SKGuide1.hidden = NO;
                }
            }
        }
    }
}

@end
