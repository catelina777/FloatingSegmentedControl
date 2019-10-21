# FloatingSegmentedControl
Provide segment control like iOS13 photo app

<p align="center">
    <img src="https://img.shields.io/badge/Swift-5.0-orange.svg">
    <img src="https://img.shields.io/badge/platforms-ios-black.svg">
    <img src="https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat" href="https://github.com/Carthage/Carthage">
</p>

## This library makes this repository easy to use 👀
[FloatingSwitch]https://github.com/usagimaru/FloatingSwitch

1             |  2
:-------------------------:|:-------------------------:
![](Images/light-mode_example.png)  |  ![](Images/dark-mode_example.png)


# Installation 🚀

## Carthage
`github "catelina777/FloatingSegmentedControl"`

# Usage
1. Install a custom view on Interface Builder.
2. ***Important:*** Assign the custom view class as `FloatingSegmentedControl` like [this](Images/custom_view.png).
3. Set an appropriate layouts. In the default implementation of FloatingSegment, the width follows the intrinsic size.
4. Set segments with `setSegments (with:)` method.
5. Set `target` and `action` with addTarget method. Then you can catch control events when users switch segments.

See `ViewController.swift` for usage.
