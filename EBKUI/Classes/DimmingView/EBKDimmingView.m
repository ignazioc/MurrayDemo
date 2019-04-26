//
//  EBKDimmingView.m
//  eBay Kleinanzeigen
//
//  Created by Plunien, Johannes on 25/06/15.
//  Copyright (c) 2015 eBay Kleinanzeigen. All rights reserved.
//

#import "EBKDimmingView.h"

#import <EBKUI/EBKUI-Swift.h>

@implementation EBKDimmingView

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self setUp];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUp];
    }
    return self;
}

- (void)setUp
{
    self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.backgroundColor = [UIColor ebkBlack];
    self.transparent = NO;
}

#pragma mark - Public

- (void)setTransparent:(BOOL)transparent
{
    _transparent = transparent;
    if (transparent) {
        self.alpha = 0.0f;
    }
    else {
        self.alpha = 0.4f;
    }
}

@end
