//
//  ZOXXGameManager.m
//  CardGame4
//
//  Created by macos on 2020/4/16.
//  Copyright © 2020 oxxther. All rights reserved.
//

#import "ZOXXGameManager.h"
#import "ZOXXSpriteButton.h"

#import "ZOXXAlertViewController.h"


#import "ZOXXBeginSceneFirst.h"
#import "GameViewController.h"
#import "ZOXXSelectLevelScene.h"

#import "ZOXXSaveData.h"

#import "ZOXXLogPlayer.h"

@interface ZOXXGameManager ()<ZOXXSpriteButtonDelegate,ZOXXCardDelegate>
{
    SKNode *_wanjiashoupaiNode;
    SKNode *_laodashoupaiNode;
    SKNode *_useCardShowNode;
    SKSpriteNode *_WanJiaOpetarionArea;
    ZOXXSpriteButton *_useBtn;
    ZOXXSpriteButton *_noUseBtn;
    ZOXXCard *_currentUseCard;
    ZOXXCard *_currentLaoDaUseCard;
    
    SKSpriteNode *_WanJiaXueTiao;
    SKSpriteNode *_WanJiaXueTiaoBG;
    SKLabelNode *_WanJiaXueTiaoNum;
    SKSpriteNode *_WanJiaLanTiao;
    SKSpriteNode *_WanJiaLanTiaoBG;
    SKLabelNode *_WanJiaLanTiaoNum;
    SKLabelNode *_WanJiaGongJi;
    SKLabelNode *_WanJiaFangYu;
    
    SKSpriteNode *_LaoDaXueTiao;
    SKSpriteNode *_LaoDaXueTiaoBG;
    SKLabelNode *_LaoDaXueTiaoNum;
    SKSpriteNode *_LaoDaLanTiao;
    SKSpriteNode *_LaoDaLanTiaoBG;
    SKLabelNode *_LaoDaLanTiaoNum;
    SKLabelNode *_LaoDaGongJi;
    SKLabelNode *_LaoDaFangYu;
}

@property (nonatomic) BOOL isMyTurn;


@end

@implementation ZOXXGameManager

- (instancetype)init{
    if (self = [super init]) {
        if ([ZOXXSaveData sharedPlayer].diyiciwan) {
            _isMyTurn = YES;
        }else{
            _isMyTurn = arc4random() % 2;
        }
    }
    return self;
}

- (void)gameStart:(void (^)(void))finishedBlock{
    
    //预设定位置
    _useCardShowNode = [self.scene childNodeWithName:@"//UseCardShow"];
    ZOXXCard *cardShow = [[ZOXXCard alloc] initWithDelegate:self andTag:ZOXXCardLabelTypeCenter];
    cardShow.texture = [SKTexture textureWithImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle].bundlePath stringByAppendingPathComponent:@"MainPage10.png"]]];
    _useCardShowNode.hidden = YES;
    [_useCardShowNode addChild:cardShow];
    
    _WanJiaOpetarionArea = (SKSpriteNode *)[self.scene childNodeWithName:@"//WanJiaDetail//WanJiaBeiJing//WanJiaOpetarionArea"];
    //创建自定义控件
    ZOXXSpriteButton *useBtn = [[ZOXXSpriteButton alloc] initWithColor:[UIColor orangeColor] size:CGSizeMake(146, 110)];
    useBtn.delegate = self;
    useBtn.canClickImage = [SKTexture textureWithImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle].bundlePath stringByAppendingPathComponent:@"MainPage12.png"]]];
    useBtn.cannotClickImage = [SKTexture textureWithImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle].bundlePath stringByAppendingPathComponent:@"MainPage11.png"]]];
    useBtn.texture = useBtn.cannotClickImage;
    useBtn.position = CGPointMake(-73, -293 /2.0 + 64);
    [_WanJiaOpetarionArea addChild:useBtn];
    _useBtn = useBtn;
    
    ZOXXSpriteButton *noUseBtn = [[ZOXXSpriteButton alloc] initWithColor:[UIColor orangeColor] size:CGSizeMake(146, 110)];
    noUseBtn.delegate = self;
    noUseBtn.canClickImage = [SKTexture textureWithImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle].bundlePath stringByAppendingPathComponent:@"MainPage13.png"]]];
    noUseBtn.cannotClickImage = [SKTexture textureWithImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle].bundlePath stringByAppendingPathComponent:@"MainPage16.png"]]];
    noUseBtn.texture = noUseBtn.cannotClickImage;
    noUseBtn.position = CGPointMake(-73, -293 /2.0 -64);
    [_WanJiaOpetarionArea addChild:noUseBtn];
    _noUseBtn = noUseBtn;
    
    //
    SKNode *_StartEffect = [self.scene childNodeWithName:@"//StartEffect"];
    SKSpriteNode *_WanJiaSpriteNode = (SKSpriteNode *)[self.scene childNodeWithName:@"//StartEffect//WanJia"];
    SKSpriteNode *_LaoDaSpriteNode = (SKSpriteNode *)[self.scene childNodeWithName:@"//StartEffect//LaoDa"];
    
    _WanJiaSpriteNode.texture = [SKTexture textureWithImage:[UIImage imageWithContentsOfFile:self.wanjia.headerImage]];
    _LaoDaSpriteNode.texture = [SKTexture textureWithImage:[UIImage imageWithContentsOfFile:self.laoda.headerImage]];
    
    SKSpriteNode *_DuelSpriteNode = (SKSpriteNode *)[self.scene childNodeWithName:@"//StartEffect//DuelFlag"];
    _DuelSpriteNode.hidden = YES;
    
    __weak typeof(_LaoDaSpriteNode) weakSelf_ld = _LaoDaSpriteNode;
    [_LaoDaSpriteNode runAction:[SKAction actionNamed:@"LaoDaEnter"]];
    
    __weak typeof(_WanJiaSpriteNode) weakSelf_wj = _WanJiaSpriteNode;
    [_WanJiaSpriteNode runAction:[SKAction actionNamed:@"WanJiaEnter"] completion:^{
        
        //再对对决效果动画
        SKAction *scaleAction0 = [SKAction scaleTo:5 duration:0];
        SKAction *scaleAction1 = [SKAction unhide];
        SKAction *scaleAction2 = [SKAction scaleTo:2 duration:0.5];
        SKAction *scaleAction3 = [SKAction actionNamed:@"StayUp"];
        SKAction *scaleActions = [SKAction sequence:@[scaleAction0,scaleAction1,scaleAction2,scaleAction3]];
        
        __weak typeof(_DuelSpriteNode) weakSelf_duel = _DuelSpriteNode;
        [_DuelSpriteNode runAction:scaleActions completion:^{
            [_StartEffect runAction:[SKAction fadeAlphaTo:0 duration:0.5] completion:^{
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
    ZOXXPlayer *wanjia = [ZOXXPlayer createWithType:MenPaiAddressTypeErCiYueAiHaoZhe];
    wanjia.headerImageNode = (SKSpriteNode *)[self.scene childNodeWithName:@"//WanJiaDetail//WanJiaBeiJing//WanJiaHeadImage"];
    self.wanjia = wanjia;
    wanjia.headerImageNode.texture = [SKTexture textureWithImage:[UIImage imageWithContentsOfFile:self.wanjia.headerImage]];
    
    _WanJiaXueTiao = (SKSpriteNode *)[self.scene childNodeWithName:@"//WanJiaDetail//WanJiaBeiJing//WanJiaShengMingNow"];
    _WanJiaXueTiaoBG = (SKSpriteNode *)[self.scene childNodeWithName:@"//WanJiaDetail//WanJiaBeiJing//WanJiaShengMing"];
    CGFloat s = self.wanjia.shengming / self.wanjia.shengmingshangxian;
    _WanJiaXueTiao.size = CGSizeMake(_WanJiaXueTiaoBG.size.width * s, _WanJiaXueTiaoBG.size.height);
    
    _WanJiaXueTiaoNum = (SKLabelNode *)[self.scene childNodeWithName:@"//WanJiaDetail//WanJiaBeiJing//WanJiaShengMingNum"];
    _WanJiaXueTiaoNum.text = [NSString stringWithFormat:@"%ld/%ld",self.wanjia.shengming,self.wanjia.shengmingshangxian];
    
    _WanJiaLanTiao = (SKSpriteNode *)[self.scene childNodeWithName:@"//WanJiaDetail//WanJiaBeiJing//WanJiaNeiLiNow"];
    _WanJiaLanTiaoBG = (SKSpriteNode *)[self.scene childNodeWithName:@"//WanJiaDetail//WanJiaBeiJing//WanJiaNeiLi"];
    s = self.wanjia.neili / self.wanjia.neilishangxian;
    _WanJiaLanTiao.size = CGSizeMake(_WanJiaLanTiaoBG.size.width * s, _WanJiaLanTiaoBG.size.height);
    
    _WanJiaLanTiaoNum = (SKLabelNode *)[self.scene childNodeWithName:@"//WanJiaDetail//WanJiaBeiJing//WanJiaNeiLiNum"];
    _WanJiaLanTiaoNum.text = [NSString stringWithFormat:@"%ld/%ld",self.wanjia.neili,self.wanjia.neilishangxian];
    
    _WanJiaGongJi = (SKLabelNode *)[self.scene childNodeWithName:@"//WanJiaDetail//WanJiaBeiJing//WanJiaGongJi"];
    _WanJiaGongJi.text = [NSString stringWithFormat:@"%ld",self.wanjia.gongji];
    _WanJiaFangYu = (SKLabelNode *)[self.scene childNodeWithName:@"//WanJiaDetail//WanJiaBeiJing//WanJiaFangYu"];
    _WanJiaFangYu.text = [NSString stringWithFormat:@"%ld",self.wanjia.fangyu];
    return wanjia;
}

- (ZOXXPlayer *)createLaoDaPlayer{
    ZOXXPlayer *laoda = [ZOXXPlayer createWithType:[ZOXXSaveData sharedPlayer].currentgk];
    NSLog(@"%@",laoda.name);
    laoda.headerImageNode = (SKSpriteNode *)[self.scene childNodeWithName:@"//LaoDaDetail//LaoDaBeiJing//LaoDaHeadImage"];
    self.laoda = laoda;
    laoda.headerImageNode.texture = [SKTexture textureWithImage:[UIImage imageWithContentsOfFile:self.laoda.headerImage]];
    
    _LaoDaXueTiao = (SKSpriteNode *)[self.scene childNodeWithName:@"//LaoDaDetail//LaoDaBeiJing//LaoDaShengMingNow"];
    _LaoDaXueTiaoBG = (SKSpriteNode *)[self.scene childNodeWithName:@"//LaoDaDetail//LaoDaBeiJing//LaoDaShengMing"];
    CGFloat s = self.laoda.shengming / self.laoda.shengmingshangxian;
    _LaoDaXueTiao.size = CGSizeMake(_LaoDaXueTiaoBG.size.width * s, _LaoDaXueTiaoBG.size.height);
    
    _LaoDaXueTiaoNum = (SKLabelNode *)[self.scene childNodeWithName:@"//LaoDaDetail//LaoDaBeiJing//LaoDaShengMingNum"];
    _LaoDaXueTiaoNum.text = [NSString stringWithFormat:@"%ld/%ld",self.laoda.shengming,self.laoda.shengmingshangxian];
    
    _LaoDaLanTiao = (SKSpriteNode *)[self.scene childNodeWithName:@"//LaoDaDetail//LaoDaBeiJing//LaoDaNeiLiNow"];
    _LaoDaLanTiaoBG = (SKSpriteNode *)[self.scene childNodeWithName:@"//LaoDaDetail//LaoDaBeiJing//LaoDaNeiLi"];
    s = self.laoda.neili / self.laoda.neilishangxian;
    _LaoDaLanTiao.size = CGSizeMake(_LaoDaLanTiaoBG.size.width * s, _LaoDaLanTiaoBG.size.height);
    
    _LaoDaLanTiaoNum = (SKLabelNode *)[self.scene childNodeWithName:@"//LaoDaDetail//LaoDaBeiJing//LaoDaNeiLiNum"];
    _LaoDaLanTiaoNum.text = [NSString stringWithFormat:@"%ld/%ld",self.laoda.neili,self.laoda.neilishangxian];
    
    _LaoDaGongJi = (SKLabelNode *)[self.scene childNodeWithName:@"//LaoDaDetail//LaoDaBeiJing//LaoDaGongJi"];
    _LaoDaGongJi.text = [NSString stringWithFormat:@"%ld",self.laoda.gongji];
    _LaoDaFangYu = (SKLabelNode *)[self.scene childNodeWithName:@"//LaoDaDetail//LaoDaBeiJing//LaoDaFangYu"];
    _LaoDaFangYu.text = [NSString stringWithFormat:@"%ld",self.laoda.fangyu];
    return laoda;
}

- (void)initWanJiaShouPai:(void (^)(void))finishedBlock{
    SKNode *wanjiaNode = [self.scene childNodeWithName:@"//WanJiaShouPai"];
    _wanjiashoupaiNode = wanjiaNode;
    NSMutableArray *shouPaiArray = [NSMutableArray array];
    //初始4张牌
    
    if (![ZOXXSaveData sharedPlayer].diyiciwan) {
        for (int i = 0; i < 4; i++) {
            ZOXXCard * node = [[ZOXXCard alloc] initWithDelegate:self andTag:ZOXXCardLabelTypeWanJia];
            node.anchorPoint = CGPointMake(0, 0);
            node.position = CGPointMake(-200, 0);
            node.cardData = [self _createCardData];
            [wanjiaNode addChild:node];
            [shouPaiArray addObject:node];
        }
    }else{
        for (int i = 0; i < 4; i++) {
            ZOXXCard * node = [[ZOXXCard alloc] initWithDelegate:self andTag:ZOXXCardLabelTypeWanJia];
            node.anchorPoint = CGPointMake(0, 0);
            node.position = CGPointMake(-200, 0);
            node.cardData = [ZOXXCardData createWithType:ZOXXCardTypePingA];
            [wanjiaNode addChild:node];
            [shouPaiArray addObject:node];
        }
    }
    
    self.wanjia.shoupaiArray = shouPaiArray;
    
    //动画执行
    for (int i = 0; i < shouPaiArray.count; i++) {
        SKAction *action = [SKAction moveToX:0 + i* (CardSize.width + 5) duration:0.5];
        ZOXXCard *card = shouPaiArray[i];
        [card runAction:action];
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        for (ZOXXCard *card in self.wanjia.shoupaiArray) {
            card.origin = card.position;
        }
        for (ZOXXCard *card in self.laoda.shoupaiArray) {
            card.origin = card.position;
        }
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
    if (![ZOXXSaveData sharedPlayer].diyiciwan) {
        for (int i = 0; i < 4; i++) {
            ZOXXCard * node = [[ZOXXCard alloc] initWithDelegate:self andTag:ZOXXCardLabelTypeLaoDa];
            node.anchorPoint = CGPointMake(0, 1);
            node.position = CGPointMake(-200, 0);
            node.cardData = [self _createCardData];
            [laodaNode addChild:node];
            [shouPaiArray addObject:node];
        }
    }else{
        for (int i = 0; i < 4; i++) {
            ZOXXCard * node = [[ZOXXCard alloc] initWithDelegate:self andTag:ZOXXCardLabelTypeLaoDa];
            node.anchorPoint = CGPointMake(0, 1);
            node.position = CGPointMake(-200, 0);
            node.cardData = [ZOXXCardData createWithType:ZOXXCardTypeMingXiang];
            [laodaNode addChild:node];
            [shouPaiArray addObject:node];
        }
    }
    
    self.laoda.shoupaiArray = shouPaiArray;
    
    //动画执行
    for (int i = 0; i < shouPaiArray.count; i++) {
        SKAction *action = [SKAction moveToX:0 + i* (CardSize.width + 5) duration:0.5];
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
        ZOXXCard * node1 = [[ZOXXCard alloc] initWithDelegate:self andTag:[self inMyTurn]];
        node1.cardData = [self _createCardData];
        node1.position = CGPointMake(-200, 0);
        [array addObject:node1];
    }
    if ([self inMyTurn]) {
        [self.wanjia.shoupaiArray addObjectsFromArray:array];
        for (ZOXXCard *cardNode in array) {
            cardNode.anchorPoint = CGPointMake(0, 0);
            [_wanjiashoupaiNode addChild:cardNode];
        }
        
        [self _layoutCardWithWanJia:YES completion:^{
            if ([ZOXXSaveData sharedPlayer].diyiciwan) {
                [((ZOXXMainScene *)self.scene) show1];
            }
        }];
        _noUseBtn.userInteractionEnabled = YES;
        
        //初始化状态
    }else{
        [self.laoda.shoupaiArray addObjectsFromArray:array];
        for (ZOXXCard *cardNode in array) {
            cardNode.anchorPoint = CGPointMake(0, 1);
            [_laodashoupaiNode addChild:cardNode];
        }
        
        [self _layoutCardWithWanJia:NO completion:nil];
        
        //初始化状态
        _useBtn.userInteractionEnabled = NO;
        _noUseBtn.userInteractionEnabled = NO;
    }
    
    //把手牌都激活
    [self _jihuoWanJiaShouPai];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (finishedBlock) {
            for (ZOXXCard *card in self.wanjia.shoupaiArray) {
                card.origin = card.position;
            }
            for (ZOXXCard *card in self.laoda.shoupaiArray) {
                card.origin = card.position;
            }
            finishedBlock();
        }
    });
}

- (void)enterUseCard{
    if ([self inMyTurn]) {
        [self _jihuoWanJiaShouPai];
    }else{
        //电脑人使用牌
        //电脑人的玩法规则
        /**
         1.寻找有没有冥想牌，
         3.寻找有没有兵器牌，
         4.寻找有木有服饰牌，
         5.寻找有没有普攻，
         6.寻找有没有技能1，
         7.寻找有没有技能2，
         */
        
        _useBtn.userInteractionEnabled = NO;
        _noUseBtn.userInteractionEnabled = NO;
        
        //1.寻找有没有冥想牌，
        ZOXXCard *card = nil;
        if ((self.laoda.neili != self.laoda.neilishangxian) && (card = [self _laodaLookupCardType:ZOXXCardTypeMingXiang])) {
            [self _laodaUserCard:card andWanjia:NO andNeedRespond:YES];
            return;
        }
        
        // 3.寻找有没有兵器牌，，
        if ((card = [self _laodaLookupCardType:ZOXXCardTypeBingQi])) {
            [self _laodaUserCard:card andWanjia:NO andNeedRespond:YES];
            return;
        }
        
        //4.寻找有木有服饰牌，，
        if ((card = [self _laodaLookupCardType:ZOXXCardTypeFuShi])) {
            [self _laodaUserCard:card andWanjia:NO andNeedRespond:YES];
            return;
        }
        
        //5.寻找有没有普攻，，
        if ((card = [self _laodaLookupCardType:ZOXXCardTypePingA])) {
            [self _laodaUserCard:card andWanjia:NO andNeedRespond:YES];
            return;
        }
        
        //6.寻找有没有技能，
        if ((card = [self _laodaLookupCardType:ZOXXCardTypeJiNeng]) && self.laoda.neili > 0) {
            [self _laodaUserCard:card andWanjia:NO andNeedRespond:YES];
            return;
        }
        
        
        //已经过了出牌阶段
        self.isMyTurn = YES;
        [self enterDrawCardWithNum:2 complish:^{
            
        }];
    }
}

- (void)enterResponseState:(ZOXXCardType)cardType{
    [self _jihuoWanJiaShouPai];
    _noUseBtn.userInteractionEnabled = YES;
    ZOXXPlayer *player = nil;
    if ([self inMyTurn]) {
        player = self.wanjia;
    }else{
        player = self.laoda;
    }
    switch (cardType) {
        case ZOXXCardTypeMingXiang:
        {
            player.neili += 1;
            [self _huiLan:player];
            [self enterUseCard];
        }
            break;
        case ZOXXCardTypeBingQi:
        {
            player.gongji += 1;
            [self _jiagongji:player];
            [self enterUseCard];
            
        }
            break;
        case ZOXXCardTypeFuShi:
        {
            player.fangyu += 1;
            [self _jiafangyu:player];
            [self enterUseCard];
        }
            break;
        case ZOXXCardTypePingA:
        {
            //进入对方流程
            if (![self inMyTurn]) {
                for (ZOXXCard *ocard in self.wanjia.shoupaiArray) {
                    if (ocard.cardData.type == ZOXXCardTypeGeDang ||
                        ocard.cardData.type == ZOXXCardTypeShanBi) {
                        ocard.userInteractionEnabled = YES;
                    }else{
                        ocard.userInteractionEnabled = NO;
                    }
                }
                //对方行动
                _noUseBtn.userInteractionEnabled = YES;
            }else{
                if (self.wanjia.gongji > self.laoda.fangyu) {
                    ZOXXCard * card = [self _laodaLookupCardType:ZOXXCardTypeGeDang];
                    if (card) {
                        [self _laodaUserCard:card andWanjia:YES andNeedRespond:NO];
                        break;
                    }
                    card = [self _laodaLookupCardType:ZOXXCardTypeShanBi];
                    if (card) {
                        [self _laodaUserCard:card andWanjia:YES andNeedRespond:NO];
                        break;
                    }
                }
                //没有牌可用
                [self enterJieSuanState:cardType isUseCard:NO];
            }
        }
            break;
        case ZOXXCardTypeJiNeng:
        {
            //进入对方流程
            if (![self inMyTurn]) {
                self.laoda.neili -= 1;
                [self _huiLan:self.laoda];
                
                for (ZOXXCard *ocard in self.wanjia.shoupaiArray) {
                    if (ocard.cardData.type == ZOXXCardTypeShanBi) {
                        ocard.userInteractionEnabled = YES;
                    }else{
                        ocard.userInteractionEnabled = NO;
                    }
                }
                //对方行动
                _noUseBtn.userInteractionEnabled = YES;
            }else{
                self.wanjia.neili -= 1;
                [self _huiLan:self.wanjia];
                
                if (self.wanjia.gongji > self.laoda.fangyu) {
                    ZOXXCard * card = [self _laodaLookupCardType:ZOXXCardTypeShanBi];
                    if (card) {
                        [self _laodaUserCard:card andWanjia:YES andNeedRespond:NO];
                        break;
                    }
                }
                //没有牌可用
                [self enterJieSuanState:cardType isUseCard:NO];
            }
        }
            break;
        default:
            break;
    }
    
}

- (void)enterJieSuanState:(ZOXXCardType)cardType isUseCard:(BOOL)use{
    ZOXXPlayer * player = nil;
    if ([self inMyTurn]) {
        player = self.laoda;
    }else{
        player = self.wanjia;
    }
    switch (cardType) {
        case ZOXXCardTypePingA:
        {
            if (!use) {
                BOOL flag = NO;
                if ([self inMyTurn]) {
                    if (self.wanjia.gongji > self.laoda.fangyu) {
                        self.laoda.shengming -= (self.wanjia.gongji - self.laoda.fangyu);
                        self.laoda.shengming = self.laoda.shengming > 0 ? self.laoda.shengming : 0;
                        [self _kouxue:self.laoda];
                        flag = YES;
                    }
                }else{
                    if (self.laoda.gongji > self.wanjia.fangyu) {
                        self.wanjia.shengming -= (self.laoda.gongji - self.wanjia.fangyu);
                        self.wanjia.shengming = self.wanjia.shengming > 0 ? self.wanjia.shengming : 0;
                        [self _kouxue:self.wanjia];
                        flag = YES;
                    }
                }
                if (flag) {
                    SKAction *action;
                    if (player == self.wanjia) {
                        action = [SKAction actionNamed:@"WanJiaHeadImageAction"];
                    }else{
                        action = [SKAction actionNamed:@"LaoDaHeadImageAction"];
                    }
                    [player.headerImageNode runAction:action];
                }
            }
            if (self.wanjia.shengming == 0 || self.laoda.shengming == 0) {
                break;
            }
            [self enterUseCard];
        }
            break;
        case ZOXXCardTypeJiNeng:
        {
            if (!use) {
                BOOL flag = NO;
                if ([self inMyTurn]) {
                    if (self.wanjia.gongji > self.laoda.fangyu) {
                        self.laoda.shengming -= (self.wanjia.gongji - self.laoda.fangyu);
                        self.laoda.shengming = self.laoda.shengming > 0 ? self.laoda.shengming : 0;
                        [self _kouxue:self.laoda];
                        flag = YES;
                    }
                }else{
                    if (self.laoda.gongji > self.wanjia.fangyu) {
                        self.wanjia.shengming -= (self.laoda.gongji - self.wanjia.fangyu);
                        self.wanjia.shengming = self.wanjia.shengming > 0 ? self.wanjia.shengming : 0;
                        [self _kouxue:self.wanjia];
                        flag = YES;
                    }
                }
                if (flag) {
                    SKAction *action;
                    if (player == self.wanjia) {
                        action = [SKAction actionNamed:@"WanJiaHeadImageAction"];
                    }else{
                        action = [SKAction actionNamed:@"LaoDaHeadImageAction"];
                    }
                    [player.headerImageNode runAction:action];
                }
            }
            if (self.wanjia.shengming == 0 || self.laoda.shengming == 0) {
                break;
            }
            [self enterUseCard];
        }
            break;
        default:
            break;
    }
    NSLog(@"现在%@生命 -- %d",player.name,player.shengming);
    if (self.wanjia.shengming == 0) {
        if (self.endGame) {
            self.endGame();
            [ZOXXSaveData sharedPlayer].diyiciwan = NO;
            [ZOXXSaveData baocunwanjiashuju:[ZOXXSaveData sharedPlayer]];
        }
        [ZOXXLogPlayer write2Caches:@"败给电脑人"];
        //弹窗提示
        ZOXXAlertViewController *weic = [[ZOXXAlertViewController alloc] initWithTitle:@"你输了!" andLeftBtnTxt:@"重新开始" andRightBtnTxt:@"返回" andLeftBlock:^{
            SKView *skView = (SKView *)self.scene.view;
            ZOXXMainScene *scene = (ZOXXMainScene *)[SKScene nodeWithFileNamed:@"ZOXXMainSceneView"];
            scene.scaleMode = SKSceneScaleModeFill;
            [skView presentScene:scene];
        } andRightBlock:^{
            GameViewController *rootViewController = (GameViewController *)[UIApplication sharedApplication].delegate.window.rootViewController;
            ZOXXBeginSceneFirst *scene = (ZOXXBeginSceneFirst *)[SKScene nodeWithFileNamed:@"ZOXXBeginSceneFirst"];
            scene.bsfd_delegate = rootViewController;
            scene.scaleMode = SKSceneScaleModeFill;
            SKView *skView = (SKView *)self.scene.view;
            SKTransition *tr = [SKTransition moveInWithDirection:SKTransitionDirectionLeft duration:0.25];
            [skView presentScene:scene transition:tr];
        }];
        [[UIApplication sharedApplication].delegate.window.rootViewController presentViewController:weic animated:NO completion:nil];
        return;
    }
    if (self.laoda.shengming == 0) {
        if (self.endGame) {
            self.endGame();
            [ZOXXSaveData sharedPlayer].diyiciwan = NO;
            [ZOXXSaveData baocunwanjiashuju:[ZOXXSaveData sharedPlayer]];
        }
        [ZOXXSaveData sharedPlayer].money += 10;
        [ZOXXSaveData baocunwanjiashuju:[ZOXXSaveData sharedPlayer]];
        //弹窗提示
        [ZOXXLogPlayer write2Caches:@"赢了电脑人,金币+10"];
        ZOXXAlertViewController *weic = [[ZOXXAlertViewController alloc] initWithTitle:@"你赢了!\n金币 +10" andLeftBtnTxt:@"选择关卡" andRightBtnTxt:@"返回" andLeftBlock:^{
            SKView *skView = (SKView *)self.scene.view;
            ZOXXSelectLevelScene *scene = (ZOXXSelectLevelScene *)[SKScene nodeWithFileNamed:@"ZOXXSelectLevelScene"];
            scene.scaleMode = SKSceneScaleModeFill;
            [skView presentScene:scene];
        } andRightBlock:^{
            GameViewController *rootViewController = (GameViewController *)[UIApplication sharedApplication].delegate.window.rootViewController;
            ZOXXBeginSceneFirst *scene = (ZOXXBeginSceneFirst *)[SKScene nodeWithFileNamed:@"ZOXXBeginSceneFirst"];
            scene.bsfd_delegate = rootViewController;
            scene.scaleMode = SKSceneScaleModeFill;
            SKView *skView = (SKView *)self.scene.view;
            SKTransition *tr = [SKTransition moveInWithDirection:SKTransitionDirectionLeft duration:0.25];
            [skView presentScene:scene transition:tr];
        }];
        [[UIApplication sharedApplication].delegate.window.rootViewController presentViewController:weic animated:NO completion:nil];
    }
}

- (void)showDesktop{
    _useCardShowNode.hidden = NO;
}

#pragma mark - ZOXXSpriteButtonDelegate
- (void)ZOXXSpriteButtonClick:(ZOXXSpriteButton *)btn{
    if (btn == _noUseBtn) {
        
        for (ZOXXCard *obj in self.wanjia.shoupaiArray) {
           obj.isSelected = NO;
        }
        
        if (!self.isMyTurn) {
            [self enterJieSuanState:_currentLaoDaUseCard.cardData.type isUseCard:NO];
        }else{
            self.isMyTurn = NO;
            for (ZOXXCard *card in self.wanjia.shoupaiArray) {
                card.userInteractionEnabled = NO;
            }
            [self enterDrawCardWithNum:2 complish:^{
                [self enterUseCard];
            }];
        }
    }
    if (btn == _useBtn) {
        
        for (ZOXXCard *obj in self.wanjia.shoupaiArray) {
            obj.userInteractionEnabled = NO;
        }
        
        if (!self.isMyTurn) {
            //一个使用的动画
            [self _useCard:_currentUseCard andNeedRespond:NO];
        }else{
            [self _useCard:_currentUseCard andNeedRespond:YES];
        }
    }
}

#pragma mark - ZOXXCardDelegate
- (void)ZOXXCardClick:(ZOXXCard *)card{
    
    for (ZOXXCard *obj in self.wanjia.shoupaiArray) {
        if (obj != card) {
            obj.isSelected = NO;
        }
    }
    
    if (!self.isMyTurn) {
        _currentUseCard = card;
        if ([self.wanjia canSelectedCard] && card.isSelected) {
            _useBtn.userInteractionEnabled = YES;
        }else{
            _useBtn.userInteractionEnabled = NO;
        }
    }else{
        _currentUseCard = nil;
        if (card.isSelected) {
            _currentUseCard = card;
        }
        _useBtn.userInteractionEnabled = _currentUseCard ? YES : NO;
    }
    
}

#pragma mark - private game methods
- (NSArray *)_cardTypeArray{
    return @[
        [NSNumber numberWithInteger:ZOXXCardTypePingA],
        [NSNumber numberWithInteger:ZOXXCardTypePingA],
        [NSNumber numberWithInteger:ZOXXCardTypePingA],
        [NSNumber numberWithInteger:ZOXXCardTypeJiNeng],
        [NSNumber numberWithInteger:ZOXXCardTypeShanBi],
        [NSNumber numberWithInteger:ZOXXCardTypeGeDang],
        [NSNumber numberWithInteger:ZOXXCardTypeMingXiang],
        [NSNumber numberWithInteger:ZOXXCardTypeBingQi],
        [NSNumber numberWithInteger:ZOXXCardTypeFuShi]
    ];
}

- (ZOXXCardData *)_createCardData{
    int index = arc4random() % [self _cardTypeArray].count;
    NSNumber *cardType = [self _cardTypeArray][index];
    ZOXXCardData *cardData = [ZOXXCardData createWithType:(ZOXXCardType)cardType.integerValue];
    return cardData;
}

- (void)_layoutCardWithWanJia:(BOOL)wanjia completion:(void (^)(void))finishedBlock{
    NSArray *array = self.laoda.shoupaiArray;
    SKNode *node = _laodashoupaiNode;
    if (wanjia) {
        array = self.wanjia.shoupaiArray;
        node = _wanjiashoupaiNode;
    }

    CGFloat screenWidth = self.scene.size.width;
    CGFloat space = [node.parent convertPoint:node.position fromNode:self.scene].x;
    space += screenWidth/2;
    CGFloat realWidth = array.count * (CardSize.width + 5) - 5;
    CGFloat maxX = screenWidth - 2 * space;
    if (realWidth > maxX) {
        NSLog(@"出去了");
        //重新排序
        for (int i = 0; i < array.count; i ++) {
            ZOXXCard *card = array[i];
            if (i == 0) {
                [card runAction:[SKAction moveToX:(maxX/array.count)* i duration:0.5]];
            }else{
                [card runAction:[SKAction moveToX:((maxX/array.count)* i - (CardSize.width - maxX/array.count)) duration:0.5]];
            }
        }
    }else{
        NSLog(@"在里面了");
        for (int i = 0; i < array.count; i ++) {
            ZOXXCard *card = array[i];
            [card runAction:[SKAction moveToX:(CardSize.width + 5)* i duration:0.5]];
        }
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        if (self.isMyTurn) {
            [self _jihuoWanJiaShouPai];
        }
        
        if ([ZOXXSaveData sharedPlayer].diyiciwan) {
            [((ZOXXMainScene *)self.scene) show1];
        }
        for (ZOXXCard *card in self.wanjia.shoupaiArray) {
            card.origin = card.position;
        }
        for (ZOXXCard *card in self.laoda.shoupaiArray) {
            card.origin = card.position;
        }
        if (finishedBlock) {
            finishedBlock();
        }
    });
}

- (void)_jihuoWanJiaShouPai{
    if ([self inMyTurn]) {
        for (ZOXXCard *card in self.wanjia.shoupaiArray) {
            if (card.cardData.type == ZOXXCardTypeGeDang ||
                card.cardData.type == ZOXXCardTypeShanBi ||
                (card.cardData.type == ZOXXCardTypeJiNeng && self.wanjia.neili == 0) ||
                (card.cardData.type == ZOXXCardTypeMingXiang && self.wanjia.neili == self.wanjia.neilishangxian)) {
                card.userInteractionEnabled = NO;
                continue;
            }
            card.userInteractionEnabled = YES;
        }
    }else{
        for (ZOXXCard *card in self.wanjia.shoupaiArray) {
            card.userInteractionEnabled = NO;
        }
    }
}

- (void)_useCard:(ZOXXCard *)card andNeedRespond:(BOOL)needRespond{
    _useBtn.userInteractionEnabled = NO;
    _noUseBtn.userInteractionEnabled = NO;
    
    for (ZOXXCard *obj in self.wanjia.shoupaiArray) {
        obj.userInteractionEnabled = NO;
    }
    
    //执行动画
    CGPoint point = [card.parent convertPoint:_useCardShowNode.position fromNode:_useCardShowNode.parent];
    point.x -= CardSize.width/2;
    point.y -= CardSize.height/2;
    [card runAction:[SKAction moveTo:point duration:0.5] completion:^{
        //把内容交给当前节点
        ZOXXCard *cardShow = (ZOXXCard *)[self->_useCardShowNode.children firstObject];
        cardShow.cardData = card.cardData;
        NSLog(@"%@",cardShow.cardData.descriptionString);
        
        //移除节点
        [card removeFromParent];
        [self.wanjia.shoupaiArray removeObject:card];
        
        //调用重新布局方法
        [self _layoutCardWithWanJia:YES completion:^{
            if (needRespond) {
                //调用响应阶段
                [self enterResponseState:card.cardData.type];
            }else{
                [self enterUseCard];
            }
        }];
    }];
}

- (void)_kouxue:(ZOXXPlayer *)player{
    if (player == self.laoda) {
        CGFloat s = self.laoda.shengming * 1.0 / self.laoda.shengmingshangxian;
        CGFloat width = _LaoDaXueTiaoBG.size.width / _LaoDaXueTiaoBG.xScale * s;
        [_LaoDaXueTiao runAction:[SKAction resizeToWidth:width duration:0.25]];
        
//        _LaoDaXueTiao.size = CGSizeMake(width, _LaoDaXueTiaoBG.size.height);
        _LaoDaXueTiaoNum.text = [NSString stringWithFormat:@"%ld/%ld",self.laoda.shengming,self.laoda.shengmingshangxian];
        [_LaoDaXueTiaoNum runAction:[SKAction actionNamed:@"TextEffectScale"]];
        
    }else{
        CGFloat s = self.wanjia.shengming * 1.0 / self.wanjia.shengmingshangxian;
        CGFloat width = _WanJiaXueTiaoBG.size.width / _WanJiaXueTiaoBG.xScale * s;
        [_WanJiaXueTiao runAction:[SKAction resizeToWidth:width duration:0.25]];

//        _WanJiaXueTiao.size = CGSizeMake(width, _WanJiaXueTiaoBG.size.height);
        _WanJiaXueTiaoNum.text = [NSString stringWithFormat:@"%ld/%ld",self.wanjia.shengming,self.wanjia.shengmingshangxian];
        [_WanJiaXueTiaoNum runAction:[SKAction actionNamed:@"TextEffectScale"]];
    }
}

- (void)_huiLan:(ZOXXPlayer *)player{
    if (player == self.laoda) {
        CGFloat s = self.laoda.neili * 1.0 / self.laoda.neilishangxian;
        CGFloat width = _LaoDaLanTiaoBG.size.width * s;
        [_LaoDaLanTiao runAction:[SKAction resizeToWidth:width duration:0.25]];
//        _LaoDaLanTiao.size = CGSizeMake(width, _LaoDaLanTiaoBG.size.height);
        
        _LaoDaLanTiaoNum.text = [NSString stringWithFormat:@"%ld/%ld",self.laoda.neili,self.laoda.neilishangxian];
        [_LaoDaLanTiaoNum runAction:[SKAction actionNamed:@"TextEffectScale"]];
    }else{
        CGFloat s = self.wanjia.neili * 1.0 / self.wanjia.neilishangxian;
        CGFloat width = _WanJiaLanTiaoBG.size.width * s;
        [_WanJiaLanTiao runAction:[SKAction resizeToWidth:width duration:0.25]];
//        _WanJiaLanTiao.size = CGSizeMake(width, _WanJiaLanTiaoBG.size.height);
        _WanJiaLanTiaoNum.text = [NSString stringWithFormat:@"%ld/%ld",self.wanjia.neili,self.wanjia.neilishangxian];
        [_WanJiaLanTiaoNum runAction:[SKAction actionNamed:@"TextEffectScale"]];
    }
}

- (void)_jiagongji:(ZOXXPlayer *)player{
    if (player == self.laoda) {
        _LaoDaGongJi.text = [NSString stringWithFormat:@"%ld",self.laoda.gongji];
        [_LaoDaGongJi runAction:[SKAction actionNamed:@"TextEffectScale"]];
    }else{
        _WanJiaGongJi.text = [NSString stringWithFormat:@"%ld",self.wanjia.gongji];
        [_WanJiaGongJi runAction:[SKAction actionNamed:@"TextEffectScale"]];
    }
}

- (void)_jiafangyu:(ZOXXPlayer *)player{
    if (player == self.laoda) {
        _LaoDaFangYu.text = [NSString stringWithFormat:@"%ld",self.laoda.fangyu];
        [_LaoDaFangYu runAction:[SKAction actionNamed:@"TextEffectScale"]];
    }else{
        _WanJiaFangYu.text = [NSString stringWithFormat:@"%ld",self.wanjia.fangyu];
        [_WanJiaFangYu runAction:[SKAction actionNamed:@"TextEffectScale"]];
    }
}

#pragma mark - 电脑人的行为
//电脑弟弟找牌行为
- (ZOXXCard *)_laodaLookupCardType:(ZOXXCardType)cardType{
    for (ZOXXCard *card in self.laoda.shoupaiArray) {
        if (card.cardData.type == cardType) {
            return card;
        }
    }
    return nil;
}

//用牌行为
- (void)_laodaUserCard:(ZOXXCard *)card andWanjia:(BOOL)wanjia andNeedRespond:(BOOL)needRespond{
    //执行动画
    if (wanjia) {
        _currentUseCard = card;
    }else{
        _currentLaoDaUseCard = card;
    }
    
    CGPoint point = [card.parent convertPoint:_useCardShowNode.position fromNode:_useCardShowNode.parent];
    point.x -= CardSize.width/2;
    point.y += CardSize.height/2;
    [card runAction:[SKAction moveTo:point duration:0.5] completion:^{
        //把内容交给当前节点
        ZOXXCard *cardShow = (ZOXXCard *)[self->_useCardShowNode.children firstObject];
        cardShow.cardData = card.cardData;
        NSLog(@"%@",cardShow.cardData.descriptionString);
        
        //移除节点
        [card removeFromParent];
        [self.laoda.shoupaiArray removeObject:card];

        //调用重新布局方法
        [self _layoutCardWithWanJia:NO completion:^{
            if (needRespond) {
                //调用响应阶段
                [self enterResponseState:card.cardData.type];
            }
        }];
    }];
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

@end
