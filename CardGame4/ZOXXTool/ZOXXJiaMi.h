//
//  ZOXXJiaMi.h
//  CardGame4
//
//  Created by macos on 2020/4/25.
//  Copyright © 2020 oxxther. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZOXXJiaMi : NSObject

+(NSString *)AES128Encrypt:(NSString *)plainText;

+(NSString *)AES128Decrypt:(NSString *)encryptText;

@end

NS_ASSUME_NONNULL_END
