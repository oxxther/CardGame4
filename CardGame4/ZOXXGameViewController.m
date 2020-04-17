//
//  ZOXXGameViewController.m
//  CardGame4
//
//  Created by macos on 2020/4/15.
//  Copyright © 2020 oxxther. All rights reserved.
//

#import "ZOXXGameViewController.h"

@interface ZOXXGameViewController ()

@property (nonatomic) SKView *skView;

@end

@implementation ZOXXGameViewController

- (void)awakeFromNib{
    [super awakeFromNib];
    
    CGFloat width = 1536;
    CGFloat height = 2048;
    
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    
    //适配过程
    CGFloat h = screenWidth / width * height;
    CGFloat w = screenWidth;
    if (h > screenHeight) {
        //需要适配高度
        w = screenHeight / height * width;
        h = screenHeight;
    }
    
    CGFloat x = (screenWidth - w)/2;
    CGFloat y = (screenHeight - h)/2;
    self.skView = [[SKView alloc] initWithFrame:CGRectMake(x, y, w, h)];
    [self.view addSubview:self.skView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    ZOXXBeginSceneFirst *scene = (ZOXXBeginSceneFirst *)[SKScene nodeWithFileNamed:@"ZOXXBeginSceneFirst"];
    scene.bsfd_delegate = self;
    scene.scaleMode = SKSceneScaleModeAspectFit;
    [self.skView presentScene:scene];
    self.skView.showsFPS = YES;
    self.skView.showsNodeCount = YES;
}

- (BOOL)shouldAutorotate {
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    } else {
        return UIInterfaceOrientationMaskAll;
    }
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

#pragma mark - ZOXXBeginSceneFirstDelegate
- (void)ZOXXBeginSceneFirstDidClickSGNode{
    //推出提示框
//    [self presentViewController:[[ZOXXAlertViewControll alloc] init] animated:YES completion:nil];
    
    //进入新场景
    SKTransition *transition = [SKTransition moveInWithDirection:SKTransitionDirectionRight duration:0.25];
    ZOXXMainScene *scene = (ZOXXMainScene *)[SKScene nodeWithFileNamed:@"ZOXXMainSceneView"];
    scene.scaleMode = SKSceneScaleModeAspectFit;
    [self.skView presentScene:scene transition:transition];
}

- (void)ZOXXBeginSceneFirstDidClickPDNode{}
- (void)ZOXXBeginSceneFirstDidClickNGNode{}
- (void)ZOXXBeginSceneFirstDidClickSPNode{}



@end
