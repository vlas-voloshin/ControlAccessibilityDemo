//
//  ViewController.m
//  ControlAccessibilityTest
//
//  Created by Vlas Voloshin on 23/05/2015.
//  Copyright (c) 2015 Vlas Voloshin. All rights reserved.
//

#import "ViewController.h"
#import "MyControl.h"

@interface ViewController ()

@property (nonatomic, weak) IBOutlet MyControl *myControl;
@property (nonatomic, weak) IBOutlet UILabel *accessibilityLabelLabel;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.accessibilityLabelLabel.text = self.myControl.accessibilityLabel;
}

- (IBAction)myControlTapped:(id)sender
{
    // Let's rotate some strings in our control's property
    NSArray *strings = @[ @"Totally not useful string", @"Absolutely not intended for the user to see", @"Clearly not something for accessibility", @"Funny easter egg programmer thinks no one would notice" ];
    self.myControl.publicString = strings[arc4random_uniform((uint32_t)strings.count)];
    
    // The strings we set would magically appear in the accessibility label!
    NSString *accessibilityLabel = self.myControl.accessibilityLabel;
    if (accessibilityLabel.length > 0) {
        self.accessibilityLabelLabel.text = accessibilityLabel;
    } else {
        // ... unless Accessibility Inspector is disabled
        self.accessibilityLabelLabel.text = @"Drat! Did you enable Accessibility Inspector before running this app?";
    }
}

@end
