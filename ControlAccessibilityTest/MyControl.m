//
//  MyControl.m
//  ControlAccessibilityTest
//
//  Created by Vlas Voloshin on 23/05/2015.
//  Copyright (c) 2015 Vlas Voloshin. All rights reserved.
//

#import "MyControl.h"

@implementation MyControl
{
    NSString *_privateString;
}

+ (Class)layerClass
{
    return [CAGradientLayer class];
}

+ (void)commonInit:(MyControl *)control
{
    // Make sure that control initializes its non-highlighted state.
    [control setHighlighted:NO];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self.class commonInit:self];
    }
    
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self.class commonInit:self];
    }
    
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.layer.bounds = self.bounds;
}

- (void)setHighlighted:(BOOL)highlighted
{
    [super setHighlighted:highlighted];
    
    // Nothing smart, just a gradient changing colors on highlighting.
    CAGradientLayer *layer = (CAGradientLayer *)self.layer;
    UIColor *filledColor = [UIColor colorWithRed:0.0f green:0.5f blue:1.0f alpha:1.0f];
    UIColor *semitransparentColor = [filledColor colorWithAlphaComponent:0.5f];
    UIColor *transparentColor = [filledColor colorWithAlphaComponent:0.0f];
    
    id filledColorRef = (__bridge id)filledColor.CGColor;
    id transparentColorRef = (__bridge id)transparentColor.CGColor;
    id semitransparentColorRef = (__bridge id)semitransparentColor.CGColor;
    
    layer.locations = @[ @(0.0f), @(0.25f), @(0.5f), @(0.75f), @(1.0f) ];
    if (highlighted) {
        layer.colors = @[ transparentColorRef, filledColorRef, transparentColorRef, filledColorRef, transparentColorRef ];
    } else {
        layer.colors = @[ transparentColorRef, semitransparentColorRef, filledColorRef, semitransparentColorRef, transparentColorRef ];
    }
}

- (id<CAAction>)actionForLayer:(CALayer *)layer forKey:(NSString *)event
{
    // Again, no smart-pants. Just making sure gradient colors are animated.
    if ([event isEqualToString:@"colors"]) {
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:event];
        animation.duration = 0.15;
        animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
        animation.fromValue = [layer.presentationLayer valueForKey:event];
        
        return animation;
    } else {
        return [super actionForLayer:layer forKey:event];
    }
}

- (void)setPublicString:(NSString *)publicString
{
    // Just moving some strings around, not touching any accessibility properties!
    _privateString = _publicString;
    
    _publicString = [publicString copy];
}

@end
