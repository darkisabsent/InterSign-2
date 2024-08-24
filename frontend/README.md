## Application Installation Guide

Welcome! This guide will walk you through the installation process for the Flutter desktop application.

## Prerequisites
Before you begin, make sure you have the following installed on your development machine:

- [Flutter SDK](https://flutter.dev/docs/get-started/install)
- [Git](https://git-scm.com/downloads)
- [Visual Studio](https://visualstudio.microsoft.com/downloads/) with the "Desktop development with C++" workload (for Windows desktop development)

## Building From Source
Follow the [official Flutter guide for building Windows desktop apps ](https://docs.flutter.dev/get-started/install/windows/desktop) to set up your environment.

## Confirm The Set Up
- After setting up the environment, open a terminal or command prompt.
   ```bash
   flutter doctor
   ```
- This command checks your environment and displays a summary of any issues or missing dependencies.
- Ensure that all checks, particularly for Visual Studio - develop for Windows, show a green checkmark (✅).

## Check For Desktop Device Availability
- Run the following command to list all available devices:
   ```bash
   flutter devices
   ```
## Install the Application
1. **Clone the Repository:**
   ```bash
   https://github.com/darkisabsent/InterSign-2.git
   ```

2. **Move to the directory containing the Flutter code and switch to the main branch**
   ```bash
   cd frontend
   ```
   ```bash
   git switch main
   ```

3. **Get Dependencies:**
   ```bash
   flutter pub get
   ```

4. **Run the App:**
- Ensure that Desktop support is enabled.
- Run the following command:
  ```
  flutter run
  ```