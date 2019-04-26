//
//  EBKInputAccessoryView.h
//  eBay Kleinanzeigen
//
//  Created by Heimann, Paul on 18.09.12.
//  Copyright (c) 2012 eBay Kleinanzeigen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EBKInputAccessoryView : UIToolbar

@property (copy, nonatomic) void (^doneButtonPressed)(void);

@end
