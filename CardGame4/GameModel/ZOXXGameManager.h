//
//  ZOXXGameManager.h
//  CardGame4
//
//  Created by macos on 2020/4/16.
//  Copyright © 2020 oxxther. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>
#import "ZOXXPlayer.h"
#import "ZOXXCardData.h"
#import "ZOXXCard.h"
#import "ZOXXMainScene.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZOXXGameManager : NSObject

@property (nonatomic) SKScene * scene;

@property (nonatomic) ZOXXPlayer * wanjia;

@property (nonatomic) ZOXXPlayer * laoda;

@property (nonatomic) void (^endGame)(void);

//游戏开始
- (void)gameStart:(void (^)(void))finishedBlock;

//初始化玩家数据
- (ZOXXPlayer *)createWanJiaPlayer;

//初始化老大数据
- (ZOXXPlayer *)createLaoDaPlayer;

//初始化玩家手牌数据
- (void)initWanJiaShouPai:(void (^)(void))finishedBlock;

//初始化老大手牌数据
- (void)initLaoDaShouPai;

//确定谁的回合  <--|
//               |
- (BOOL)inMyTurn;

//进入摸牌阶段     |
//               |
- (void)enterDrawCardWithNum:(NSInteger)cardNum complish:(void (^)(void))finishedBlock;

//进入出牌阶段     |
//               |
- (void)enterUseCard;

//进入响应阶段     |
//               |
- (void)enterResponseState:(ZOXXCardType)cardType;

//进入结算阶段     |
//               |
//  -------------|
- (void)enterJieSuanState:(ZOXXCardType)cardType isUseCard:(BOOL)use;

- (void)showDesktop;

@end

NS_ASSUME_NONNULL_END
