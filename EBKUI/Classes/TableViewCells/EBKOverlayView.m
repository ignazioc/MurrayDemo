//
//  EBKOverlayView.m
//  eBay Kleinanzeigen
//
//  Created by Mark Armstrong on 8/23/12.
//  Copyright (c) 2012 eBay Kleinanzeigen. All rights reserved.
//

#import "EBKOverlayView.h"
#import <EBKUI/EBKUI-Swift.h>

#define BORDER 10
#define SPACING 10
#define CORNER_RADIUS 5
#define MIN_INNER_WIDTH 45
#define ARROW_GAP 20

@interface EBKOverlayView ()

@property (nonatomic, assign) CGSize arrowFrameSize;
@property (nonatomic, readonly) CGRect popoverFrame;
@property (nonatomic, strong) UIBezierPath *shape;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, assign, getter=isShowing) BOOL showing;

@end

@implementation EBKOverlayView

- (id)init
{
    self = [super initWithFrame:CGRectZero];
    if (self) {
        [self setup];
    }
    return self;
}

- (id)initWithOrigin:(CGPoint)origin
{
    self = [super initWithFrame:CGRectMake(origin.x, origin.y, 0, 0)];
    if (self) {
        [self setup];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    [NSException raise:NSInternalInconsistencyException format:@"OverlayView determines its size by inner content. Defining a frame is not supported"];
    return nil;
}

- (void)setup
{
    // Background
    self.backgroundColor = [UIColor clearColor];

    // Arrow Default Values
    self.arrowFrameSize = CGSizeMake(15, 10);
    self.arrowPosition = OverlayArrowPositionTopCenter;
    self.arrowCustomXOffset = NSIntegerMax;
    self.edgeInsets = UIEdgeInsetsMake(BORDER, BORDER, BORDER, BORDER);

    if (!self.contentView) {
        self.contentView = [[UIView alloc] initWithFrame:CGRectZero];
        [super addSubview:self.contentView];
    }
}

#pragma mark - Positioning

- (void)setOrigin:(CGPoint)origin
{
    self.frame = CGRectMake(origin.x, origin.y, self.frame.size.width, self.frame.size.height);
}

- (CGPoint)origin
{
    return self.frame.origin;
}

#pragma mark - Attaching / Detaching

- (void)attachToView:(UIView *)view
{
    if (view != self.superview) {
        [self removeFromSuperview];
        [view addSubview:self];
    }
    [self show];
}

- (void)detachWithCancelStatus:(BOOL)cancelStatus
{
    [self hideWithCompletionBlock:^{
        if (self.showing == NO) {
            [self removeFromSuperview];
        }
    }];
    if (self.dismissBlock) {
        self.dismissBlock(self, cancelStatus);
    }
}

- (void)detach
{
    [self detachWithCancelStatus:NO];
}

#pragma mark - Showing / Hiding

- (void)show
{
    if (self.showing == NO) {
        self.showing = YES;

        self.backgroundView.alpha = 0.0;
        self.alpha = 0.0;
        [self.layer removeAllAnimations];
        [self.backgroundView.layer removeAllAnimations];
        self.layer.shouldRasterize = YES;

        __weak __typeof__(self) weakSelf = self;
        [UIView animateWithDuration:0.25
            delay:0
            options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionAllowUserInteraction
            animations:^{
                __typeof__(self) strongSelf = weakSelf;
                strongSelf.backgroundView.alpha = 1.0;
                strongSelf.alpha = 1.0;
            }
            completion:^(BOOL complete) {
                __typeof__(self) strongSelf = weakSelf;
                strongSelf.layer.shouldRasterize = NO;
            }];
    }
}

- (void)hide
{
    [self hideWithCompletionBlock:nil];
}

- (void)hideWithCompletionBlock:(void (^)(void))completionBlock
{
    if (self.showing == YES) {
        self.showing = NO;

        [self.layer removeAllAnimations];
        [self.backgroundView.layer removeAllAnimations];
        self.layer.shouldRasterize = YES;

        __weak __typeof__(self) weakSelf = self;
        [UIView animateWithDuration:0.25
            delay:0
            options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionAllowUserInteraction
            animations:^{
                __typeof__(self) strongSelf = weakSelf;
                strongSelf.backgroundView.alpha = 0.0;
                strongSelf.alpha = 0.0;
            }
            completion:^(BOOL finished) {
                __typeof__(self) strongSelf = weakSelf;
                strongSelf.layer.shouldRasterize = NO;
                if (completionBlock) {
                    completionBlock();
                }
            }];
    }
}

#pragma mark - Edge Insets

- (void)setEdgeInsets:(UIEdgeInsets)edgeInsets
{
    _edgeInsets = edgeInsets;
    [self setNeedsDisplay];
}

#pragma mark - Arrow

- (void)setArrowPosition:(OverlayArrowPosition)arrowPosition
{
    _arrowPosition = arrowPosition;
    [self setNeedsDisplay];
}

- (void)setArrowCustomXOffset:(NSInteger)arrowCustomXOffset
{
    _arrowCustomXOffset = arrowCustomXOffset;
    [self setNeedsDisplay];
}

- (BOOL)isArrowAtTop
{
    return (self.arrowPosition == OverlayArrowPositionTopCenter || self.arrowPosition == OverlayArrowPositionTopLeft ||
            self.arrowPosition == OverlayArrowPositionTopRight);
}

- (BOOL)isArrowAtBottom
{
    return (self.arrowPosition == OverlayArrowPositionBottomCenter || self.arrowPosition == OverlayArrowPositionBottomLeft ||
            self.arrowPosition == OverlayArrowPositionBottomRight);
}

- (BOOL)isArrowAlignedLeft
{
    return (self.arrowPosition == OverlayArrowPositionTopLeft || self.arrowPosition == OverlayArrowPositionBottomLeft);
}

- (BOOL)isArrowAlignedCenter
{
    return (self.arrowPosition == OverlayArrowPositionTopCenter || self.arrowPosition == OverlayArrowPositionBottomCenter);
}

- (BOOL)isArrowAlignedRight
{
    return (self.arrowPosition == OverlayArrowPositionTopRight || self.arrowPosition == OverlayArrowPositionBottomRight);
}

#pragma mark - BackgroundView

- (void)setBackgroundView:(UIView<OverlayBackgroundView> *)backgroundView
{
    _backgroundView = backgroundView;

    if ([self.backgroundView respondsToSelector:@selector(addedToOverlay:)]) {
        [self.backgroundView addedToOverlay:self];
    }
}

- (void)addBackgroundView
{
    if (self.superview && self.backgroundView && self.backgroundView.superview == nil) {
        self.backgroundView.frame = self.superview.bounds;
        self.backgroundView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self.superview insertSubview:self.backgroundView belowSubview:self];
    }
}

- (void)removeBackgroundView
{
    [self.backgroundView removeFromSuperview];
}

#pragma mark - Overriding

- (void)addSubviews:(NSArray *)views
{
    for (UIView *v in views) {
        [self addSubview:v];
    }
}

- (void)didMoveToSuperview
{
    [super didMoveToSuperview];

    if (self.superview) {
        [self addBackgroundView];
    }
    else {
        [self removeBackgroundView];
    }
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    return [self.shape containsPoint:point];
}

- (void)addSubview:(UIView *)view
{
    [self.contentView addSubview:view]; // Make sure subviews are added to actual content view
    [self calculateSize];
}

#pragma mark - Shape preparation

- (CGRect)popoverFrame
{
    CGRect cornerRectFrame = CGRectInset(self.bounds, 1, 1);
    if (self.arrowPosition != OverlayArrowPositionNone) {
        cornerRectFrame.size.height -= self.arrowFrameSize.height;
        if ([self isArrowAtTop]) {
            cornerRectFrame.origin.y = self.arrowFrameSize.height;
        }
    }
    return cornerRectFrame;
}

- (void)createShape
{
    UIBezierPath *shape = [UIBezierPath bezierPath];
    UIBezierPath *roundedRectPath = [UIBezierPath bezierPathWithRoundedRect:self.popoverFrame cornerRadius:CORNER_RADIUS];
    [shape appendPath:roundedRectPath];

    // Calculate arrow shape if arrow is required
    if (self.arrowPosition != OverlayArrowPositionNone) {
        CGFloat midPointY = 0.0;
        CGFloat leftRightPointY = self.arrowFrameSize.height;

        // Case for bottom arrow
        if ([self isArrowAtBottom]) {
            midPointY = self.bounds.size.height;
            leftRightPointY = midPointY - self.arrowFrameSize.height - 1;
        }

        // Calculate offset for arrow depending if presets are used or a custom offset
        CGFloat xAdjust;
        if (self.arrowCustomXOffset == NSIntegerMax) {                        // We see NSIntegerMax as not beeing set
            CGFloat offset = lrint((self.bounds.size.width / 2) - ARROW_GAP); // Ajustment will be ARROW_GAP px of the width from either the right or left edge
            if ([self isArrowAlignedLeft]) {
                xAdjust = -offset;
            }
            else if ([self isArrowAlignedRight]) {
                xAdjust = offset;
            }
            else {
                xAdjust = 0; // [self isArrowAlignedCenter]
            }
        }
        else {
            xAdjust = self.arrowCustomXOffset;
        }

        // Peprare path for arrow
        UIBezierPath *triangle = [UIBezierPath bezierPath];
        CGFloat arrowCenterX = lrint(self.popoverFrame.size.width / 2);
        CGPoint leftPoint = CGPointMake(arrowCenterX - (self.arrowFrameSize.width / 2), leftRightPointY);
        leftPoint.x += xAdjust;
        CGPoint midPoint = CGPointMake(arrowCenterX, midPointY);
        midPoint.x += xAdjust;
        CGPoint rightPoint = CGPointMake(arrowCenterX + (self.arrowFrameSize.width / 2), leftRightPointY);
        rightPoint.x += xAdjust;
        [triangle moveToPoint:leftPoint];
        [triangle addLineToPoint:midPoint];
        [triangle addLineToPoint:rightPoint];
        [triangle addLineToPoint:leftPoint];

        [shape appendPath:triangle];
    }

    self.shape = shape;
}

- (void)drawRect:(CGRect)rect
{
    [self createShape];

    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);

    CGPathRef outline = CGPathCreateCopyByStrokingPath(self.shape.CGPath, NULL, 1, kCGLineCapRound, kCGLineJoinRound, 0);
    CGContextAddPath(context, outline);
    CGContextSetFillColorWithColor(context, [UIColor ebkGray].CGColor);
    CGContextFillPath(context);
    CGPathRelease(outline);

    CGContextAddPath(context, self.shape.CGPath);
    CGContextSetFillColorWithColor(context, [UIColor ebkWhite].CGColor);
    CGContextFillPath(context);

    CGContextRestoreGState(context);
}

- (void)calculateSize
{
    // Calculate width
    float contentViewMaxWidth = MIN_INNER_WIDTH;
    for (UIView *subview in self.contentView.subviews) {
        float currentWidth = subview.frame.size.width;
        if (currentWidth > contentViewMaxWidth) {
            contentViewMaxWidth = currentWidth;
        }
    }

    // If there's a superview, behave nicely and try to fit into it
    if (self.superview) {
        contentViewMaxWidth = MIN(contentViewMaxWidth, self.superview.bounds.size.width);
    }

    // Calculate height
    float contentViewMaxHeight = 0;
    for (NSInteger i = 0; i < self.contentView.subviews.count; i++) {
        UIView *subview = self.contentView.subviews[i];
        float width = subview.frame.size.width;
        float height = subview.frame.size.height;
        if (width > contentViewMaxWidth) {
            width = contentViewMaxWidth - 2 * SPACING;
        }
        subview.frame = CGRectMake(lrint((contentViewMaxWidth - width) / 2), contentViewMaxHeight, width, height);
        contentViewMaxHeight += height;
        if (i < self.contentView.subviews.count - 1) {
            contentViewMaxHeight += SPACING;
        }
    }

    float width = lrint(self.edgeInsets.left + contentViewMaxWidth + self.edgeInsets.right);
    float height = lrint(self.edgeInsets.top + contentViewMaxHeight + self.edgeInsets.bottom);

    // Add the arrow height if needed
    if (self.arrowPosition != OverlayArrowPositionNone) {
        height += self.arrowFrameSize.height;
    }

    float x = self.frame.origin.x;
    float y = self.frame.origin.y;

    if (self.forceCenter) {
        x = lrint((self.superview.bounds.size.width - width) / 2);
        y = lrint((self.superview.bounds.size.height - height) / 2);
    }

    self.frame = CGRectMake(x, y, MIN(width, self.superview.bounds.size.width), height);
    self.contentView.frame = CGRectMake(self.popoverFrame.origin.x + self.edgeInsets.left, self.popoverFrame.origin.y + self.edgeInsets.top,
                                        contentViewMaxWidth, contentViewMaxHeight);
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self calculateSize];
}

@end
