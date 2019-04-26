//
//  EBKActionSheetViewControllerAnimator.h
//  eBay Kleinanzeigen
//
//  Created by Plunien, Johannes on 02/03/15.
//  Copyright (c) 2015 eBay Kleinanzeigen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EBKActionSheetViewControllerAnimator : NSObject <UIViewControllerAnimatedTransitioning>

@property (nonatomic, getter=isPresenting) BOOL presenting;
@property (nonatomic) BOOL isDimmingEnabled;

@end
