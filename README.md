What is this?
-------------

This iOS app demonstrates an undocumented behavior of UIKit Accessibility which generates default `accessibilityLabel` for custom `UIControl` subclasses.

What's that behavior?
---------------------

Documentation for `accessibilityLabel` says:

> The default value for this property is nil unless the receiver is a UIKit control, in which case the value is a label derived from the control’s title.

This means that if your app includes a custom `UIControl` subclass (`UIButton` and other standard subclasses have more specific behaviors), Accessibility will by default generate `accessibilityLabel` _for you_. Sounds nice, right?

Not until it turns out that this string is derived not from "control's title", but _from all of its `NSString` ivars_. Of course, this is fine if all string ivars of the control are user-facing anyway, but what if they're some implementation details, like keys or identifiers?

This behavior was noticed accidentally and later was discovered in UIKit Accessibility bundle disassembly.

What does this mean for you
---------------------------

If you care about accessibility in your app (hopefully you do!), you will probably need to safeguard your custom `UIControl` subclasses from this behavior. Do either of this:

1. Override `-accessibilityLabel` methods of those classes and return something meaningful for the user (maybe derived from other properties/ivars).
2. Set `accessibilityLabel` property of those controls to something meaningful.
3. Set `isAccessibilityElement` property of those controls to `NO`, so that Accessibility would ignore them. However, this would effectively make them inaccessible, so be careful.

How to test your app
--------------------

Use Accessibility Inspector to check that your app correctly implements Accessibility. Try using the app yourself with VoiceOver enabled. Use [Reveal](http://revealapp.com) to quickly check accessibility properties of your view hierarchy.

Caveat!
-------

When running this demo app and checking your own apps, make sure to enable Accessibility Inspector on iOS Simulator (or VoiceOver on iOS device) _before_ launching your app. Seems like default Accessibility behaviors (even as simple as `accessibilityLabel` of `UILabel` taken from its `text`) are only enabled when Accessibility is actually used – otherwise iOS probably doesn't even load Accessibility bundles.
