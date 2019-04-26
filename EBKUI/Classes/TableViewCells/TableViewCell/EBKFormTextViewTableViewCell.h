//
//  EBKFormTextViewTableViewCell.h
//  eBay Kleinanzeigen
//
//  Created by Mark Armstrong on 8/30/12.
//  Copyright (c) 2012 eBay Kleinanzeigen. All rights reserved.
//

#import "EBKFormTextInputTableViewCell.h"
#import "EBKTextViewWithPlaceholder.h" // Dont remove this!

@class EBKTextViewWithPlaceholder;

@interface EBKFormTextViewTableViewCell : EBKFormTextInputTableViewCell <UITextViewDelegate>

@property (nonnull, nonatomic) EBKTextViewWithPlaceholder *textInputField;
@property (assign, nonatomic) UIEdgeInsets textViewInsets;

@end
