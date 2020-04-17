//
//  ZOXXPlayer.m
//  CardGame4
//
//  Created by macos on 2020/4/16.
//  Copyright © 2020 oxxther. All rights reserved.
//

#import "ZOXXPlayer.h"

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
        case MenPaiAddressTypeYuNvFeng:
        {
            self.name = @"李清照";
            self.menpaiName = @"花间派";
            self.menpaiAddress = @"玉女峰";
            self.jueji = @[@"三花",@"落英缤纷",@"柳浪闻莺"];
            self.shengming = 4;
            self.neili = 4;
            self.bingqi = @"无";
            self.fushi = @"布衣";
        }
            break;
        case MenPaiAddressTypeWuDangShan:
        {
            self.name = @"清虚道长";
            self.menpaiName = @"太极门";
            self.menpaiAddress = @"武当山";
            self.jueji = @[@"挤字诀",@"震字诀",@"三环套月"];
            self.shengming = 4;
            self.neili = 4;
            self.bingqi = @"无";
            self.fushi = @"布衣";
        }
            break;
        case MenPaiAddressTypeDaXueShan:
        {
            self.name = @"白瑞德";
            self.menpaiName = @"雪山剑派";
            self.menpaiAddress = @"大雪山";
            self.jueji = @[@"冰心诀",@"神倒鬼跌",@"雪花六出"];
            self.menpaiImage = [self getImagePath:@"renWu03.png"];
            self.headerImage = [self getImagePath:@"touXiang03.png"];
            self.shengming = 4;
            self.neili = 4;
            self.bingqi = @"无";
            self.fushi = @"布衣";
        }
            break;
        case MenPaiAddressTypeWuZhiShan:
        {
            self.name = @"余鸿儒";
            self.menpaiName = @"红莲教";
            self.menpaiAddress = @"五指山";
            self.jueji = @[@"普天同济",@"红莲教义",@"流星飞掷"];
            self.shengming = 4;
            self.neili = 4;
            self.bingqi = @"无";
            self.fushi = @"布衣";
        }
            break;
        case MenPaiAddressTypeBingHuoDao:
        {
            self.name = @"和仲阳";
            self.menpaiName = @"伊贺派";
            self.menpaiAddress = @"冰火岛";
            self.jueji = @[@"忍法隐分身",@"忍术烟幕",@"迎风一刀斩",@"旋风三连斩"];
            self.menpaiImage = [self getImagePath:@"renWu05.png"];
            self.headerImage = [self getImagePath:@"touXiang05.png"];
            self.shengming = 4;
            self.neili = 4;
            self.bingqi = @"无";
            self.fushi = @"布衣";
        }
            break;
        case MenPaiAddressTypeShangJiaBao:
        {
            self.name = @"王维扬";
            self.menpaiName = @"八卦门";
            self.menpaiAddress = @"商家堡";
            self.jueji = @[@"化掌为刀",@"八卦刀影掌",@"八阵刀影掌"];
            self.shengming = 4;
            self.neili = 4;
            self.bingqi = @"无";
            self.fushi = @"布衣";
        }
            break;
        case MenPaiAddressTypeHeiSenLin:
        {
            self.name = @"娜可露露";
            self.menpaiName = @"兽王派";
            self.menpaiAddress = @"黑森林";
            self.jueji = @[@"变熊术",@"飞鹰召唤",@"变鹰术",@"恶虎啸"];
            self.shengming = 4;
            self.neili = 4;
            self.bingqi = @"无";
            self.fushi = @"布衣";
        }
            break;
        default:
            break;
    }
}

- (BOOL)hasBingQi{
    return YES;
}

- (BOOL)hasFuShi{
    return YES;
}

- (BOOL)isFullBlood{
    return NO;
}

#pragma mark - private
- (NSString *)getImagePath:(NSString *)imageName{
    return [[NSBundle mainBundle].bundlePath stringByAppendingPathComponent:imageName];
}

@end
