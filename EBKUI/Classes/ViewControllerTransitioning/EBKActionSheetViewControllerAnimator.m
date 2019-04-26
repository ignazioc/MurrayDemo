//
//  EBKActionSheetViewControllerAnimator.m
//  eBay Kleinanzeigen
//
//  Created by Plunien, Johannes on 02/03/15.
//  Copyright (c) 2015 eBay Kleinanzeigen. All rights reserved.
//

#import "EBKActionSheetViewControllerAnimator.h"
#import "EBKDimmingView.h"

@interface EBKActionSheetViewControllerAnimator ()

@property (nonatomic) EBKDimmingView *dimmingView;

@end

@implementation EBKActionSheetViewControllerAnimator

- (instancetype)init
{
    self = [super init];
    if (self) {
        _isDimmingEnabled = YES;
    }
    return self;
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 0.3f;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;

    if (self.isPresenting) {
        CGRect frame = transitionContext.containerView.bounds;

        self.dimmingView = [[EBKDimmingView alloc] initWithFrame:frame];
        self.dimmingView.transparent = YES;

        [transitionContext.containerView addSubview:self.dimmingView];
        [transitionContext.containerView addSubview:toViewController.view];

        toViewController.view.frame = CGRectMake(frame.origin.x, screenHeight, frame.size.width, frame.size.height);
        toViewController.view.center = CGPointMake(fromViewController.view.center.x, toViewController.view.center.y);

        [UIView animateWithDuration:[self transitionDuration:transitionContext]
            delay:0
            usingSpringWithDamping:0.8
            initialSpringVelocity:5
            options:kNilOptions
            animations:^{
                if (self.isDimmingEnabled) {
                    self.dimmingView.transparent = NO;
                }
                toViewController.view.frame = CGRectMake(toViewController.view.frame.origin.x, screenHeight - toViewController.view.frame.size.height, toViewController.view.frame.size.width, toViewController.view.frame.size.height);
            }
            completion:^(BOOL finished) {
                [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
            }];
    }
    else {
        [transitionContext.containerView addSubview:fromViewController.view];

        [UIView animateWithDuration:[self transitionDuration:transitionContext]
            animations:^{
                if (self.isDimmingEnabled) {
                    self.dimmingView.transparent = YES;
                }
                fromViewController.view.frame = CGRectMake(fromViewController.view.frame.origin.x, screenHeight, fromViewController.view.frame.size.width, fromViewController.view.frame.size.height);
            }
            completion:^(BOOL finished) {
                [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
            }];
    }
}

@end
