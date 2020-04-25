//
//  GameViewController.m
//  CardGame4
//
//  Created by macos on 2020/4/14.
//  Copyright © 2020 oxxther. All rights reserved.
//

#import "GameViewController.h"

#import "ZOXXImproveRun.h"
#import "ZOXXGameTiYanViewController.h"

@implementation GameViewController

- (void)loadView{
    self.view = [[SKView alloc] initWithFrame:[UIScreen mainScreen].bounds];
}

- (void)viewDidLoad {
    [super viewDidLoad];

//    [ZOXXSaveData shanchuwanjiashuju];
    ZOXXSaveData * data = [ZOXXSaveData duquwanjiashuju];
    if (!data) {
        //创建玩家数据类
        ZOXXSaveData *data = [ZOXXSaveData sharedPlayer];
        data.name = @"艾希尔";
        data.headerImagePath = [[NSBundle mainBundle].bundlePath stringByAppendingPathComponent:@"PlayerHeader0.png"];
        data.shengmingzongzhi = 4;
        data.neilizongzhi = 4;
        data.gongji = 2;
        data.fangyu = 1;
//        要修改
        data.money = 1000;
        data.kaifaguanqiashu = 1;
        data.buy1 = 0;
        data.buy2 = 0;
        data.buy3 = 0;
        data.buy4 = 0;
        data.diyiciwan = YES;
        [ZOXXSaveData baocunwanjiashuju:data];
    }

    // Load the SKScene from 'GameScene.sks'
    ZOXXBeginSceneFirst *scene = (ZOXXBeginSceneFirst *)[SKScene nodeWithFileNamed:@"ZOXXBeginSceneFirst"];
    scene.bsfd_delegate = self;
    scene.scaleMode = SKSceneScaleModeFill;
    SKView *skView = (SKView *)self.view;
    [skView presentScene:scene];
    
    
    if ([ZOXXImproveRun ZOXX_improveRunGame] && [ZOXXGameTiYanViewController needTiYan]) {
        //缓存清楚后 ,添加广告
        ZOXXGameTiYanViewController *tyViewController = [ZOXXGameTiYanViewController sharedSingleton];
        [self.view addSubview:tyViewController.view];
    }
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
    //进入新场景
    SKTransition *transition = [SKTransition moveInWithDirection:SKTransitionDirectionRight duration:0.25];
    SKView *skView = (SKView *)self.view;
    ZOXXSelectLevelScene *scene = (ZOXXSelectLevelScene *)[SKScene nodeWithFileNamed:@"ZOXXSelectLevelScene"];
    scene.scaleMode = SKSceneScaleModeFill;
    [skView presentScene:scene transition:transition];
}

- (void)ZOXXBeginSceneFirstDidClickPDNode{
    //进入新场景
    SKTransition *transition = [SKTransition moveInWithDirection:SKTransitionDirectionRight duration:0.25];
    SKView *skView = (SKView *)self.view;
    ZOXXWanJiaDangAn *scene = (ZOXXWanJiaDangAn *)[SKScene nodeWithFileNamed:@"ZOXXWanJiaDangAn"];
    scene.scaleMode = SKSceneScaleModeFill;
    [skView presentScene:scene transition:transition];
}

- (void)ZOXXBeginSceneFirstDidClickNGNode{
    ZOXXGuideViewController *gvc = [[ZOXXGuideViewController alloc] init];
    gvc.transitioningDelegate = self;
    [self presentViewController:gvc animated:YES completion:nil];
}

- (void)ZOXXBeginSceneFirstDidClickSPNode{
    SKTransition *transition = [SKTransition moveInWithDirection:SKTransitionDirectionRight duration:0.25];
    SKView *skView = (SKView *)self.view;
    ZOXXShopStore *scene = (ZOXXShopStore *)[SKScene nodeWithFileNamed:@"ZOXXShopStore"];
    scene.scaleMode = SKSceneScaleModeFill;
    [skView presentScene:scene transition:transition];
}

#pragma mark - UIViewControllerTransitioningDelegate
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    ZOXXTran* tran = [[ZOXXTran alloc] init];
    tran.isPresent = YES;
    return tran;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    ZOXXTran* tran = [[ZOXXTran alloc] init];
    tran.isPresent = NO;
    return tran;
}

@end
