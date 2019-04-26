//
//  EBKFormTextInputTableViewCell.h
//  eBay Kleinanzeigen
//
//  Created by Heimann, Paul on 18.09.12.
//  Copyright (c) 2012 eBay Kleinanzeigen. All rights reserved.
//

#import "EBKFormTableViewCell.h"
#import <UIKit/UIKit.h>

@class EBKInputAccessoryView;

@interface EBKFormTextInputTableViewCell : EBKFormTableViewCell <UIGestureRecognizerDelegate>

@property (nonatomic, nullable) IBOutlet UIView<UITextInput> *textInputField;

@property (nonatomic, nullable, copy) void (^editingDidEndBlock)(NSString *_Nullable value);
@property (nonatomic, nullable, copy) void (^editingDidBeginBlock)(NSString *_Nullable value);
@property (nonatomic, nullable, copy) void (^textDidChangeBlock)(NSString *_Nullable value);
@property (nonatomic, nullable, copy) BOOL (^textShouldChangeBlock)(NSString *_Nullable value);

@property (nonatomic, nonnull, readonly) EBKInputAccessoryView *accessoryBar;
@property (nonatomic, assign, getter=isEnabled) BOOL enabled;

@property (nonatomic, nullable, readonly) NSString *text;

@end
