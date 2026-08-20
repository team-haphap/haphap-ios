plugins {
    id("com.android.application")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

// Read KAKAO_NATIVE_APP_KEY from the project-root .env file so the native
// Kakao redirect scheme (registered in AndroidManifest.xml) stays in sync
// with the key used at runtime by kakao_flutter_sdk.
val envFile = rootProject.file("../.env")
val kakaoNativeAppKey: String = if (envFile.exists()) {
    envFile.readLines()
        .firstOrNull { it.startsWith("KAKAO_NATIVE_APP_KEY=") }
        ?.substringAfter("=")
        ?.trim()
        ?: ""
} else {
    ""
}

android {
    namespace = "com.haphap.app"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    defaultConfig {
        applicationId = "com.haphap.app"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName

        manifestPlaceholders["KAKAO_NATIVE_APP_KEY"] = kakaoNativeAppKey
    }

    buildTypes {
        release {
            // TODO: Add your own signing config for the release build.
            // Signing with the debug keys for now, so `flutter run --release` works.
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

kotlin {
    compilerOptions {
        jvmTarget = org.jetbrains.kotlin.gradle.dsl.JvmTarget.JVM_17
    }
}

flutter {
    source = "../.."
}
