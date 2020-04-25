//
//  ZOXXCard.h
//  CardGame4
//
//  Created by macos on 2020/4/16.
//  Copyright © 2020 oxxther. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "ZOXXCardData.h"

#define CardSize CGSizeMake(118.5,163.5)


NS_ASSUME_NONNULL_BEGIN

@class ZOXXCard;

@protocol ZOXXCardDelegate <NSObject>

- (void)ZOXXCardClick:(ZOXXCard *)card;

@end

typedef NS_ENUM(NSUInteger, ZOXXCardLabelType) {
    ZOXXCardLabelTypeLaoDa = 0,
    ZOXXCardLabelTypeWanJia = 1,
    ZOXXCardLabelTypeCenter = 2,
};

@interface ZOXXCard : SKSpriteNode

@property (nonatomic) ZOXXCardData *cardData;

@property (nonatomic) BOOL isSelected;

@property (nonatomic) CGPoint origin;
 
@property (nonatomic, weak) id <ZOXXCardDelegate> delegate;

- (instancetype)initWithDelegate:(id <ZOXXCardDelegate>)delegate andTag:(ZOXXCardLabelType)labelType;

@end

NS_ASSUME_NONNULL_END
