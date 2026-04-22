# Vishwagra iOS App

This folder contains a native iOS app wrapper for the existing Vishwagra PHP website.

## Architecture

- Frontend: SwiftUI
- Browser engine: `WKWebView`
- Backend reused: `https://www.vishwagra.com`
- Database reused: existing website MySQL database through the website backend

The iOS app does not connect to MySQL directly. All login, session, orders, courses, and dashboard data continue to work through the current PHP application and its existing database.

## Folder

- `VishwagraIOS.xcodeproj`: Xcode project
- `VishwagraIOS/`: Swift source, assets, and app plist

## Open In Xcode

1. Open `ios-app/VishwagraIOS.xcodeproj`
2. Set your Apple Team in Signing & Capabilities
3. Build and run on an iPhone simulator or device

## Mac Exact Steps To Generate IPA

1. Open `ios-app/VishwagraIOS.xcodeproj` in Xcode on Mac
2. Go to `Targets > VishwagraIOS > Signing & Capabilities`
3. Select your Apple `Team`
4. Change `Bundle Identifier` if needed
5. In the top bar, select `Any iOS Device (arm64)`
6. Click `Product > Archive`
7. When Organizer opens, click `Distribute App`
8. Choose `Ad Hoc` or `App Store Connect`
9. Export to generate the `.ipa` file

## Command Line IPA Build On Mac Or Cloud Mac

This folder now also includes:

- `build-ipa.sh`: archives and exports the app with `xcodebuild`
- `ExportOptions.plist`: sample export options for Ad Hoc export

Example:

```bash
cd ios-app
chmod +x build-ipa.sh
./build-ipa.sh
```

Output:

- Archive: `ios-app/build/VishwagraIOS.xcarchive`
- IPA export folder: `ios-app/build/export/`

If export succeeds, the `.ipa` file will be inside `ios-app/build/export/`.

## Important Limitation About "Free" IPA

- Windows alone cannot generate a real installable iOS `.ipa`
- A Mac or cloud macOS runner is required for archive/export
- An installable `.ipa` still needs valid Apple code signing
- A free Apple ID is usually enough for local device testing from Xcode, but not for a reusable distributable `.ipa`
- For shareable Ad Hoc or App Store `.ipa`, you normally need a paid Apple Developer account

## Where The IPA Will Be

The `.ipa` file is not inside this Windows project folder yet.

It will be created only after export from Xcode on Mac, in the folder you choose during export, or in `ios-app/build/export/` if you use `build-ipa.sh`.

## Base URL

The app reads the website URL from:

- `VishwagraIOS/Config/AppConfig.swift`

Current value:

- `https://www.vishwagra.com`

## Final App Metadata

- App name: `Vishwagra`
- Bundle identifier: `com.vishwagra.ios`
- Version: `1.0.0`
- Build number: `1`

If you want to test against localhost, change it to a reachable IP or domain. iPhone simulator cannot use your Windows `localhost` directly.

## Included Features

- Home, Courses, Student, Contact tabs
- Shared session/cookies across tabs
- Pull to refresh
- Back, forward, reload, and home actions
- External handling for phone, mail, WhatsApp, and Maps links
- Native launch screen
- In-app branded splash screen
