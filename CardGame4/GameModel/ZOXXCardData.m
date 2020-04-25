//
//  ZOXXCardData.m
//  CardGame4
//
//  Created by macos on 2020/4/16.
//  Copyright © 2020 oxxther. All rights reserved.
//

#import "ZOXXCardData.h"

@implementation ZOXXCardData

+ (instancetype)createWithType:(ZOXXCardType)type{
    ZOXXCardData *cardData = [[ZOXXCardData alloc] init];
    cardData.type = type;
    return cardData;
}

#pragma mark - setter
- (void)setType:(ZOXXCardType)type{
    _type = type;
    
    //给不同的卡一个描述
    switch (type) {
        case ZOXXCardTypePingA:
        {
            self.descriptionString = @"普通攻击";
            self.name = @"普攻";
            self.imagePath = [self getImagePath:@"MainPage9.png"];
        }
            break;
        case ZOXXCardTypeJiNeng:
        {
            self.descriptionString = @"技能攻击";
            self.name = @"技能";
            self.imagePath = [self getImagePath:@"MainPage3.png"];
        }
            break;
        case ZOXXCardTypeShanBi:
        {
            self.descriptionString = @"此牌可抵消敌人的攻击";
            self.name = @"闪避";
            self.imagePath = [self getImagePath:@"MainPage5.png"];
        }
            break;
        case ZOXXCardTypeGeDang:
        {
            self.descriptionString = @"此牌可抵消敌人的普攻";
            self.name = @"格挡";
            self.imagePath = [self getImagePath:@"MainPage6.png"];
        }
            break;
        case ZOXXCardTypeMingXiang:
        {
            self.descriptionString = @"此牌回复1点蓝";
            self.name = @"冥想";
            self.imagePath = [self getImagePath:@"MainPage7.png"];
        }
            break;
        case ZOXXCardTypeBingQi:
        {
            self.descriptionString = @"此牌永久增加攻击1。";
            self.name = @"加攻击";
            self.imagePath = [self getImagePath:@"MainPage4.png"];
        }
            break;
        case ZOXXCardTypeFuShi:
        {
            self.descriptionString = @"此牌永久增加防御1";
            self.name = @"加防御";
            self.imagePath = [self getImagePath:@"MainPage8.png"];
        }
            break;
    }
}

#pragma mark - private
- (NSString *)getImagePath:(NSString *)imageName{
    return [[NSBundle mainBundle].bundlePath stringByAppendingPathComponent:imageName];
}

@end
