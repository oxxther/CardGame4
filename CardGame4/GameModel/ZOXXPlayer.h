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

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, MenPaiAddressType) {
    /** 玉女峰 */
    MenPaiAddressTypeYuNvFeng = 0,
    /** 武当山 */
    MenPaiAddressTypeWuDangShan = 1,
    /** 大雪山 */
    MenPaiAddressTypeDaXueShan = 2,
    /** 五指山 */
    MenPaiAddressTypeWuZhiShan = 3,
    /** 冰火岛*/
    MenPaiAddressTypeBingHuoDao = 4,
    /** 商家堡 */
    MenPaiAddressTypeShangJiaBao = 5,
    /** 黑森林 */
    MenPaiAddressTypeHeiSenLin = 6,
};

@interface ZOXXPlayer : NSObject

@property (nonatomic) MenPaiAddressType type;

@property (nonatomic) NSString * name;

@property (nonatomic) NSString * menpaiName;

@property (nonatomic) NSString * menpaiAddress;

@property (nonatomic) NSArray * jueji;

@property (nonatomic) NSString * menpaiImage;

@property (nonatomic) NSString * headerImage;

@property (nonatomic) NSInteger shengming;

@property (nonatomic) NSInteger neili;

@property (nonatomic) NSString * bingqi;

@property (nonatomic) NSString * fushi;

@property (nonatomic) NSMutableArray * shoupaiArray;

@property (nonatomic) BOOL jiali;

@property (nonatomic) BOOL cangongji;

+ (instancetype)createWithType:(MenPaiAddressType)type;

- (BOOL)hasBingQi;

- (BOOL)hasFuShi;

- (BOOL)isFullBlood;

@end

NS_ASSUME_NONNULL_END
