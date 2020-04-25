//
//  ZOXXPlayer.m
//  CardGame4
//
//  Created by macos on 2020/4/16.
//  Copyright © 2020 oxxther. All rights reserved.
//

#import "ZOXXPlayer.h"
#import "ZOXXSaveData.h"

@implementation ZOXXPlayer

+ (instancetype)createWithType:(MenPaiAddressType)type{
    ZOXXPlayer *player = [[ZOXXPlayer alloc] init];
    player.type = type;
    return player;
}

#pragma mark - setter

- (void)setType:(MenPaiAddressType)type{
    _type = type;
    
    switch (type) {
        case MenPaiAddressTypeErCiYueAiHaoZhe:
        {
            self.name = [ZOXXSaveData sharedPlayer].name;
            self.shengmingshangxian = [ZOXXSaveData sharedPlayer].shengmingzongzhi;
            self.neilishangxian = [ZOXXSaveData sharedPlayer].neilizongzhi;
            self.shengming = self.shengmingshangxian;
            self.neili = 0;
            self.gongji = [ZOXXSaveData sharedPlayer].gongji;
            self.fangyu = [ZOXXSaveData sharedPlayer].fangyu;
            self.headerImage = [self getImagePath:@"PlayerHeader0.png"];
        }
            break;
        case MenPaiAddressTypeXianZongLin:
        {
            self.name = @"科加森";
            self.shengmingshangxian = 4;
            self.neilishangxian = 4;
            self.shengming = self.shengmingshangxian;
            self.neili = 0;
            self.gongji = 2;
            self.fangyu = 1;
            self.headerImage = [self getImagePath:@"PlayerHeader1.png"];
        }
            break;
        case MenPaiAddressTypeYongZheDaLu:
        {
            self.name = @"卡尔玛";
            self.shengmingshangxian = 5;
            self.neilishangxian = 5;
            self.shengming = self.shengmingshangxian;
            self.neili = 0;
            self.gongji = 2;
            self.fangyu = 1;
            self.headerImage = [self getImagePath:@"PlayerHeader2.png"];
        }
            break;
        case MenPaiAddressTypeShiLuoZhiTa:
        {
            self.name = @"凯特琳";
            self.shengmingshangxian = 6;
            self.neilishangxian = 6;
            self.shengming = self.shengmingshangxian;
            self.neili = 0;
            self.gongji = 3;
            self.fangyu = 2;
            self.headerImage = [self getImagePath:@"PlayerHeader3.png"];
        }
            break;
        case MenPaiAddressTypeYaTeLanDiSi:
        {
            self.name = @"辛吉德";
            self.shengmingshangxian = 7;
            self.neilishangxian = 7;
            self.shengming = self.shengmingshangxian;
            self.neili = 0;
            self.gongji = 4;
            self.fangyu = 3;
            self.headerImage = [self getImagePath:@"PlayerHeader4.png"];
        }
            break;
        case MenPaiAddressTypeSiWangShaMo:
        {
            self.name = @"德鲁伊";
            self.shengmingshangxian = 8;
            self.neilishangxian = 8;
            self.shengming = self.shengmingshangxian;
            self.neili = 0;
            self.gongji = 5;
            self.fangyu = 4;
            self.headerImage = [self getImagePath:@"PlayerHeader5.png"];
        }
            break;
        case MenPaiAddressTypeTianKongZhiCheng:
        {
            self.name = @"娜可露露";
            self.shengmingshangxian = 9;
            self.neilishangxian = 9;
            self.shengming = self.shengmingshangxian;
            self.neili = 0;
            self.gongji = 6;
            self.fangyu = 5;
            self.headerImage = [self getImagePath:@"PlayerHeader6.png"];
        }
            break;
        case MenPaiAddressTypeLuoLanXiaGu:
        {
            self.name = @"罗兰度";
            self.shengmingshangxian = 10;
            self.neilishangxian = 10;
            self.shengming = self.shengmingshangxian;
            self.neili = 0;
            self.gongji = 7;
            self.fangyu = 6;
            self.headerImage = [self getImagePath:@"PlayerHeader7.png"];
        }
            break;
        case MenPaiAddressTypeMoLianZhiDi:
        {
            self.name = @"魔神卡迪姆";
            self.shengmingshangxian = 50;
            self.neilishangxian = 50;
            self.shengming = self.shengmingshangxian;
            self.neili = 0;
            self.gongji = 25;
            self.fangyu = 25;
            self.headerImage = [self getImagePath:@"PlayerHeader8.png"];
        }
            break;
        case MenPaiAddressTypeYouAnSenLin:
        {
            self.name = @"世界神爱豆";
            self.shengmingshangxian = 50;
            self.neilishangxian = 50;
            self.shengming = self.shengmingshangxian;
            self.neili = 0;
            self.gongji = 25;
            self.fangyu = 25;
            self.headerImage = [self getImagePath:@"PlayerHeader9.png"];
        }
            break;
        default:
            break;
    }
}

- (BOOL)canSelectedCard{
    BOOL flag = NO;
    for (ZOXXCard *card in self.shoupaiArray) {
        if (card.userInteractionEnabled) {
            flag = YES;
            break;
        }
    }
    return flag ;
}

#pragma mark - private
- (NSString *)getImagePath:(NSString *)imageName{
    return [[NSBundle mainBundle].bundlePath stringByAppendingPathComponent:imageName];
}

@end
