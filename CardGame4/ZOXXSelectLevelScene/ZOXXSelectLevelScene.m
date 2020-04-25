//
//  ZOXXSelectLevelScene.m
//  CardGame4
//
//  Created by macos on 2020/4/23.
//  Copyright © 2020 oxxther. All rights reserved.
//

#import "ZOXXSelectLevelScene.h"
#import "GameViewController.h"
#import "ZOXXAlertViewController.h"

@interface ZOXXSelectLevelScene ()

@property (nonatomic) SKSpriteNode *back;

@property (nonatomic) NSArray *nodeLevel;

@end

@implementation ZOXXSelectLevelScene

- (void)didMoveToView:(SKView *)view {
    
    self.back = (SKSpriteNode *)[self childNodeWithName:@"//SKBackBar//SKBackNode"];
    SKNode * Node1 = [self childNodeWithName:@"//SKSpriteNode1"];
    SKNode * Node2 = [self childNodeWithName:@"//SKSpriteNode2"];
    SKNode * Node3 = [self childNodeWithName:@"//SKSpriteNode3"];
    SKNode * Node4 = [self childNodeWithName:@"//SKSpriteNode4"];
    SKNode * Node5 = [self childNodeWithName:@"//SKSpriteNode5"];
    SKNode * Node6 = [self childNodeWithName:@"//SKSpriteNode6"];
    SKNode * Node7 = [self childNodeWithName:@"//SKSpriteNode7"];
    SKNode * Node8 = [self childNodeWithName:@"//SKSpriteNode8"];
    SKNode * Node9 = [self childNodeWithName:@"//SKSpriteNode9"];
    SKNode * Node10 = [self childNodeWithName:@"//SKSpriteNode10"];
    
    self.nodeLevel = @[Node1,Node2,Node3,Node4,Node5,Node6,Node7,Node8,Node9,Node10];
    
    [self setupLevel:[self getImageArray]];
    
}

- (NSArray *)getImageArray{
    NSArray *ImageArray = @[@"SelectLevel4.png",
                            @"SelectLevel5.png",
                            @"SelectLevel6.png",
                            @"SelectLevel7.png",
                            @"SelectLevel8.png",
                            @"SelectLevel9.png",
                            @"SelectLevel10.png",
                            @"SelectLevel11.png",
                            @"SelectLevel12.png"];
    return ImageArray;
}

- (void)setupLevel:(NSArray *)ImageArray{
    for (int index = 0; index < self.nodeLevel.count; index++) {
        SKSpriteNode * node = (SKSpriteNode *)self.nodeLevel[index];
        if (index < [ZOXXSaveData sharedPlayer].kaifaguanqiashu) {
            node.texture = [SKTexture textureWithImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle].bundlePath stringByAppendingPathComponent:ImageArray[index]]]];
        }else{
            node.texture = [SKTexture textureWithImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle].bundlePath stringByAppendingPathComponent:@"SelectLevel13.png"]]];
        }
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    for (UITouch *t in touches) {
        CGPoint p = [t locationInNode:self];
        SKNode *node = [self nodeAtPoint:p];
        if (node == self.back) {
            //返回上一界面
            GameViewController *rootViewController = (GameViewController *)[UIApplication sharedApplication].delegate.window.rootViewController;
            ZOXXBeginSceneFirst *scene = (ZOXXBeginSceneFirst *)[SKScene nodeWithFileNamed:@"ZOXXBeginSceneFirst"];
            scene.bsfd_delegate = rootViewController;
            scene.scaleMode = SKSceneScaleModeFill;
            SKView *skView = (SKView *)self.scene.view;
            SKTransition *tr = [SKTransition moveInWithDirection:SKTransitionDirectionLeft duration:0.25];
            [skView presentScene:scene transition:tr];
        }else{
            
            if ([self.nodeLevel indexOfObject:node] != NSNotFound) {
                
                if ([self.nodeLevel indexOfObject:node] < [ZOXXSaveData sharedPlayer].kaifaguanqiashu) {
                    [ZOXXSaveData sharedPlayer].currentgk = [self.nodeLevel indexOfObject:node] + 1;
                    SKTransition *transition = [SKTransition moveInWithDirection:SKTransitionDirectionRight duration:0.25];
                    UIViewController * rootViewController = [UIApplication sharedApplication].delegate.window.rootViewController;
                    SKView *skView = (SKView *)rootViewController.view;
                    ZOXXMainScene *scene = (ZOXXMainScene *)[SKScene nodeWithFileNamed:@"ZOXXMainSceneView"];
                    scene.scaleMode = SKSceneScaleModeFill;
                    [skView presentScene:scene transition:transition];
                }else{
                    //解锁弹窗
                    NSInteger index = [self.nodeLevel indexOfObject:node];
                    if (index == [ZOXXSaveData sharedPlayer].kaifaguanqiashu) {
                        ZOXXAlertViewController *alertC;
                        NSInteger cost = [self.nodeLevel indexOfObject:node] * 100;
                        if ([ZOXXSaveData sharedPlayer].money >= cost) {
                            alertC = [[ZOXXAlertViewController alloc] initWithTitle:[NSString stringWithFormat:@"解锁需花费%ld金币,确定解锁该关卡？", cost] andLeftBtnTxt:@"确定" andRightBtnTxt:@"取消" andLeftBlock:^{
                                [ZOXXSaveData sharedPlayer].money -= cost;
                                [ZOXXSaveData sharedPlayer].kaifaguanqiashu += 1;
                                [ZOXXSaveData baocunwanjiashuju:[ZOXXSaveData sharedPlayer]];
                                [self setupLevel:[self getImageArray]];
                            } andRightBlock:^{
                                
                            }];
                        }else{
                            alertC = [[ZOXXAlertViewController alloc] initWithTitle:@"金币不够，不能解锁该关卡" andLeftBtnTxt:@"确定" andRightBtnTxt:@"取消" andLeftBlock:^{
                                
                            } andRightBlock:^{
                                
                            }];
                        }
                        UIViewController * rootViewController = [UIApplication sharedApplication].delegate.window.rootViewController;
                        [rootViewController presentViewController:alertC animated:NO completion:nil];
                    }
                    if (index > [ZOXXSaveData sharedPlayer].kaifaguanqiashu) {
                        ZOXXAlertViewController *alertC;
                        alertC = [[ZOXXAlertViewController alloc] initWithTitle:@"请解锁前一关卡" andLeftBtnTxt:@"确定" andRightBtnTxt:@"取消" andLeftBlock:^{
                           
                        } andRightBlock:^{
                            
                        }];
                        UIViewController * rootViewController = [UIApplication sharedApplication].delegate.window.rootViewController;
                        [rootViewController presentViewController:alertC animated:NO completion:nil];
                    }
                }
            }
        }
    }
}

@end
