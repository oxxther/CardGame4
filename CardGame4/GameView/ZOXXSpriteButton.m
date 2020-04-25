//
//  ZOXXSpriteButton.m
//  CardGame4
//
//  Created by macos on 2020/4/20.
//  Copyright © 2020 oxxther. All rights reserved.
//

#import "ZOXXSpriteButton.h"

@implementation ZOXXSpriteButton

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"点击了我%@",self);
    if (self.delegate && [self.delegate respondsToSelector:@selector(ZOXXSpriteButtonClick:)]) {
        [self.delegate ZOXXSpriteButtonClick:self];
    }
}

-(void)setUserInteractionEnabled:(BOOL)userInteractionEnabled{
    [super setUserInteractionEnabled:userInteractionEnabled];
    
    self.texture = userInteractionEnabled ? self.canClickImage : self.cannotClickImage;

}

@end
