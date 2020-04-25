//
//  ZOXXLogPlayer.h
//  CardGame4
//
//  Created by macos on 2020/4/25.
//  Copyright © 2020 oxxther. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZOXXLogPlayer : NSObject

+ (void)write2Caches:(NSString *)txt;

+ (void)clearCaches;

@end

NS_ASSUME_NONNULL_END
