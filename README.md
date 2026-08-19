# AIApparel
Welcome to AIApparel, a Flutter-based mobile application designed to inspire users and help them declutter their wardrobe. By leveraging the power of AI and modern app development frameworks, smart wardrobe management, and inspiring new styles of clothing.

# Features
Inspiration for Outfits: Get daily outfit suggestions tailored to your style preferences.

Wardrobe Management: Easily organize, categorize, and declutter your wardrobe.

AI-Powered Recommendations: Utilize Google ML Kit to image label, text extract items of clothing.

Firebase Integration: Seamlessly sync your data across devices and access it anytime.

# Tech Stack
Flutter: A UI toolkit for building natively compiled applications for mobile, web, and desktop from a single codebase.

GetX: A powerful, high-performance framework for managing state, navigation, and dependencies in Flutter applications.

Firebase: A comprehensive app development platform that provides tools for app backend, storage, authentication, and real-time databases.

Google ML Kit: A machine learning SDK that enables developers to incorporate smart features like image labeling and text recognition.

# Setup

# Flutter SDK
git clone https://github.com/flutter/flutter.git -b stable

echo 'export PATH="$HOME/flutter/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc

flutter doctor

# Download and install Google Chrome for Linux
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo apt update && sudo apt install -y ./google-chrome-stable_current_amd64.deb
rm google-chrome-stable_current_amd64.deb

# Enable web support in Flutter
flutter config --enable-web

# Remove old locks if corrupted
rm -f pubspec.lock

flutter clean
flutter pub get

# run
flutter run -d chrome