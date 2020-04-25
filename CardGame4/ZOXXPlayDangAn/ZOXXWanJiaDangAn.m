//
//  ZOXXWanJiaDangAn.m
//  CardGame4
//
//  Created by macos on 2020/4/23.
//  Copyright © 2020 oxxther. All rights reserved.
//

#import "ZOXXWanJiaDangAn.h"
#import "ZOXXSaveData.h"
#import "GameViewController.h"
#import "ZOXXBeginSceneFirst.h"

@implementation ZOXXWanJiaDangAn{
    SKNode *_back;
    SKLabelNode *_money;
    SKLabelNode *_shengming;
    SKLabelNode *_mofa;
    SKLabelNode *_gongji;
    SKLabelNode *_fangyu;
}

- (void)didMoveToView:(SKView *)view {
    _back = [self childNodeWithName:@"//SKBackBar//SKBackNode"];
    _money = (SKLabelNode *)[self childNodeWithName:@"//SKMoneyNode"];
    _shengming = (SKLabelNode *)[self childNodeWithName:@"//SKHPNode"];
    _mofa = (SKLabelNode *)[self childNodeWithName:@"//SKMPNode"];
    _gongji = (SKLabelNode *)[self childNodeWithName:@"//SKAttackNode"];
    _fangyu = (SKLabelNode *)[self childNodeWithName:@"//SKDefenceNode"];
    
    _money.text = [NSString stringWithFormat:@"%ld",[ZOXXSaveData sharedPlayer].money];
    _shengming.text = [NSString stringWithFormat:@"%ld",[ZOXXSaveData sharedPlayer].shengmingzongzhi];
    _mofa.text = [NSString stringWithFormat:@"%ld",[ZOXXSaveData sharedPlayer].neilizongzhi];
    _gongji.text = [NSString stringWithFormat:@"%ld",[ZOXXSaveData sharedPlayer].gongji];
    _fangyu.text = [NSString stringWithFormat:@"%ld",[ZOXXSaveData sharedPlayer].fangyu];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    for (UITouch *t in touches) {
        CGPoint p = [t locationInNode:self];
        SKNode *node = [self nodeAtPoint:p];
        if (node == _back) {
            //返回上一界面
            GameViewController *rootViewController = (GameViewController *)[UIApplication sharedApplication].delegate.window.rootViewController;
            ZOXXBeginSceneFirst *scene = (ZOXXBeginSceneFirst *)[SKScene nodeWithFileNamed:@"ZOXXBeginSceneFirst"];
            scene.bsfd_delegate = rootViewController;
            scene.scaleMode = SKSceneScaleModeFill;
            SKView *skView = (SKView *)self.scene.view;
            SKTransition *tr = [SKTransition moveInWithDirection:SKTransitionDirectionLeft duration:0.25];
            [skView presentScene:scene transition:tr];
        }
    }
}


@end
