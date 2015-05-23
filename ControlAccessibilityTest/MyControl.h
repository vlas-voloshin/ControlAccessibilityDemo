//
//  MyControl.h
//  ControlAccessibilityTest
//
//  Created by Vlas Voloshin on 23/05/2015.
//  Copyright (c) 2015 Vlas Voloshin. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 Simple UIControl subclass which has strings in its ivars.
 */
IB_DESIGNABLE
@interface MyControl : UIControl

/** A fancy string property not designed to be used for accessibility. */
@property (nonatomic, copy) NSString *publicString;

@end
