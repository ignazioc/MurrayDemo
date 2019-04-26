//
//  EBKTransparentInterceptorBackgroundView.m
//  eBay Kleinanzeigen
//
//  Created by Heimann, Paul on 28.09.12.
//  Copyright (c) 2012 eBay Kleinanzeigen. All rights reserved.
//

#import "EBKTransparentInterceptorBackgroundView.h"

@interface EBKTransparentInterceptorBackgroundView ()

@property (nonatomic, weak) EBKOverlayView *overlayView;

@end

@implementation EBKTransparentInterceptorBackgroundView

- (id)init
{
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup
{
    self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    BOOL pointInsideMe = [super pointInside:point withEvent:event];
    if (pointInsideMe) {
        [self.overlayView detachWithCancelStatus:YES];
    }
    return NO;
}

- (void)addedToOverlay:(EBKOverlayView *)overlayView
{
    self.overlayView = overlayView;
}

@end
