pluginManagement {
    val flutterSdkPath = File(properties["flutter.sdk"] as String).absolutePath

    // Include Flutter's Gradle tooling
    includeBuild("$flutterSdkPath/packages/flutter_tools/gradle")

    repositories {
        google()
        mavenCentral()
        gradlePluginPortal()
    }
}

plugins {
    // Flutter plugin loader (version pinned by Flutter SDK)
    id("dev.flutter.flutter-plugin-loader") version "1.0.0"
    // Android application plugin (updated to match modern Flutter requirements)
    id("com.android.application") version "8.3.0" apply false  // Updated from 8.1.3
    // Kotlin Android plugin (kept in sync with your Kotlin version)
    id("org.jetbrains.kotlin.android") version "1.9.24" apply false  // Consider 2.x if available
}

dependencyResolutionManagement {
    repositoriesMode.set(RepositoriesMode.FAIL_ON_PROJECT_REPOS)
    repositories {
        google()
        mavenCentral()
    }
}

include(":app")