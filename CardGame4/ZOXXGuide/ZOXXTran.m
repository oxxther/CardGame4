//
//  ZOXXTran.m
//  CardGame4
//
//  Created by macos on 2020/4/23.
//  Copyright © 2020 oxxther. All rights reserved.
//

#import "ZOXXTran.h"

@implementation ZOXXTran

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.25f;
}
 
- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    UIView *toView = nil;
    UIView *fromView = nil;
    UIView *transView = nil;
    
    if ([transitionContext respondsToSelector:@selector(viewForKey:)]) {
        fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
        toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    } else {
        fromView = fromViewController.view;
        toView = toViewController.view;
    }
    
    if (_isPresent) {
        transView = toView;
        [[transitionContext containerView] addSubview:toView];
        
    } else {
        transView = fromView;
        [[transitionContext containerView] insertSubview:toView belowSubview:fromView];
    }
    
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    
    transView.frame = CGRectMake(_isPresent ? width : 0, 0, width, height);
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        transView.frame = CGRectMake(_isPresent ? 0 : width, 0, width, height);
    } completion:^(BOOL finished) {
         [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
    }];
    
}

@end
