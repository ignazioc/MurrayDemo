//
//  EBKOverlayView.h
//  eBay Kleinanzeigen
//
//  Created by Mark Armstrong on 8/23/12.
//  Copyright (c) 2012 eBay Kleinanzeigen. All rights reserved.
//

#import <UIKit/UIKit.h>

@class EBKOverlayView;

typedef NS_ENUM(NSInteger, OverlayArrowPosition) {
    OverlayArrowPositionNone,
    OverlayArrowPositionTopLeft,
    OverlayArrowPositionTopCenter,
    OverlayArrowPositionTopRight,
    OverlayArrowPositionBottomLeft,
    OverlayArrowPositionBottomCenter,
    OverlayArrowPositionBottomRight
};

@protocol OverlayBackgroundView <NSObject>

@optional
- (void)addedToOverlay:(EBKOverlayView *)overlayView;

@end

@interface EBKOverlayView : UIView

@property (nonatomic, assign) BOOL forceCenter; // Positioning and Layout
@property (nonatomic, assign) UIEdgeInsets edgeInsets;
@property (nonatomic, assign) CGPoint origin;
@property (nonatomic, strong) UIView<OverlayBackgroundView> *backgroundView; // Background
@property (nonatomic, assign) OverlayArrowPosition arrowPosition;            // Arrow
@property (nonatomic, assign) NSInteger arrowCustomXOffset;
@property (nonatomic, copy) void (^dismissBlock)(EBKOverlayView *overlayView, BOOL canceled); // Dismiss Block

- (id)initWithOrigin:(CGPoint)origin;

- (void)attachToView:(UIView *)view;
- (void)detach;
- (void)detachWithCancelStatus:(BOOL)cancelStatus;
- (void)show;
- (void)hide;
- (void)calculateSize;

- (void)addSubview:(UIView *)view; // Custom implementation which adds to contentView instead of view
- (void)addSubviews:(NSArray *)views;

@end
