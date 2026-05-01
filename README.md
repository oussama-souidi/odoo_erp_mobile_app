# Odoo ERP Mobile Application 

Flutter mobile client for Odoo ERP with modules for purchases, sales, inventory, production, and billing. The app provides authentication and a dashboard with quick access to business workflows.

## Project Context

This app targets Odoo users who need quick mobile access to operational data such as orders, invoices, stock, and production. It connects to an Odoo server via RPC, authenticates users, and then queries Odoo models to populate each module screen.

## Features

- Login and session handling
- Dashboard and navigation
- Modules: achats, articles, facturation, partenaires, production, stock, ventes
- Android, iOS, web, and desktop targets via Flutter

## Requirements

- Flutter SDK
- Android Studio or Xcode for device/emulator setup

## Project Structure

- [lib/main.dart](lib/main.dart): App entry point
- [lib/pages](lib/pages): Screens (login, home, dashboard)
- [lib/modules](lib/modules): Business modules
- [lib/components](lib/components): Shared UI components
- [assets/images](assets/images): Image assets

## Architecture Overview

- App entry and routing: `lib/main.dart` initializes the app, checks the session, and routes to login or home.
- Session handling: Login stores session data in secure storage and restores it on app start.
- Feature modules: Each module screen fetches data from Odoo using `odooClient.callKw` and renders lists/cards.
- UI components: Reusable widgets live under `lib/components`.
- Data flow: UI widgets call RPC methods directly in the module pages. There is no separate data layer yet.

## Setup

1. Install dependencies:

	```bash
	flutter pub get
	```

2. Run the app on a device or emulator:

	```bash
	flutter run
	```

## Build

- Android APK:

  ```bash
  flutter build apk
  ```

- iOS (macOS only):

  ```bash
  flutter build ios
  ```

- Web:

  ```bash
  flutter build web
  ```

## Tests

```bash
flutter test
```

## Configuration

The Odoo server URL, database, and credentials are currently set in the login flow. If you move them into a config file or environment setup, document it here and keep secrets out of version control.

## Key Dependencies

- `odoo_rpc`: Odoo authentication and data access
- `flutter_secure_storage`: Session persistence
- `shared_preferences`: Lightweight local storage (optional in code)
- `http`: Generic HTTP calls
- `flutter_screenutil`: Responsive sizing
- `pdf`, `path_provider`, `open_filex`, `permission_handler`: PDF generation and file access
- `fluttertoast`: Toast notifications
- `encrypt`: Local encryption utilities
