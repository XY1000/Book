//
//  TransitionAnimation.m
//  Book
//
//  Created by Apple on 16/4/16.
//  Copyright © 2016年 Chenghui. All rights reserved.
//

#import "TransitionAnimation.h"
#import "UIView+transition.h"

@implementation TransitionAnimation


+ (instancetype)transitonWithTransitoinType:(transitionType)type {
    

    return [[self alloc]initWithTransitoinType:type];
    
}

- (instancetype)initWithTransitoinType:(transitionType)type {
    
    self = [super init];
    
    if (self) {
        
        
        _type = type;
        
    }
    
    return self;
}


- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    return  5;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    if (self.type == transitionTypePop) {
        
        [self doPushAnimation:transitionContext];
        
    }else {
        
        [self doPopAnimation:transitionContext];
    }
    
}


 - (void)doPushAnimation:(id <UIViewControllerContextTransitioning>)transitionContext {
 
 UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
 UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
 //对tempView做动画，避免bug;
 UIView *tempView = [fromVC.view snapshotViewAfterScreenUpdates:NO];
 tempView.frame = fromVC.view.frame;
 UIView *containerView = [transitionContext containerView];
 
 NSLog(@"大小 = %f",containerView.frame.size.width);
 
 [containerView addSubview:toVC.view];
 [containerView addSubview:tempView];
 fromVC.view.hidden = YES;
 [containerView insertSubview:toVC.view atIndex:0];


 [tempView setAnchorPointTo:CGPointMake(0, 0.5)];




[UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
    tempView.layer.transform = CATransform3DMakeRotation(-M_PI_2, 0, 1, 0);
    
} completion:^(BOOL finished) {
    [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    if ([transitionContext transitionWasCancelled]) {
        [tempView removeFromSuperview];
        fromVC.view.hidden = NO;
    }
}];


}



- (void)doPopAnimation:(id <UIViewControllerContextTransitioning>)transitionContext {
    
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView = [transitionContext containerView];
    //拿到push时候的
    UIView *tempView = containerView.subviews.lastObject;
    [containerView addSubview:toVC.view];
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        tempView.layer.transform = CATransform3DIdentity;
        fromVC.view.subviews.lastObject.alpha = 1.0;
        tempView.subviews.lastObject.alpha = 0.0;
    } completion:^(BOOL finished) {
        if ([transitionContext transitionWasCancelled]) {
            [transitionContext completeTransition:NO];
        }else{
            [transitionContext completeTransition:YES];
            [tempView removeFromSuperview];
            toVC.view.hidden = NO;
        }
    }];
    
}





@end
