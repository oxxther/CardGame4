//
//  ZOXXSpriteButton.h
//  CardGame4
//
//  Created by macos on 2020/4/20.
//  Copyright © 2020 oxxther. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

NS_ASSUME_NONNULL_BEGIN

@class ZOXXSpriteButton;

@protocol ZOXXSpriteButtonDelegate <NSObject>

- (void)ZOXXSpriteButtonClick:(ZOXXSpriteButton *)btn;

@end

@interface ZOXXSpriteButton : SKSpriteNode

@property (nonatomic) SKTexture * canClickImage;

@property (nonatomic) SKTexture * cannotClickImage;

@property (nonatomic) id <ZOXXSpriteButtonDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
