//
//  ZOXXAlertViewController.h
//  CardGame4
//
//  Created by macos on 2020/4/14.
//  Copyright © 2020 oxxther. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZOXXAlertViewController : UIViewController

- (instancetype)initWithTitle:(NSString *)title andLeftBtnTxt:(NSString *)ltxt andRightBtnTxt:(NSString *)rtxt andLeftBlock:(void (^)(void))leftBlock andRightBlock:(void (^)(void))rightBlock;

@end

NS_ASSUME_NONNULL_END
