---
title: Android Lifecycle Listeners
---

import { CodeBlocksTable } from '~/components/plugins/CodeBlocksTable';

Some native modules need users to manually apply changes in the **MainActivity.java** or **MainApplication.java** to finish the setup. The Expo Modules system has an extensible design allowing your library to hook into some `Activity` or `Application` functions.

## Get Started

You should [create a module for Android first](./overview.md#setup). Then the entry point is to create a concrete class that implements [`Package`](https://github.com/expo/expo/blob/master/packages/expo-modules-core/android/src/main/java/expo/modules/core/interfaces/Package.java) interfaces. For most cases, you only need to implmement `createReactActivityLifecycleListeners` or `createApplicationLifecycleListeners` methods.

## `Activity` Listeners

To create an `Activity` listener, you should implement `createReactActivityLifecycleListeners` in your derived `Package` class.

<CodeBlocksTable tabs={["android/src/main/java/expo/modules/mylib/MyLibPackage.kt"]}>

```kotlin
package expo.modules.mylib

import android.content.Context
import expo.modules.core.interfaces.Package
import expo.modules.core.interfaces.ReactActivityLifecycleListener

class MyLibPackage : Package {
  override fun createReactActivityLifecycleListeners(activityContext: Context): List<ReactActivityLifecycleListener> {
    return listOf(MyLibReactActivityLifecycleListener(activityContext))
  }
}
```

</CodeBlocksTable>

`MyLibReactActivityLifecycleListener` is the derived class of [`ReactActivityLifecycleListener`](https://github.com/expo/expo/blob/master/packages/expo-modules-core/android/src/main/java/expo/modules/core/interfaces/ReactActivityLifecycleListener.java) where you can hook into the lifecycles. You can only override the methods you need. To get the supported listeners, you can check the `ReactActivityLifecycleListener.java` source code.

<CodeBlocksTable tabs={["android/src/main/java/expo/modules/mylib/MyLibReactActivityLifecycleListener.kt"]}>

```kotlin
package expo.modules.mylib

import android.app.Activity
import android.content.Context
import android.os.Bundle
import expo.modules.core.interfaces.ReactActivityLifecycleListener

class MyLibReactActivityLifecycleListener(activityContext: Context) : ReactActivityLifecycleListener {
  override fun onCreate(activity: Activity, savedInstanceState: Bundle?) {
    // Your setup code in `Activity.onCreate`.
    doSomeSetupInActivityOnCreate(activity)
  }
}
```

</CodeBlocksTable>

## Application Listeners

TBD

## Known Issues

#### Why there are no `onStart` and `onStop` listeners

Honestly, we did not set up the hooks from `MainActivity` but [`ReactActivityDelegate`](https://github.com/facebook/react-native/blob/400902093aa3ccfc05712a996c592a86f342253a/ReactAndroid/src/main/java/com/facebook/react/ReactActivityDelegate.java). There is some slight difference between `MainActivity` and `ReactActivityDelegate`. Because `ReactActivityDelegate` does not have `onStart` and `onStop`, that is why we don't support them in the meantime.

#### Interface Stabilities

TBD
