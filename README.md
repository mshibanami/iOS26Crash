# iOS 26 Crash Report

This is a sample project that reproduces a crash caused by `UISwitch` on `UICollectionView` when a dark-themed color exists in xcassets, whether used or not.

[2025/09/30 18:04 AEST] Submitted as FB20447562.

## Details

The app crashes when these conditions are met and the `UISwitch` is tapped:

* The app displays a SwiftUI view that embeds a `UICollectionViewController` using `UIViewControllerRepresentable`.
* The `UISwitch` is inside a `UICollectionViewCell` within a `UICollectionView` in the `UICollectionViewController`.
* The `UISwitch`'s `onTintColor` is set to a color from xcassets.
    * In the sample project, this color is named `accentColor`.
* Another color exists in xcassets (unused in the app) that includes a dark-mode variant.
    * In the sample project, this color is named `unusedColor`.

## Environment

The crash was confirmed in the following environments:

* **iPhone 15 (Physical Device)**
    * iOS 26.0 (23A341)
    * iOS 26.0.1 (23A355)
* **iPhone 12 mini (Physical Device)**
    * iOS 26.1 Beta (23B5044l)
* **iPhone 17 Pro (Simulator)**
    * iOS 26.0 (23A339)

Xcode version: 26.0 (17A324)

## Steps to Reproduce

1. Open `iOS26Crash.xcodeproj` in Xcode 26.0.
2. Run the app on an iPhone running iOS 26.0.
3. Tap the switch shown in the app.

### Expected Result

The switch toggles without crashing the app.

### Actual Result

The app crashes with the following log:

```
Triggered by Thread: 0

Exception Type:    EXC_BAD_ACCESS (SIGSEGV)
Exception Subtype: KERN_PROTECTION_FAILURE at 0x000000016ac4bff0
Exception Message: Thread stack size exceeded due to excessive recursion
Exception Codes:   0x0000000000000002, 0x000000016ac4bff0

Termination Reason:  Namespace SIGNAL, Code 11, Segmentation fault: 11
Terminating Process: exc handler [88175]


VM Region Info: 0x16ac4bff0 is in 0x167448000-0x16ac4c000;  bytes after start: 58736624  bytes before end: 15
      REGION TYPE                    START - END         [ VSIZE] PRT/MAX SHRMOD  REGION DETAIL
      dyld private memory         11a6d8000-11a714000    [  240K] r--/rwx SM=COW  
      GAP OF 0x4cd34000 BYTES
--->  STACK GUARD                 167448000-16ac4c000    [ 56.0M] ---/rwx SM=NUL  stack guard for thread 0
      Stack                       16ac4c000-16b448000    [ 8176K] rw-/rwx SM=SHM  thread 0

Thread 0 Crashed:
0      Foundation                    	       0x181099c68 probeGC + 36
1      Foundation                    	       0x18109a724 -[NSConcreteMapTable objectForKey:] + 64
2      UIKitCore                     	       0x18622c61c _UITraitTokenForTraitLocked + 56
3      UIKitCore                     	       0x185e1e070 _UIThemeKeyValueFromTraitCollection + 248
4      UIKitCore                     	       0x185d9a1cc -[UIDynamicCatalogColor _resolvedColorWithTraitCollection:] + 68
5      UIKitCore                     	       0x185d96464 -[UIDynamicColor resolvedColorWithTraitCollection:] + 40
6      UIKitCore                     	       0x185d96474 -[UIDynamicColor resolvedColorWithTraitCollection:] + 56
-------- RECURSION LEVEL 173824
7      UIKitCore                     	       0x185d96474 -[UIDynamicColor resolvedColorWithTraitCollection:] + 56
-------- RECURSION LEVEL 173823
8      UIKitCore                     	       0x185d96474 -[UIDynamicColor resolvedColorWithTraitCollection:] + 56
-------- RECURSION LEVEL 173822
--------
-------- ELIDED 173818 LEVELS OF RECURSION THROUGH 0x185d96474 -[UIDynamicColor resolvedColorWithTraitCollection:] + 56
--------
173827 UIKitCore                     	       0x185d96474 -[UIDynamicColor resolvedColorWithTraitCollection:] + 56
-------- RECURSION LEVEL 3
173828 UIKitCore                     	       0x185d96474 -[UIDynamicColor resolvedColorWithTraitCollection:] + 56
-------- RECURSION LEVEL 2
173829 UIKitCore                     	       0x185d96474 -[UIDynamicColor resolvedColorWithTraitCollection:] + 56
-------- RECURSION LEVEL 1
173830 UIKitCore                     	       0x1852f55b0 0x185156000 + 1701296
173831 UIKitCore                     	       0x1853b1590 0x185156000 + 2471312
173832 UIKitCore                     	       0x1853b0378 0x185156000 + 2466680
173833 UIKitCore                     	       0x1853aecf8 0x185156000 + 2460920
173834 UIKitCore                     	       0x1853ae080 0x185156000 + 2457728
173835 UIKitCore                     	       0x18559505c 0x185156000 + 4452444
173836 UIKitCore                     	       0x185591d24 0x185156000 + 4439332
173837 UIKitCore                     	       0x185192ee0 0x185156000 + 249568
173838 UIKitCore                     	       0x1851eb848 0x185156000 + 612424
173839 UIKitCore                     	       0x1851eb848 0x185156000 + 612424
173840 UIKitCore                     	       0x1851739ac 0x185156000 + 121260
173841 UIKitCore                     	       0x185203190 0x185156000 + 709008
173842 UIKitCore                     	       0x186840a74 +[UIView(UIViewAnimationWithBlocks) _setupAnimationWithDuration:delay:view:options:factory:animations:start:animationStateGenerator:completion:] + 504
173843 UIKitCore                     	       0x185205b50 0x185156000 + 719696
173844 UIKitCore                     	       0x185205ca8 0x185156000 + 720040
173845 UIKitCore                     	       0x18559192c 0x185156000 + 4438316
173846 UIKitCore                     	       0x1855929bc 0x185156000 + 4442556
173847 UIKitCore                     	       0x185590e84 0x185156000 + 4435588
173848 UIKitCore                     	       0x1855910d8 0x185156000 + 4436184
173849 UIKitCore                     	       0x185b23f10 -[UISwitchModernVisualElement _transitionKnobToPressed:on:animated:] + 2632
173850 UIKitCore                     	       0x185b26864 -[UISwitchModernVisualElement _updateDisplayAnimated:] + 280
173851 UIKitCore                     	       0x185b221f8 -[UISwitchModernVisualElement _handleLongPressWithGestureLocationInBounds:gestureState:] + 592
173852 UIKitCore                     	       0x185d408ec -[UIGestureRecognizerTarget _sendActionWithGestureRecognizer:] + 76
173853 UIKitCore                     	       0x185d499ec _UIGestureRecognizerSendTargetActions + 88
173854 UIKitCore                     	       0x185d46760 _UIGestureRecognizerSendActions + 296
173855 UIKitCore                     	       0x185d46324 -[UIGestureRecognizer _updateGestureForActiveEvents] + 320
173856 UIKitCore                     	       0x185d4af30 -[UIGestureRecognizer gestureNode:didUpdatePhase:] + 296
173857 Gestures                      	       0x22efbf64c 0x22efb3000 + 50764
173858 Gestures                      	       0x22efdc858 0x22efb3000 + 170072
173859 Gestures                      	       0x22f0070ac 0x22efb3000 + 344236
173860 Gestures                      	       0x22f02e90c 0x22efb3000 + 506124
173861 UIKitCore                     	       0x185d37e18 -[UIGestureEnvironment _updateForEvent:window:] + 468
173862 UIKitCore                     	       0x18629b3d4 -[UIWindow sendEvent:] + 2796
173863 UIKitCore                     	       0x186279714 -[UIApplication sendEvent:] + 376
173864 UIKit                         	       0x1d0ffd180 -[UIApplicationAccessibility sendEvent:] + 100
173865 UIKitCore                     	       0x18630dc6c __dispatchPreprocessedEventFromEventQueue + 1184
173866 UIKitCore                     	       0x186310920 __processEventQueue + 4800
173867 UIKitCore                     	       0x186308ecc updateCycleEntry + 168
173868 UIKitCore                     	       0x185773878 _UIUpdateSequenceRunNext + 120
173869 UIKitCore                     	       0x18617ec90 schedulerStepScheduledMainSectionContinue + 56
173870 UpdateCycle                   	       0x2509462b4 UC::DriverCore::continueProcessing() + 80
173871 CoreFoundation                	       0x18044d4dc __CFRUNLOOP_IS_CALLING_OUT_TO_A_SOURCE0_PERFORM_FUNCTION__ + 24
173872 CoreFoundation                	       0x18044d424 __CFRunLoopDoSource0 + 168
173873 CoreFoundation                	       0x18044cbb0 __CFRunLoopDoSources0 + 220
173874 CoreFoundation                	       0x18044bd84 __CFRunLoopRun + 760
173875 CoreFoundation                	       0x180446e24 _CFRunLoopRunSpecificWithOptions + 496
173876 GraphicsServices              	       0x1925319bc GSEventRunModal + 116
173877 UIKitCore                     	       0x18625fc3c -[UIApplication _run] + 772
173878 UIKitCore                     	       0x186263e64 UIApplicationMain + 124
173879 SwiftUI                       	       0x1d8ebe23c closure #1 in KitRendererCommon(_:) + 164
173880 SwiftUI                       	       0x1d8ebdf84 runApp<A>(_:) + 180
173881 SwiftUI                       	       0x1d8c479cc static App.main() + 148
173882 iOS26Crash.debug.dylib        	       0x1049fdf98 static iOS26CrashApp.$main() + 40
173883 iOS26Crash.debug.dylib        	       0x1049fe044 __debug_main_executable_dylib_entry_point + 12
173884 ???                           	       0x104ba53d0 ???
173885 dyld                          	       0x104a78d54 start + 7184
```

### Demo Video

https://github.com/user-attachments/assets/f24d9eda-e5b9-48eb-bafd-003f1901844f

## Notes

* Removing `unusedColor` from xcassets prevents the crash.
* Setting the `onTintColor` of the `UISwitch` to a non-xcassets color (e.g., `.red`) also prevents the crash.
