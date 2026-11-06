# NaijaLink

A Flutter starter for the NaijaLink delivery marketplace. The app is designed for Android and iOS, starting in Ibadan, with green, white, and orange branding.

## Run locally

Install the Flutter SDK, then from the repository root run:

```sh
flutter pub get
flutter run
```

To build a local Android APK after installing the Android toolchain:

```sh
flutter build apk --release
```

The APK will be generated at `build/app/outputs/flutter-apk/app-release.apk`. It is not built or signed by this repository setup, so there is no download link yet.

## Firebase setup

This repo now includes the Firebase-ready app structure for a real backend.

1. Create or select an existing Firebase project in the Firebase console.
2. In the project root, install the Firebase tooling and connect the app:

```sh
npm install -g firebase-tools
firebase login
flutter pub global activate flutterfire_cli
flutterfire configure
```

3. When prompted, select your Firebase project and the target platform(s).
4. The generated `lib/firebase_options.dart` file will replace the placeholder config included in this starter.
5. Run the app again:

```sh
flutter run
```

## Current starter

- Responsive marketplace home screen with search, categories, example products, and nearby rider cards.
- Inter-state delivery entry point with park/pickup-point messaging.
- Demo navigation for home, explore, deliveries, and profile.
- Demo role selector for buyer, seller, rider, and admin dashboard previews.
- Green, white, and orange visual identity with a location/link-inspired app icon.
- Firebase-ready project layout for auth, Firestore, storage, and cloud functions.

## Planned production work

This starter is a front-end demo with sample data. It does **not** yet process payments, verify NIN, authenticate users, create real orders, scan QR codes, transmit live location, or issue bank payouts.

Next implementation milestones:
1. Add backend/API, account registration and role-based access.
2. Add seller product and inventory management and buyer order checkout.
3. Integrate a supported payment marketplace flow; document the 5% platform share from the rider's delivery fee and provider charges.
4. Add server-verified pickup/delivery QR plus backup PIN and refund/dispute handling.
5. Add consent-based live rider location for active deliveries, with sharing stopped at completion/cancellation.
6. Add distance estimates, transparent delivery quotes, inter-state transport/park partner handoffs, and tracking events.
7. Add verified post-delivery buyer/seller rider reviews and fair ranking safeguards.
8. Add English AI support, then localization for additional Nigerian languages.

Do not commit payment secrets, NIN data, private keys, or production user data to this repository.
