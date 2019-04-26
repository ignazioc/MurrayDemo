//
//  EBKFormTableViewCell.h
//  eBay Kleinanzeigen
//
//  Created by Hoefele, Claus(choefele) on 28.08.12.
//  Copyright (c) 2012 eBay Kleinanzeigen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EBKFormTableViewCell : UITableViewCell

@property (nonatomic) float detailLabelX;
@property (nonatomic, readonly) BOOL hasError;

- (void)setUpFormTableViewCell;
- (void)showError:(nullable NSError *)error;
- (void)showErrorString:(nullable NSString *)errorString;
- (void)showOverlayWithMessage:(nonnull NSString *)message;
- (void)hideOverlay;

@end
