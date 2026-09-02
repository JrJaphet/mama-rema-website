# Mama Rema Flutter Website

A responsive Flutter Web website for Mama Rema.

## Pages
- Home
- About Us
- Services
- Contact

## Before publishing
Please replace these placeholders in `lib/main.dart`:
- `facebookUrl`
- `tiktokUrl`

The WhatsApp number is currently set exactly as supplied:
`+27774443166`


## Run locally

```bash
flutter pub get
flutter run -d chrome
```

## Build for production

```bash
flutter build web --release
```

The production files will be in `build/web`.

## Publish with GitHub Pages

You can use GitHub Actions or another deployment service to publish `build/web`.

## Publish with Firebase Hosting

Install Firebase CLI, then:

```bash
firebase login
firebase init hosting
firebase deploy
```

When prompted for the Flutter web framework, choose Flutter Web if the CLI offers it.

## Domain

Suggested brand domains to check:
- mamarema.co.za
- mamaremahealing.co.za
- mamaremaspiritual.co.za
- mamaremahealer.com

Availability must be checked before purchase.
