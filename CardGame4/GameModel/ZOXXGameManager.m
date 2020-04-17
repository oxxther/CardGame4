//
//  ZOXXGameManager.m
//  CardGame4
//
//  Created by macos on 2020/4/16.
//  Copyright © 2020 oxxther. All rights reserved.
//

#import "ZOXXGameManager.h"

@interface ZOXXGameManager ()
{
    SKNode *_wanjiashoupaiNode;
    SKNode *_laodashoupaiNode;
    SKNode *_useCardShowNode;
}

@property (nonatomic) BOOL isMyTurn;

@property (nonatomic) NSUInteger useDaZuo;

@end

@implementation ZOXXGameManager

- (instancetype)init{
    if (self = [super init]) {
//        _isMyTurn = arc4random() % 2;
        _isMyTurn = NO;
        _useDaZuo = 0;
    }
    return self;
}

- (void)gameStart:(void (^)(void))finishedBlock{
    //预设定位置
    _useCardShowNode = [self.scene childNodeWithName:@"//UseCardShow"];
    ZOXXCard *cardShow = [[ZOXXCard alloc] initWithColor:[UIColor greenColor] size:CGSizeMake(200, 300)];
    [_useCardShowNode addChild:cardShow];
    
    //
    SKNode *_StartEffect = [self.scene childNodeWithName:@"//StartEffect"];
    SKSpriteNode *_WanJiaSpriteNode = (SKSpriteNode *)[self.scene childNodeWithName:@"//StartEffect//WanJia"];
    SKSpriteNode *_LaoDaSpriteNode = (SKSpriteNode *)[self.scene childNodeWithName:@"//StartEffect//LaoDa"];
    SKSpriteNode *_DuelSpriteNode = (SKSpriteNode *)[self.scene childNodeWithName:@"//StartEffect//DuelFlag"];
    _DuelSpriteNode.hidden = YES;
    
    __weak typeof(_LaoDaSpriteNode) weakSelf_ld = _LaoDaSpriteNode;
    _LaoDaSpriteNode.texture = [SKTexture textureWithImage:[UIImage imageWithContentsOfFile:_laoda.headerImage]];
    [_LaoDaSpriteNode runAction:[SKAction actionNamed:@"LaoDaEnter"]];
    
    __weak typeof(_WanJiaSpriteNode) weakSelf_wj = _WanJiaSpriteNode;
    _WanJiaSpriteNode.texture = [SKTexture textureWithImage:[UIImage imageWithContentsOfFile:_wanjia.headerImage]];
    [_WanJiaSpriteNode runAction:[SKAction actionNamed:@"WanJiaEnter"] completion:^{
        
        //再对对决效果动画
        SKAction *scaleAction0 = [SKAction scaleTo:5 duration:0];
        SKAction *scaleAction1 = [SKAction unhide];
        SKAction *scaleAction2 = [SKAction scaleTo:2 duration:0.5];
        SKAction *scaleAction3 = [SKAction actionNamed:@"StayUp"];
        SKAction *scaleActions = [SKAction sequence:@[scaleAction0,scaleAction1,scaleAction2,scaleAction3]];
        
        __weak typeof(_DuelSpriteNode) weakSelf_duel = _DuelSpriteNode;
        [_DuelSpriteNode runAction:scaleActions completion:^{
            [_StartEffect runAction:[SKAction fadeAlphaTo:0 duration:0.25] completion:^{
                weakSelf_wj.hidden = YES;
                weakSelf_ld.hidden = YES;
                weakSelf_duel.hidden = YES;
                
                //进场动画
                SKSpriteNode *_WanJiaBJNode = (SKSpriteNode *)[self.scene childNodeWithName:@"//WanJiaDetail//WanJiaBeiJing"];
                SKSpriteNode *_LaoDaBJNode = (SKSpriteNode *)[self.scene childNodeWithName:@"//LaoDaDetail//LaoDaBeiJing"];
                SKAction *wjAction = [SKAction actionNamed:@"WanJiaBeiJingMove"];
                SKAction *ldAction = [SKAction actionNamed:@"LaoDaBeiJingMove"];
                [_LaoDaBJNode runAction:ldAction];
                [_WanJiaBJNode runAction:wjAction completion:^{
                    if (finishedBlock) {
                        finishedBlock();
                    }
                }];
            }];
        }];
        
    }];
}

- (ZOXXPlayer *)createWanJiaPlayer{
    ZOXXPlayer *wanjia = [ZOXXPlayer createWithType:MenPaiAddressTypeDaXueShan];
    self.wanjia = wanjia;
    return wanjia;
}

- (ZOXXPlayer *)createLaoDaPlayer{
    ZOXXPlayer *laoda = [ZOXXPlayer createWithType:MenPaiAddressTypeBingHuoDao];
    self.laoda = laoda;
    return laoda;
}

- (void)initWanJiaShouPai:(void (^)(void))finishedBlock{
    SKNode *wanjiaNode = [self.scene childNodeWithName:@"//WanJiaShouPai"];
    _wanjiashoupaiNode = wanjiaNode;
    NSMutableArray *shouPaiArray = [NSMutableArray array];
    //初始4张牌
    for (int i = 0; i < 4; i++) {
        ZOXXCard * node = [[ZOXXCard alloc] initWithColor:[UIColor redColor] size:CGSizeMake(200, 300)];
        node.anchorPoint = CGPointMake(0, 0);
        node.position = CGPointMake(-200, 0);
        node.cardData = [self _createCardData];
        [wanjiaNode addChild:node];
        [shouPaiArray addObject:node];
    }
    self.wanjia.shoupaiArray = shouPaiArray;
    
    //动画执行
    for (int i = 0; i < shouPaiArray.count; i++) {
        SKAction *action = [SKAction moveToX:0 + i* 210 duration:1];
        ZOXXCard *card = shouPaiArray[i];
        [card runAction:action];
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (finishedBlock) {
            finishedBlock();
        }
    });
}

- (void)initLaoDaShouPai{
    SKNode *laodaNode = [self.scene childNodeWithName:@"//LaoDaShouPai"];
    _laodashoupaiNode = laodaNode;
    NSMutableArray *shouPaiArray = [NSMutableArray array];
    //初始4张牌
//    for (int i = 0; i < 4; i++) {
//        ZOXXCard * node = [[ZOXXCard alloc] initWithColor:[UIColor redColor] size:CGSizeMake(200, 300)];
//        node.anchorPoint = CGPointMake(0, 1);
//        node.position = CGPointMake(-200, 0);
//        node.cardData = [self _createCardData];
//        [laodaNode addChild:node];
//        [shouPaiArray addObject:node];
//    }
    for (int i = 0; i < 3; i++) {
        ZOXXCard * node = [[ZOXXCard alloc] initWithColor:[UIColor redColor] size:CGSizeMake(200, 300)];
        node.anchorPoint = CGPointMake(0, 1);
        node.position = CGPointMake(-200, 0);
        node.cardData = [self _createCardData];
        [laodaNode addChild:node];
        [shouPaiArray addObject:node];
    }
    ZOXXCard * node = [[ZOXXCard alloc] initWithColor:[UIColor redColor] size:CGSizeMake(200, 300)];
    node.anchorPoint = CGPointMake(0, 1);
    node.position = CGPointMake(-200, 0);
    node.cardData = [ZOXXCardData createWithType:ZOXXCardTypeXiQi];
    [laodaNode addChild:node];
    [shouPaiArray addObject:node];
    self.laoda.shoupaiArray = shouPaiArray;
    
    //动画执行
    for (int i = 0; i < shouPaiArray.count; i++) {
        SKAction *action = [SKAction moveToX:0 + i* 210 duration:1];
        ZOXXCard *card = shouPaiArray[i];
        [card runAction:action];
    }
}

- (BOOL)inMyTurn{
    return self.isMyTurn;
}

- (void)enterDrawCardWithNum:(NSInteger)cardNum complish:(void (^)(void))finishedBlock{
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i < cardNum; i++) {
        ZOXXCard * node1 = [[ZOXXCard alloc] initWithColor:[UIColor redColor] size:CGSizeMake(200, 300)];
        node1.cardData = [self _createCardData];
        node1.position = CGPointMake(-200, 0);
        [array addObject:node1];
    }
    if (self.isMyTurn) {
        [self.wanjia.shoupaiArray addObjectsFromArray:array];
        for (ZOXXCard *cardNode in array) {
            cardNode.anchorPoint = CGPointMake(0, 0);
            [_wanjiashoupaiNode addChild:cardNode];
            CGFloat x1 = [self.wanjia.shoupaiArray indexOfObject:cardNode] * 210;
            [cardNode runAction:[SKAction moveToX:x1 duration:1]];
        }
    }else{
        [self.laoda.shoupaiArray addObjectsFromArray:array];
        for (ZOXXCard *cardNode in array) {
            cardNode.anchorPoint = CGPointMake(0, 1);
            [_laodashoupaiNode addChild:cardNode];
            CGFloat x1 = [self.laoda.shoupaiArray indexOfObject:cardNode] * 210;
            [cardNode runAction:[SKAction moveToX:x1 duration:1]];
        }
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (finishedBlock) {
            finishedBlock();
        }
    });
}

- (void)enterUseCard{
    if (self.isMyTurn) {
        //等待玩家使用牌
    }else{
        //电脑人使用牌
        //电脑人的玩法规则
        /**
         1.寻找有没有妙手牌，
         2.寻找有没有打坐牌，
         3.寻找有没有兵器牌，
         4.寻找有木有服饰牌，
         5.寻找有没有破防牌，
         6.寻找有没有令牌牌，
         7.寻找有没有吸气牌，
         8.寻找有没有合适的攻击技能，（忽略）
         9.寻找有没有拳攻或兵攻牌，有的话就寻找有没有加力牌
         */
        //1.寻找有没有妙手牌，
        if ([self _lookupCardWith:NO andCardType:ZOXXCardTypeMiaoShou]) {
            return;
        }
        
        //2.寻找有没有打坐牌，
        if ([self _needLookUpDaZuo] && [self _lookupCardWith:NO andCardType:ZOXXCardTypeDaZuo]) {
            return;
        }
        
        //3.寻找有没有兵器牌，
        if ([self _lookupCardWith:NO andCardType:ZOXXCardTypeBingQi]) {
            return;
        }
        
        //4.寻找有木有服饰牌，
        if ([self _lookupCardWith:NO andCardType:ZOXXCardTypeFuShi]) {
            return;
        }
        
        //5.寻找有没有破防牌，
        if ([self.wanjia hasBingQi] || [self.wanjia hasFuShi]) {
            if ([self _lookupCardWith:NO andCardType:ZOXXCardTypePoFang]) {
                return;
            }
        }
        
        //6.寻找有没有令牌牌，
        if ([self _lookupCardWith:NO andCardType:ZOXXCardTypeLingpai]) {
            return;
        }
        
        //7.寻找有没有吸气牌，
        if (![self.laoda isFullBlood] && [self _lookupCardWith:NO andCardType:ZOXXCardTypeXiQi]) {
            return;
        }
        
        //8.寻找有没有合适的攻击技能，（忽略）
        
        //9.寻找有没有拳攻或兵攻牌，有的话就寻找有没有加力牌
        if ([self _lookupCardWithNoUse:NO andCardType:ZOXXCardTypeBingGong] ||
            [self _lookupCardWithNoUse:NO andCardType:ZOXXCardTypeQuanGong]) {
            if ([self _lookupCardWith:NO andCardType:ZOXXCardTypeJiaLi]) {
                return;
            }
        }
        
        if (!self.laoda.cangongji && [self.laoda hasBingQi] && [self _lookupCardWith:NO andCardType:ZOXXCardTypeBingGong]) {
            return;
        }
        
        if (!self.laoda.cangongji && [self _lookupCardWith:NO andCardType:ZOXXCardTypeQuanGong]) {
            return;
        }
    }
}

- (void)enterResponseState:(ZOXXCardType)cardType{
    if (self.isMyTurn) {
        
    }else{
        switch (cardType) {
            case ZOXXCardTypeMiaoShou:
            {
                if (self.wanjia.shoupaiArray.count == 0) {
                    //流程1
                    //摸出两张牌
                    [self enterDrawCardWithNum:2 complish:^{
                        [self enterUseCard];
                    }];
                }else{
                    //流程2
                    //从对手手中拿取一张card牌加入自己手中
                    int selectedIndex = arc4random() % self.wanjia.shoupaiArray.count;
                    ZOXXCard *card = self.wanjia.shoupaiArray[selectedIndex];
                    //动画执行
                    ZOXXCard *lastCard = self.laoda.shoupaiArray.lastObject;
                    CGPoint targetP = CGPointMake(lastCard.position.x + 210, lastCard.position.y-300);
                    CGPoint point = [card.parent convertPoint:targetP fromNode:lastCard.parent];
                    [card runAction:[SKAction moveTo:point duration:1] completion:^{
                        
                        //移除
                        [self.wanjia.shoupaiArray removeObject:card];
                        [card removeFromParent];
                        [self.laoda.shoupaiArray addObject:card];
                        [self->_laodashoupaiNode addChild:card];
                        card.anchorPoint = CGPointMake(0, 1);
                        card.position = CGPointMake(card.position.x, 0);
                        
                        [self _layoutCardWith:YES complish:^{
                            [self enterUseCard];
                        }];
                    }];
                }
            }
                break;
            case ZOXXCardTypeDaZuo:
            {
                self.useDaZuo += 1;
                self.laoda.neili += 1;
                [self enterUseCard];
            }
                break;
            case ZOXXCardTypeBingQi:
            {
                //检查自身是否有兵器
                if ([self.laoda hasBingQi]) {
                    //摸一张牌
                    NSLog(@"摸一张牌");
                    [self enterDrawCardWithNum:1 complish:^{
                        [self enterUseCard];
                    }];
                }else{
                    //装备兵器
                    [self enterUseCard];
                }
            }
                break;
            case ZOXXCardTypeFuShi:
            {
                //检查自身是否有服饰
                if ([self.laoda hasFuShi]) {
                    //摸一张牌
                    NSLog(@"摸一张牌");
                    [self enterDrawCardWithNum:1 complish:^{
                        [self enterUseCard];
                    }];
                }else{
                    //装备服饰
                    [self enterUseCard];
                }
            }
                break;
            case ZOXXCardTypePoFang:
            {
                if ([self.wanjia hasBingQi]) {
                    //弃置武器
                    [self enterUseCard];
                    break;
                }
                if ([self.wanjia hasFuShi]) {
                    //弃置防具
                    [self enterUseCard];
                    break;
                }
            }
                break;
            case ZOXXCardTypeLingpai:
            {
                //等待玩家出牌，开放玩家响应阶段
                [self _openWanjiaAction];
            }
                break;
            case ZOXXCardTypeXiQi:
            {
                self.laoda.neili -= 1;
                self.laoda.shengming += 1;
                [self enterUseCard];
            }
                break;
            case ZOXXCardTypeJiaLi:
            {
                self.laoda.jiali = YES;
                [self enterUseCard];
            }
                break;
            case ZOXXCardTypeBingGong:
            {
                //等待玩家出牌，开放玩家响应阶段
                [self _openWanjiaAction:cardType];
            }
                break;
            case ZOXXCardTypeQuanGong:
            {
                //等待玩家出牌，开放玩家响应阶段
                [self _openWanjiaAction];
            }
                break;
            default:
                break;
        }
    }
}

#pragma mark - private game methods
- (NSArray *)_cardTypeArray{
    return @[
        [NSNumber numberWithInteger:ZOXXCardTypeQuanGong],
        [NSNumber numberWithInteger:ZOXXCardTypeBingGong],
        [NSNumber numberWithInteger:ZOXXCardTypeDuoShan],
        [NSNumber numberWithInteger:ZOXXCardTypeZhaoJia],
        [NSNumber numberWithInteger:ZOXXCardTypeDaZuo],
        [NSNumber numberWithInteger:ZOXXCardTypeXiQi],
        [NSNumber numberWithInteger:ZOXXCardTypeJiaLi],
        [NSNumber numberWithInteger:ZOXXCardTypeLingpai],
        [NSNumber numberWithInteger:ZOXXCardTypeBingQi],
        [NSNumber numberWithInteger:ZOXXCardTypeFuShi],
        [NSNumber numberWithInteger:ZOXXCardTypeMiaoShou],
        [NSNumber numberWithInteger:ZOXXCardTypePoFang],
        [NSNumber numberWithInteger:ZOXXCardTypeDianXue],
    ];
}

- (ZOXXCardData *)_createCardData{
    int index = arc4random() % [self _cardTypeArray].count;
    NSNumber *cardType = [self _cardTypeArray][index];
    ZOXXCardData *cardData = [ZOXXCardData createWithType:(ZOXXCardType)cardType.integerValue];
    return cardData;
}

- (void)_layoutCardWith:(BOOL)wanjia complish:(void (^)(void))finishedBlock{
    NSArray *array = self.laoda.shoupaiArray;
    if (wanjia) {
        array = self.wanjia.shoupaiArray;
    }
    
    for (int i = 0; i < array.count; i ++) {
        ZOXXCard *card = array[i];
        [card runAction:[SKAction moveToX:210 * i duration:1]];
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (finishedBlock) {
            finishedBlock();
        }
    });
}

- (BOOL)_lookupCardWith:(BOOL)wanjia andCardType:(ZOXXCardType)cardType{
    NSArray *array = self.laoda.shoupaiArray;
    if (wanjia) {
        array = self.wanjia.shoupaiArray;
    }
    
    BOOL flag = NO;
    for (int i = 0; i < array.count; i ++) {
        ZOXXCard *card = array[i];
        if (card.cardData.type == cardType) {
            flag = YES;
            //执行动画
            CGPoint point = [card.parent convertPoint:_useCardShowNode.position fromNode:_useCardShowNode.parent];
            point.x -= 100;
            point.y += 150;
            [card runAction:[SKAction moveTo:point duration:1] completion:^{
                //把内容交给当前节点
                ZOXXCard *cardShow = (ZOXXCard *)[self->_useCardShowNode.children firstObject];
                cardShow.cardData = card.cardData;
                NSLog(@"%@",cardShow.cardData.descriptionString);
                
                //移除节点
                [card removeFromParent];
                if (wanjia) {
                    [self.wanjia.shoupaiArray removeObject:card];
                }else{
                    [self.laoda.shoupaiArray removeObject:card];
                }

                //调用重新布局方法
                [self _layoutCardWith:wanjia complish:^{
                    //调用响应阶段
                    [self enterResponseState:card.cardData.type];
                }];
            }];
            break;
        }
    }
    return flag;
}

- (BOOL)_needLookUpDaZuo{
    if (self.useDaZuo < 2) {
        return YES;
    }
    return NO;
}

- (BOOL)_lookupCardWithNoUse:(BOOL)wanjia andCardType:(ZOXXCardType)cardType{
    NSArray *array = self.laoda.shoupaiArray;
    if (wanjia) {
        array = self.wanjia.shoupaiArray;
    }
    
    BOOL flag = NO;
    for (int i = 0; i < array.count; i ++) {
        ZOXXCard *card = array[i];
        if (card.cardData.type == cardType) {
            flag = YES;
            break;
        }
    }
    return flag;
}

- (void)_openWanjiaAction:(ZOXXCardType)cardType{
    for (ZOXXCard *card in self.wanjia.shoupaiArray) {
        switch (cardType) {
            case ZOXXCardTypeLingpai:
            {
                if (card.cardData.type == ZOXXCardTypeQuanGong ||
                    ([self.wanjia hasBingQi] && card.cardData.type == ZOXXCardTypeBingGong)) {
                    card.userInteractionEnabled = YES;
                }
            }
                break;
            case ZOXXCardTypeQuanGong:
            {
                //加力，我就
                if (self.wanjia.jiali) {
                    
                }else{
                    
                }
            }
                break;
            default:
                break;
        }
        card.userInteractionEnabled = YES;
    }
}

@end
