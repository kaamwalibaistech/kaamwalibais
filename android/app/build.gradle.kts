plugins {
id("com.android.application")
id("org.jetbrains.kotlin.android")
// The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
id("dev.flutter.flutter-gradle-plugin")
}

import java.util.Properties
import java.io.FileInputStream

// Load keystore properties BEFORE the android { } block
val keystoreProperties = Properties()
val keystorePropertiesFile = rootProject.file("key.properties")
if (keystorePropertiesFile.exists()) {
FileInputStream(keystorePropertiesFile).use { fis ->
keystoreProperties.load(fis)
}
}

android {
namespace = "com.innowrap.user.kaamwalibais"
compileSdk = flutter.compileSdkVersion
ndkVersion = "27.0.12077973"
compileOptions {
    sourceCompatibility = JavaVersion.VERSION_11
    targetCompatibility = JavaVersion.VERSION_11
}

kotlinOptions {
    jvmTarget = JavaVersion.VERSION_11.toString()
}

defaultConfig {
    applicationId = "com.innowrap.user.kaamwalibais"
    minSdk = flutter.minSdkVersion
    targetSdk = 35
    versionCode = flutter.versionCode
    versionName = flutter.versionName
}

// Signing configuration for release
signingConfigs {
    create("release") {
        // Guard against missing key.properties to avoid casting null to String
        val alias = keystoreProperties["keyAlias"] as String?
        val keyPass = keystoreProperties["keyPassword"] as String?
        val storePath = keystoreProperties["storeFile"] as String?
        val storePass = keystoreProperties["storePassword"] as String?

        if (alias != null && keyPass != null && storePath != null && storePass != null) {
            keyAlias = alias
            keyPassword = keyPass
            storeFile = file(storePath)
            storePassword = storePass
        } else {
            // This helps produce a clear error if any field is missing
            throw GradleException("Missing one or more signing properties in key.properties (keyAlias, keyPassword, storeFile, storePassword).")
        }
    }
}

buildTypes {
    getByName("release") {
        signingConfig = signingConfigs.getByName("release")
        isMinifyEnabled = true
        
        proguardFiles(
            getDefaultProguardFile("proguard-android-optimize.txt"),
            "proguard-rules.pro"
        )
    }
}
}

flutter {
source = "../.."
}