//
//  GameViewController.m
//  CardGame4
//
//  Created by macos on 2020/4/14.
//  Copyright © 2020 oxxther. All rights reserved.
//

#import "GameViewController.h"

@implementation GameViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Load the SKScene from 'GameScene.sks'
    ZOXXBeginSceneFirst *scene = (ZOXXBeginSceneFirst *)[SKScene nodeWithFileNamed:@"ZOXXBeginSceneFirst"];
    scene.bsfd_delegate = self;
    scene.scaleMode = SKSceneScaleModeAspectFit;
    SKView *skView = (SKView *)self.view;
    [skView presentScene:scene];
    skView.showsFPS = YES;
    skView.showsNodeCount = YES;
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
    SKView *skView = (SKView *)self.view;
    ZOXXMainScene *scene = (ZOXXMainScene *)[SKScene nodeWithFileNamed:@"ZOXXMainSceneView"];
    scene.scaleMode = SKSceneScaleModeAspectFit;
    [skView presentScene:scene transition:transition];
}

- (void)ZOXXBeginSceneFirstDidClickPDNode{}
- (void)ZOXXBeginSceneFirstDidClickNGNode{}
- (void)ZOXXBeginSceneFirstDidClickSPNode{}


@end
