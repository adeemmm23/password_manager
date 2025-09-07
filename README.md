# 🔐 Password Manager

A secure, modern password manager built with Flutter that helps you store, generate, and manage your passwords with military-grade encryption.

## 📱 Preview

<div align="center">
  <img src=".github/1.png" width="200" alt="Authentication Screen" />
  <img src=".github/2.png" width="200" alt="Home Screen" />
  <img src=".github/3.png" width="200" alt="Password Generator" />
  <img src=".github/4.png" width="200" alt="Settings Screen" />
</div>

## ✨ Features

### 🔒 **Security First**

- **AES Encryption**: Military-grade encryption for all stored passwords
- **Biometric Authentication**: Fingerprint and face unlock support
- **Master Key Protection**: Single master password to access all your data
- **Local Storage**: All data stored locally on your device - no cloud dependency

### 🎯 **Core Functionality**

- **Password Storage**: Securely store passwords for websites and applications
- **Password Generator**: Generate strong, customizable passwords with:
  - Configurable length (6-20 characters)
  - Numbers, uppercase letters, and special characters
  - Real-time password strength indicator
- **Organized Collections**: Group passwords by website/application
- **Quick Access**: Fast search and retrieval of stored credentials

### 🎨 **User Experience**

- **Material Design 3**: Modern, intuitive interface
- **Dark/Light Themes**: Support for both light and dark modes
- **Customizable Colors**: Multiple color schemes to personalize your experience
- **Smooth Animations**: Fluid transitions and micro-interactions
- **Cross-Platform**: Works on Android, iOS, and Web

### 🔧 **Advanced Features**

- **Import/Export**: Backup and restore your password database
- **Password Validation**: Real-time password strength checking
- **Copy to Clipboard**: Quick password copying with security notifications
- **Auto-Lock**: Automatic app locking for enhanced security

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (>=3.2.3)
- Android Studio / VS Code
- Android/iOS device or emulator

### Installation

1. **Clone the repository**

   ```bash
   git clone https://github.com/adeemmm23/password_manager.git
   cd password_manager
   ```

2. **Install dependencies**

   ```bash
   flutter pub get
   ```

3. **Set up environment variables**
   Create a `.env` file in the root directory:

   ```env
   ENCRYPTION_KEY=your_32_character_encryption_key_here
   ENCRYPTION_IV=your_16_character_iv_here
   ```

4. **Run the app**

   ```bash
   flutter run
   ```

## 🏗️ Project Structure

```
lib/
├── main.dart                 # Application entry point
├── router.dart              # Navigation configuration
├── components/              # Reusable UI components
├── features/               # Feature-based organization
│   ├── authentication/     # Login and biometric auth
│   └── home/              # Main app screens
│       ├── passwords/     # Password management
│       └── settings/      # App settings
├── global/                # Global state and constants
└── utils/                 # Utility functions
    ├── password_generator.dart
    ├── passwords_storage.dart
    └── validators.dart
```

## 🔐 Security Architecture

### Encryption

- **Algorithm**: AES-256 encryption
- **Key Management**: Environment-based key storage
- **Data Protection**: All passwords encrypted before storage

### Authentication Flow

1. **Biometric Check**: Attempt biometric authentication first
2. **Master Key Fallback**: Use master password if biometric fails
3. **Session Management**: Secure session handling with auto-lock

### Data Storage

- **Local Only**: No data transmitted to external servers
- **Encrypted Storage**: All sensitive data encrypted at rest
- **Secure Preferences**: Using Flutter's secure storage mechanisms

## 🛠️ Dependencies

### Core Dependencies

- **flutter_bloc**: State management
- **go_router**: Navigation and routing
- **encrypt**: AES encryption implementation
- **local_auth**: Biometric authentication
- **shared_preferences**: Local data persistence

### UI Dependencies

- **material_symbols_icons**: Modern icon set
- **flutter_native_splash**: Custom splash screen
- **flutter_launcher_icons**: App icon configuration

### Utility Dependencies

- **file_picker**: Import/export functionality
- **url_launcher**: External link handling
- **crypto**: Cryptographic operations
- **flutter_dotenv**: Environment variable management

## 📋 Usage

### Adding a New Password

1. Tap the **+** button on the passwords screen
2. Select or enter a website/application name
3. Enter your username/email
4. Generate a secure password or enter your own
5. Save to securely store the credentials

### Generating Passwords

- Use the built-in generator for strong passwords
- Customize length and character types
- Real-time strength indicator
- One-tap copy to clipboard

### Managing Collections

- Passwords are automatically grouped by website
- Tap any collection to view all accounts
- Long-press to copy passwords quickly
- Organized view with account counts

### Security Features

- Enable biometric unlock in settings
- Regular auto-lock when app is backgrounded
- Export/import for backup purposes
- Master key change functionality

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- Flutter team for the amazing framework
- Material Design team for the design system
- Open source community for the excellent packages

## 📞 Support

If you encounter any issues or have questions:

- Create an issue on GitHub
- Check the documentation
- Review the FAQ section

---

**⚠️ Security Notice**: This app stores sensitive data. Always use a strong master password and enable biometric authentication when available. Regular backups are recommended.
