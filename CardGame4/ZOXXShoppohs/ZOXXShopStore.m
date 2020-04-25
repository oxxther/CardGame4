//
//  ZOXXShopStore.m
//  CardGame4
//
//  Created by macos on 2020/4/23.
//  Copyright © 2020 oxxther. All rights reserved.
//

#import "ZOXXShopStore.h"
#import "GameViewController.h"
#import "ZOXXBeginSceneFirst.h"

#import "ZOXXAlertViewController.h"

@implementation ZOXXShopStore{
    SKNode *_back;
    SKNode *_SKBuy1Node;
    SKNode *_SKBuy2Node;
    SKNode *_SKBuy3Node;
    SKNode *_SKBuy4Node;
    
    SKLabelNode *_SKMoney1Node;
    SKLabelNode *_SKMoney2Node;
    SKLabelNode *_SKMoney3Node;
    SKLabelNode *_SKMoney4Node;
}

- (void)didMoveToView:(SKView *)view {
    _back = [self childNodeWithName:@"//SKBackBar//SKBackNode"];
    _SKBuy1Node = [self childNodeWithName:@"//SKSpriteNode1//SKBuy1Node"];
    _SKBuy2Node = [self childNodeWithName:@"//SKSpriteNode2//SKBuy2Node"];
    _SKBuy3Node = [self childNodeWithName:@"//SKSpriteNode3//SKBuy3Node"];
    _SKBuy4Node = [self childNodeWithName:@"//SKSpriteNode4//SKBuy4Node"];
    
    [self setupMoney];
}

- (void)setupMoney{
    _SKMoney1Node = (SKLabelNode *)[_SKBuy1Node childNodeWithName:@"//SKMoney1Node"];
    _SKMoney2Node = (SKLabelNode *)[_SKBuy2Node childNodeWithName:@"//SKMoney2Node"];
    _SKMoney3Node = (SKLabelNode *)[_SKBuy3Node childNodeWithName:@"//SKMoney3Node"];
    _SKMoney4Node = (SKLabelNode *)[_SKBuy4Node childNodeWithName:@"//SKMoney4Node"];
    
    _SKMoney1Node.text = [NSString stringWithFormat:@"金币：%ld",(100 + [ZOXXSaveData sharedPlayer].buy1*50)];
    _SKMoney2Node.text = [NSString stringWithFormat:@"金币：%ld",(50 + [ZOXXSaveData sharedPlayer].buy2*50)];
    _SKMoney3Node.text = [NSString stringWithFormat:@"金币：%ld",(200 + [ZOXXSaveData sharedPlayer].buy3*50)];
    _SKMoney4Node.text = [NSString stringWithFormat:@"金币：%ld",(200 + [ZOXXSaveData sharedPlayer].buy4*50)];
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
        
        
        if ([[self nodesAtPoint:p] containsObject:_SKBuy1Node]) {
            ZOXXSaveData *data = [ZOXXSaveData sharedPlayer];
            NSString *title = nil;
            NSString *ltxt = nil;
            NSString *rtxt = nil;
            void (^left)(void);
            if (data.money - (100 + data.buy1*50) >= 0) {
                title = [NSString stringWithFormat:@"花费%ld金币，购买该道具？",(100 + data.buy1*50)];
                ltxt = @"确定";
                rtxt = @"取消";
                left = ^(){
                    data.money -= (100 + data.buy1*50);
                    data.buy1 += 1;
                    data.shengmingzongzhi += 1;
                    [ZOXXSaveData baocunwanjiashuju:data];
                    [self setupMoney];
                };
            }else{
                title = @"金币不足，请努力赚取吧！";
                ltxt = @"我会努力的";
                rtxt = @"取消";
                left = ^(){
                    
                };
            }
            ZOXXAlertViewController *vc = [[ZOXXAlertViewController alloc] initWithTitle:title andLeftBtnTxt:ltxt andRightBtnTxt:rtxt andLeftBlock:left andRightBlock:^{
                
            }];
            UIViewController *rootViewController = [UIApplication sharedApplication].delegate.window.rootViewController;
            [rootViewController presentViewController:vc animated:NO completion:nil];
        }
        
        if ([[self nodesAtPoint:p] containsObject:_SKBuy2Node]) {
            ZOXXSaveData *data = [ZOXXSaveData sharedPlayer];
            NSString *title = nil;
            NSString *ltxt = nil;
            NSString *rtxt = nil;
            void (^left)(void);
            if (data.money - (50 + data.buy1*50) >= 0) {
                title = [NSString stringWithFormat:@"花费%ld金币，购买该道具？",(50 + data.buy2*50)];
                ltxt = @"确定";
                rtxt = @"取消";
                left = ^(){
                    data.money -= (50 + data.buy2*50);
                    data.buy2 += 1;
                    data.neilizongzhi += 1;
                    [ZOXXSaveData baocunwanjiashuju:data];
                    [self setupMoney];
                };
            }else{
                title = @"金币不足，请努力赚取吧！";
                ltxt = @"我会努力的";
                rtxt = @"取消";
                left = ^(){
                    
                };
            }
            ZOXXAlertViewController *vc = [[ZOXXAlertViewController alloc] initWithTitle:title andLeftBtnTxt:ltxt andRightBtnTxt:rtxt andLeftBlock:left andRightBlock:^{
                
            }];
            UIViewController *rootViewController = [UIApplication sharedApplication].delegate.window.rootViewController;
            [rootViewController presentViewController:vc animated:NO completion:nil];
        }
        
        if ([[self nodesAtPoint:p] containsObject:_SKBuy3Node]) {
            ZOXXSaveData *data = [ZOXXSaveData sharedPlayer];
            NSString *title = nil;
            NSString *ltxt = nil;
            NSString *rtxt = nil;
            void (^left)(void);
            if (data.money - (200 + data.buy3*50) >= 0) {
                title = [NSString stringWithFormat:@"花费%ld金币，购买该道具？",(200 + data.buy3*50)];
                ltxt = @"确定";
                rtxt = @"取消";
                left = ^(){
                    data.money -= (200 + data.buy3*50);
                    data.buy3 += 1;
                    data.gongji += 1;
                    [ZOXXSaveData baocunwanjiashuju:data];
                    [self setupMoney];
                };
            }else{
                title = @"金币不足，请努力赚取吧！";
                ltxt = @"我会努力的";
                rtxt = @"取消";
                left = ^(){
                    
                };
            }
            ZOXXAlertViewController *vc = [[ZOXXAlertViewController alloc] initWithTitle:title andLeftBtnTxt:ltxt andRightBtnTxt:rtxt andLeftBlock:left andRightBlock:^{
                
            }];
            UIViewController *rootViewController = [UIApplication sharedApplication].delegate.window.rootViewController;
            [rootViewController presentViewController:vc animated:NO completion:nil];
        }
        
        if ([[self nodesAtPoint:p] containsObject:_SKBuy4Node]) {
            ZOXXSaveData *data = [ZOXXSaveData sharedPlayer];
            NSString *title = nil;
            NSString *ltxt = nil;
            NSString *rtxt = nil;
            void (^left)(void);
            if (data.money - (200 + data.buy4*50) >= 0) {
                title = [NSString stringWithFormat:@"花费%ld金币，购买该道具？",(200 + data.buy4*50)];
                ltxt = @"确定";
                rtxt = @"取消";
                left = ^(){
                    data.money -= (200 + data.buy4*50);
                    data.buy4 += 1;
                    data.fangyu += 1;
                    [ZOXXSaveData baocunwanjiashuju:data];
                    [self setupMoney];
                };
            }else{
                title = @"金币不足，请努力赚取吧！";
                ltxt = @"我会努力的";
                rtxt = @"取消";
                left = ^(){
                    
                };
            }
            ZOXXAlertViewController *vc = [[ZOXXAlertViewController alloc] initWithTitle:title andLeftBtnTxt:ltxt andRightBtnTxt:rtxt andLeftBlock:left andRightBlock:^{
                
            }];
            UIViewController *rootViewController = [UIApplication sharedApplication].delegate.window.rootViewController;
            [rootViewController presentViewController:vc animated:NO completion:nil];
        }
    }
}

@end
