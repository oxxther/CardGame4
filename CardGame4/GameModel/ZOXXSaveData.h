//
//  ZOXXSaveData.h
//  CardGame4
//
//  Created by macos on 2020/4/23.
//  Copyright © 2020 oxxther. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZOXXSaveData : NSObject<NSCoding>

@property (nonatomic) NSString * name;

@property (nonatomic) NSString * headerImagePath;

@property (nonatomic) NSInteger shengmingzongzhi;

@property (nonatomic) NSInteger neilizongzhi;

@property (nonatomic) NSInteger gongji;

@property (nonatomic) NSInteger fangyu;

@property (nonatomic) NSInteger money;

@property (nonatomic) NSInteger kaifaguanqiashu;

@property (nonatomic) NSInteger currentgk;

@property (nonatomic) NSInteger buy1;

@property (nonatomic) NSInteger buy2;

@property (nonatomic) NSInteger buy3;

@property (nonatomic) NSInteger buy4;

@property (nonatomic) BOOL diyiciwan;

+ (instancetype)duquwanjiashuju;

+ (void)baocunwanjiashuju:(ZOXXSaveData *)data;

+ (void)shanchuwanjiashuju;

+ (instancetype)sharedPlayer;

@end

NS_ASSUME_NONNULL_END
