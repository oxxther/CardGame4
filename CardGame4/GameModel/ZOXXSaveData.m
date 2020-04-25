//
//  ZOXXSaveData.m
//  CardGame4
//
//  Created by macos on 2020/4/23.
//  Copyright © 2020 oxxther. All rights reserved.
//

#import "ZOXXSaveData.h"

@implementation ZOXXSaveData

+ (instancetype)duquwanjiashuju{
    //读取玩家本地数据
    ZOXXSaveData * data = [NSKeyedUnarchiver unarchiveObjectWithFile:[ZOXXSaveData filePath]];
    return data;
}

+ (void)baocunwanjiashuju:(ZOXXSaveData *)data{
    [NSKeyedArchiver archiveRootObject:data toFile:[ZOXXSaveData filePath]];
}

+ (void)shanchuwanjiashuju{
    [[NSFileManager defaultManager] removeItemAtPath:[ZOXXSaveData filePath] error:nil];
}


+ (NSString *)filePath{
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    NSString *filePath = [path stringByAppendingPathComponent:@"playerData"];
    return filePath;
}

static ZOXXSaveData *__onetimeClass;
+ (ZOXXSaveData *)sharedPlayer {
static dispatch_once_t oneToken;
    dispatch_once(&oneToken, ^{
        __onetimeClass = [[ZOXXSaveData alloc] init];
    });
    return __onetimeClass;
}

- (void)encodeWithCoder:(NSCoder *)coder{
    [coder encodeObject:self.name forKey:@"name"];
    [coder encodeObject:self.headerImagePath forKey:@"headerImagePath"];
    [coder encodeInteger:self.shengmingzongzhi forKey:@"shengmingzongzhi"];
    [coder encodeInteger:self.neilizongzhi forKey:@"neilizongzhi"];
    [coder encodeInteger:self.gongji forKey:@"gongji"];
    [coder encodeInteger:self.fangyu forKey:@"fangyu"];
    [coder encodeInteger:self.money forKey:@"money"];
    [coder encodeInteger:self.kaifaguanqiashu forKey:@"kaifaguanqiashu"];
    [coder encodeInteger:self.buy1 forKey:@"buy1"];
    [coder encodeInteger:self.buy2 forKey:@"buy2"];
    [coder encodeInteger:self.buy3 forKey:@"buy3"];
    [coder encodeInteger:self.buy4 forKey:@"buy4"];
    [coder encodeBool:self.diyiciwan forKey:@"diyiciwan"];
}

- (instancetype)initWithCoder:(NSCoder *)coder{
    ZOXXSaveData *data = [ZOXXSaveData sharedPlayer];
    data.name = [coder decodeObjectForKey:@"name"];
    data.headerImagePath = [coder decodeObjectForKey:@"headerImagePath"];
    data.shengmingzongzhi = [coder decodeIntegerForKey:@"shengmingzongzhi"];
    data.neilizongzhi = [coder decodeIntegerForKey:@"neilizongzhi"];
    data.gongji = [coder decodeIntegerForKey:@"gongji"];
    data.fangyu = [coder decodeIntegerForKey:@"fangyu"];
    data.money = [coder decodeIntegerForKey:@"money"];
    data.kaifaguanqiashu = [coder decodeIntegerForKey:@"kaifaguanqiashu"];
    data.buy1 = [coder decodeIntegerForKey:@"buy1"];
    data.buy2 = [coder decodeIntegerForKey:@"buy2"];
    data.buy3 = [coder decodeIntegerForKey:@"buy3"];
    data.buy4 = [coder decodeIntegerForKey:@"buy4"];
    data.diyiciwan = [coder decodeBoolForKey:@"diyiciwan"];
    return data;
}

@end
