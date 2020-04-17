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
        case ZOXXCardTypeQuanGong:
        {
            self.descriptionString = @"即“拳脚攻击”，此牌可对敌人造成1点伤害。";
        }
            break;
        case ZOXXCardTypeBingGong:
        {
            self.descriptionString = @"即“兵器攻击”，此牌可对敌人造成2点伤害，前提是先要装备上“兵器”。";
        }
            break;
        case ZOXXCardTypeDuoShan:
        {
            self.descriptionString = @"此牌可抵消敌人的“拳攻”、“兵攻”。";
        }
            break;
        case ZOXXCardTypeZhaoJia:
        {
            self.descriptionString = @"此牌可抵消敌人的“拳攻”、“兵攻”（除了“加力”后的攻击）。";
        }
            break;
        case ZOXXCardTypeDaZuo:
        {
            self.descriptionString = @"此牌可增加1点内力。";
        }
            break;
        case ZOXXCardTypeXiQi:
        {
            self.descriptionString = @"此牌会消耗1点内力，同时恢复体力1点。";
        }
            break;
        case ZOXXCardTypeJiaLi:
        {
            self.descriptionString = @"此牌会消耗1点内力，“加力”后的“拳攻”、“兵攻”，对手只能“躲闪”，不能“招架”；同时“加力”后的伤害加1。";
        }
            break;
        case ZOXXCardTypeLingpai:
        {
            self.descriptionString = @"即“门派令牌”，此牌可对敌人造成1点伤害。对手可用“拳攻”或“兵攻”抵消。";
        }
            break;
        case ZOXXCardTypeBingQi:
        {
            self.descriptionString = @"此牌可装备“兵器”；若已装备“兵器”，此牌可重新换取一张新的卡牌。";
        }
            break;
        case ZOXXCardTypeFuShi:
        {
            self.descriptionString = @"此牌可装备“服饰”，体力上限加1，同时一定几率能减缓敌人对你的伤害。若已装备“服饰”，此牌可重新换取一张新的卡牌。";
        }
            break;
        case ZOXXCardTypeMiaoShou:
        {
            self.descriptionString = @"此牌有两种效果可选，1.抽取对手卡牌1张。2.自己获得2张卡牌。";
        }
            break;
        case ZOXXCardTypePoFang:
        {
            self.descriptionString = @"此牌可用来弃置对手的装备1件，“兵器”或“服饰”。";
        }
            break;
        case ZOXXCardTypeDianXue:
        {
            self.descriptionString = @"此牌使用时需作判断，若对手卡牌中没有“打坐”，“点穴”即算成功，对手将无法进行出牌；反之，“点穴”视作失败，自己要损失卡牌1张。";
        }
            break;
        default:
        {
            self.descriptionString = @"另外还有“御剑”、“飞翔”、“烟幕”、“法力”、“分身”、“暗器”等等特殊卡牌，为各门派特有，需玩家自己去发现。";
        }
            break;
    }
}

@end
