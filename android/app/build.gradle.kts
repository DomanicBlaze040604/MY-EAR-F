def localProperties = new Properties()
def localPropertiesFile = rootProject.file('local.properties')
if (localPropertiesFile.exists()) {
    localPropertiesFile.withReader('UTF-8') { reader ->
        localProperties.load(reader)
    }
}

def flutterVersionCode = localProperties.getProperty('flutter.versionCode') ?: '1'
def flutterVersionName = localProperties.getProperty('flutter.versionName') ?: '1.0'

android {
    namespace "com.example.my_ear_app"
    compileSdkVersion 34
    ndkVersion flutter.ndkVersion

            compileOptions {
                sourceCompatibility JavaVersion.VERSION_11
                        targetCompatibility JavaVersion.VERSION_11
            }

    kotlinOptions {
        jvmTarget = '11'
    }

    sourceSets {
        main.java.srcDirs += 'src/main/kotlin'
    }

    defaultConfig {
        applicationId "com.example.my_ear_app"
        minSdkVersion 21
        targetSdkVersion 34
        versionCode flutterVersionCode.toInteger()
        versionName flutterVersionName
                multiDexEnabled true
    }

    buildTypes {
        release {
            signingConfig signingConfigs.debug
                    minifyEnabled true
            proguardFiles getDefaultProguardFile('proguard-android-optimize.txt'), 'proguard-rules.pro'
        }
    }
}

flutter {
    source '../..'
}

dependencies {
    implementation "org.jetbrains.kotlin:kotlin-stdlib-jdk8:1.9.24"
    implementation 'androidx.multidex:multidex:2.0.1'
    implementation platform('com.google.firebase:firebase-bom:32.7.0')
    implementation 'androidx.window:window:1.2.0'
    implementation 'androidx.window:window-java:1.2.0'
}