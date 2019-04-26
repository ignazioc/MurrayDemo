//
//  EBKTextViewWithPlaceholder.h
//  eBay Kleinanzeigen
//
//  Created by Mark Armstrong on 8/28/12.
//  Copyright (c) 2012 eBay Kleinanzeigen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EBKTextViewWithPlaceholder : UITextView

@property (nonatomic, strong) NSString *placeholder;
@property (nonatomic, readonly, getter=isPlaceholderHidden) BOOL placeholderHidden;

@end
