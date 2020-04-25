//
//  ZOXXCard.m
//  CardGame4
//
//  Created by macos on 2020/4/16.
//  Copyright © 2020 oxxther. All rights reserved.
//

#import "ZOXXCard.h"

@interface ZOXXCard ()

@property (nonatomic) SKLabelNode *label;

@property (nonatomic) ZOXXCardLabelType type;

@property (nonatomic) SKSpriteNode *mask;

@end

@implementation ZOXXCard

- (instancetype)initWithDelegate:(id<ZOXXCardDelegate>)delegate andTag:(ZOXXCardLabelType)labelType{
    if (self = [super initWithColor:[UIColor redColor] size:CardSize]) {
        self.delegate = delegate;
        self.type = labelType;
        self.label = [[SKLabelNode alloc] init];
        self.mask = [[SKSpriteNode alloc] initWithColor:[[UIColor blackColor] colorWithAlphaComponent:0.5] size:CardSize];
        [self addChild:self.label];
        [self addChild:self.mask];
        switch (self.type) {
            case ZOXXCardLabelTypeWanJia:
            {
                self.label.position = CGPointMake(CardSize.width / 2, 10);
                self.mask.anchorPoint =CGPointMake(0, 0);
            }
                break;
            case ZOXXCardLabelTypeLaoDa:
            {
                self.label.position = CGPointMake(CardSize.width / 2, -CardSize.height + 10);
                self.mask.anchorPoint =CGPointMake(0, 1);
                self.mask.hidden = YES;
            }
                break;
            case ZOXXCardLabelTypeCenter:
            {
                self.label.position = CGPointMake(0, -CardSize.height/2+ 10);
                self.mask.anchorPoint =CGPointMake(0.5, 0.5);
                self.mask.hidden = YES;
            }
                break;
            default:
                break;
        }
    }
    return self;
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"点击了我%@",self);
    //实现移动
    self.isSelected = !self.isSelected;
    if (self.delegate && [self.delegate respondsToSelector:@selector(ZOXXCardClick:)]) {
        [self.delegate ZOXXCardClick:self];
    }
}


#pragma mark - setter

- (void)setCardData:(ZOXXCardData *)cardData{
    _cardData = cardData;
    
    self.label.text = cardData.name;
    switch (self.type) {
        case ZOXXCardLabelTypeWanJia:
        {
            self.texture = [SKTexture textureWithImage:[UIImage imageWithContentsOfFile:cardData.imagePath]];
        }
            break;
        case ZOXXCardLabelTypeLaoDa:
        {
            self.texture = [SKTexture textureWithImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle].bundlePath stringByAppendingPathComponent:@"MainPage10.png"]]];
            self.label.hidden = YES;
        }
            break;
        case ZOXXCardLabelTypeCenter:
        {
            self.texture = [SKTexture textureWithImage:[UIImage imageWithContentsOfFile:cardData.imagePath]];
        }
            break;
        default:
            break;
   }
}

- (void)setIsSelected:(BOOL)isSelected{
    _isSelected = isSelected;
    if (_isSelected) {
        //上移
        [self runAction:[SKAction moveBy:CGVectorMake(0, 30) duration:0.1]];
    }else{
        //移回
        [self runAction:[SKAction moveTo:self.origin duration:0.1]];
    }
}

- (void)setUserInteractionEnabled:(BOOL)userInteractionEnabled{
    [super setUserInteractionEnabled:userInteractionEnabled];
    NSLog(@"放开响应链");
    
    self.color = [UIColor grayColor];
    self.mask.hidden = userInteractionEnabled;
}

@end
