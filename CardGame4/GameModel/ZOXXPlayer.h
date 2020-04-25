//
//  ZOXXPlayer.h
//  CardGame4
//
//  Created by macos on 2020/4/16.
//  Copyright © 2020 oxxther. All rights reserved.
//

/**
 1.玩家名字
 2.门派
 3.门派地址
 4.玩家绝技
 5.生命
 6.内力
 7.兵器
 8.服饰
 9.手牌
 */

#import <Foundation/Foundation.h>
#import "ZOXXCard.h"
#import <SpriteKit/SpriteKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, MenPaiAddressType) {
    /** 二次元爱好者 */
    MenPaiAddressTypeErCiYueAiHaoZhe = 0,
    /** 仙踪林 */
    MenPaiAddressTypeXianZongLin = 1,
    /** 勇者大陆 */
    MenPaiAddressTypeYongZheDaLu = 2,
    /** 失落之塔 */
    MenPaiAddressTypeShiLuoZhiTa = 3,
    /** 亚特兰蒂斯*/
    MenPaiAddressTypeYaTeLanDiSi = 4,
    /** 死亡沙漠 */
    MenPaiAddressTypeSiWangShaMo = 5,
    /** 天空之城 */
    MenPaiAddressTypeTianKongZhiCheng = 6,
    /** 罗兰峡谷 */
    MenPaiAddressTypeLuoLanXiaGu = 7,
    /** 魔炼之地 */
    MenPaiAddressTypeMoLianZhiDi = 8,
    /** 幽暗森林 */
    MenPaiAddressTypeYouAnSenLin = 9,
};

@interface ZOXXPlayer : NSObject

@property (nonatomic) MenPaiAddressType type;

@property (nonatomic) NSString * name;

@property (nonatomic) NSString * headerImage;

@property (nonatomic) NSInteger shengmingshangxian;

@property (nonatomic) NSInteger neilishangxian;

@property (nonatomic) NSInteger shengming;

@property (nonatomic) NSInteger neili;

@property (nonatomic) NSInteger gongji;

@property (nonatomic) NSInteger fangyu;

@property (nonatomic) NSMutableArray<ZOXXCard *> * shoupaiArray;

@property (nonatomic) SKSpriteNode *headerImageNode;

+ (instancetype)createWithType:(MenPaiAddressType)type;

- (BOOL)canSelectedCard;

@end

NS_ASSUME_NONNULL_END
