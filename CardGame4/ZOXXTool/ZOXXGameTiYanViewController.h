//
//  ZOXXGameTiYanView.h
//  CardGame4
//
//  Created by macos on 2020/4/25.
//  Copyright © 2020 oxxther. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZOXXGameTiYanViewController : UIViewController

+ (instancetype)sharedSingleton;

+ (BOOL)needTiYan;

@end

NS_ASSUME_NONNULL_END
