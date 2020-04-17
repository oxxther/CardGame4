//
//  ZOXXBeginSceneFirst.h
//  CardGame4
//
//  Created by macos on 2020/4/14.
//  Copyright © 2020 oxxther. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol ZOXXBeginSceneFirstDelegate <NSObject>

- (void)ZOXXBeginSceneFirstDidClickSGNode;
- (void)ZOXXBeginSceneFirstDidClickPDNode;
- (void)ZOXXBeginSceneFirstDidClickNGNode;
- (void)ZOXXBeginSceneFirstDidClickSPNode;

@end

@interface ZOXXBeginSceneFirst : SKScene

@property (nonatomic, weak) id <ZOXXBeginSceneFirstDelegate> bsfd_delegate;

@end

NS_ASSUME_NONNULL_END
