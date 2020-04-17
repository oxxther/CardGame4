//
//  ZOXXBeginSceneFirst.m
//  CardGame4
//
//  Created by macos on 2020/4/14.
//  Copyright © 2020 oxxther. All rights reserved.
//

#import "ZOXXBeginSceneFirst.h"

@implementation ZOXXBeginSceneFirst{
    SKSpriteNode *_bgSpriteNode;
    SKSpriteNode *_fgSpriteNode;
    SKSpriteNode *_sgSpriteNode;
    SKSpriteNode *_pdSpriteNode;
    SKSpriteNode *_ngSpriteNode;
    SKSpriteNode *_sSpriteNode;
    SKLabelNode *_alertContent;
}

- (void)didMoveToView:(SKView *)view {
    
    _bgSpriteNode = (SKSpriteNode *)[self childNodeWithName:@"//ZOXXBackground"];
    _fgSpriteNode = (SKSpriteNode *)[self childNodeWithName:@"//ZOXXForceground"];
    _sgSpriteNode = (SKSpriteNode *)[self childNodeWithName:@"//ZOXXStartGame"];
    _pdSpriteNode = (SKSpriteNode *)[self childNodeWithName:@"//ZOXXPlayerData"];
    _ngSpriteNode = (SKSpriteNode *)[self childNodeWithName:@"//ZOXXNewhandGuide"];
    _sSpriteNode = (SKSpriteNode *)[self childNodeWithName:@"//ZOXXShop"];
    
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    for (UITouch *t in touches) {
        CGPoint p = [t locationInNode:self];
        SKNode *node = [self nodeAtPoint:p];
        if (node == _sgSpriteNode) {
            NSLog(@"决战江湖");
            
            if (self.bsfd_delegate && [self.bsfd_delegate respondsToSelector:@selector(ZOXXBeginSceneFirstDidClickSGNode)]) {
                [self.bsfd_delegate ZOXXBeginSceneFirstDidClickSGNode];
            }
            
            return;
        }
        if (node == _pdSpriteNode) {
            NSLog(@"玩家档案");
            
            if (self.bsfd_delegate && [self.bsfd_delegate respondsToSelector:@selector(ZOXXBeginSceneFirstDidClickPDNode)]) {
                [self.bsfd_delegate ZOXXBeginSceneFirstDidClickPDNode];
            }
            
            return;
        }
        if (node == _ngSpriteNode) {
            NSLog(@"新手指南");
            
            if (self.bsfd_delegate && [self.bsfd_delegate respondsToSelector:@selector(ZOXXBeginSceneFirstDidClickNGNode)]) {
                [self.bsfd_delegate ZOXXBeginSceneFirstDidClickNGNode];
            }
            
            return;
        }
        if (node == _sSpriteNode) {
            NSLog(@"商城");
            
            if (self.bsfd_delegate && [self.bsfd_delegate respondsToSelector:@selector(ZOXXBeginSceneFirstDidClickSPNode)]) {
                [self.bsfd_delegate ZOXXBeginSceneFirstDidClickSPNode];
            }
            
            return;
        }
    }
}


@end
