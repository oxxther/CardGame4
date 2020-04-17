//
//  ZOXXCard.m
//  CardGame4
//
//  Created by macos on 2020/4/16.
//  Copyright © 2020 oxxther. All rights reserved.
//

#import "ZOXXCard.h"

@implementation ZOXXCard

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"点击了我%@",self);
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"点击了我%@",self);
}

- (void)setUserInteractionEnabled:(BOOL)userInteractionEnabled{
    [super setUserInteractionEnabled:userInteractionEnabled];
    NSLog(@"放开响应链");
}

@end
