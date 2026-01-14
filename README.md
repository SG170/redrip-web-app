ReDrip ♻️
ReDrip is a sustainable fashion marketplace designed to reduce textile waste by giving pre-loved clothes a second life. Built with Flutter and Firebase, it connects eco-conscious sellers with buyers looking for unique, thrifted style.

🌟 Key Features
Eco-Impact Tracking: View your personal sustainability stats, including water and waste saved by thrifting.

Role-Based Access: Specialized interfaces for Buyers (to browse and shop) and Sellers (to list and manage inventory).

Real-time Database: Powered by Cloud Firestore for instant product updates and user management.

Secure Authentication: Integrated with Firebase Auth for safe email-based login and registration.

Category Filtering: Easy navigation through Men, Women, Kids, and Formal wear.

🛠️ Tech Stack
Frontend: Flutter (v3.x)

State Management: Provider

Backend: Firebase (Auth & Firestore)

Design: Material 3

🚀 Getting Started
Prerequisites
FlutLab.io account or local Flutter SDK.

A Firebase Project.

Installation & Setup
Clone the Repository (or upload your files to FlutLab).

Firebase Configuration:

Create a Web App in your Firebase Console.

Enable Email/Password in Authentication.

Create a Firestore Database in Test Mode.

Update API Keys: Open lib/main.dart and replace the placeholder FirebaseOptions with your actual keys:

Dart

options: const FirebaseOptions(
  apiKey: "YOUR_API_KEY",
  authDomain: "redrip-app.firebaseapp.com",
  projectId: "redrip-app",
  appId: "YOUR_APP_ID",
  // ... other keys
)
Register Assets: Ensure your logo is registered in pubspec.yaml:

YAML

flutter:
  assets:
    - assets/logo.png
Run the App: Click the "Run" button in FlutLab.

📂 Project Structure
Plaintext

lib/
├── models/          # Data classes (Product, User)
├── screens/
│   ├── auth/        # Login and Register screens
│   ├── buyer/       # Home, Categories, and Profile views
│   └── seller/      # Seller Dashboard and Product Upload
├── services/        # Firebase Auth and Firestore logic
└── widgets/         # Reusable UI components (ProductCard, etc.)
📜 Firestore Security Rules
To ensure the app can read and write data during development, use the following rules:

JavaScript

rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /{document=**} {
      allow read, write: if request.time < timestamp.date(2026, 2, 15);
    }
  }
