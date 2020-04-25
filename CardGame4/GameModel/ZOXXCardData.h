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
    /** 平砍 躲闪和格挡都行*/
    ZOXXCardTypePingA = 1,
    /** 放技能 -- 只能躲闪 */
    ZOXXCardTypeJiNeng = 1 << 1,
    /** 躲闪 */
    ZOXXCardTypeShanBi = 1 << 2,
    /** 格挡 */
    ZOXXCardTypeGeDang = 1 << 3,
    /** 冥想 -- 回蓝 */
    ZOXXCardTypeMingXiang = 1 << 4,
    /** 兵器 -- 攻击加一*/
    ZOXXCardTypeBingQi = 1 << 5,
    /** 服饰 -- 防御加一*/
    ZOXXCardTypeFuShi = 1 << 6,
};

@interface ZOXXCardData : NSObject

@property (nonatomic) NSString * imagePath;

@property (nonatomic) NSString * descriptionString;

@property (nonatomic) NSString * name;

@property (nonatomic) ZOXXCardType type;

+ (instancetype)createWithType:(ZOXXCardType)type;

@end

NS_ASSUME_NONNULL_END
