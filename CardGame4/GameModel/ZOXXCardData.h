//
//  ZOXXCardData.h
//  CardGame4
//
//  Created by macos on 2020/4/16.
//  Copyright © 2020 oxxther. All rights reserved.
//

/**
 1.需要一个绑定的图片路径
 2.需要一个描述
 3.生成时需要一个类型
 4.给特殊牌一个扩展
 5.功效设定
 */

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, ZOXXCardType) {
    /** 拳攻 */
    ZOXXCardTypeQuanGong = 1,
    /** 兵攻 */
    ZOXXCardTypeBingGong = 1 << 1,
    /** 躲闪 */
    ZOXXCardTypeDuoShan = 1 << 2,
    /** 招架 */
    ZOXXCardTypeZhaoJia = 1 << 3,
    /** 打坐 */
    ZOXXCardTypeDaZuo = 1 << 4,
    /** 吸气 */
    ZOXXCardTypeXiQi = 1 << 5,
    /** 加力 */
    ZOXXCardTypeJiaLi = 1 << 6,
    /** 令牌 */
    ZOXXCardTypeLingpai = 1 << 7,
    /** 兵器 */
    ZOXXCardTypeBingQi = 1 << 8,
    /** 服饰 */
    ZOXXCardTypeFuShi = 1 << 9,
    /** 妙手 */
    ZOXXCardTypeMiaoShou = 1 << 10,
    /** 破防 */
    ZOXXCardTypePoFang = 1 << 11,
    /** 点穴 */
    ZOXXCardTypeDianXue = 1 << 12,
    /** 其他 */
    ZOXXCardTypeOther = 1 << 13,
};

@interface ZOXXCardData : NSObject

@property (nonatomic) NSString * imagePath;

@property (nonatomic) NSString * descriptionString;

@property (nonatomic) ZOXXCardType type;

@property (nonatomic) void (^extendBlock)(void);

+ (instancetype)createWithType:(ZOXXCardType)type;

@end

NS_ASSUME_NONNULL_END
