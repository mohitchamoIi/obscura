
# Obscurra

Obscurra is an open‑source **Flutter** application (written in Dart) that aims to provide a simple, Linux‑server‑backed VPN client so users can easily spin up and connect to their own privacy‑focused VPN server.

---

## Table of Contents

- [About the project](#about-the-project)
- [Features](#features)
- [Tech stack](#tech-stack)
- [Project structure](#project-structure)
- [Getting started](#getting-started)
  - [Prerequisites](#prerequisites)
  - [Installation](#installation)
  - [Running the app](#running-the-app)
- [Linux VPN server (high level)](#linux-vpn-server-high-level)
- [Configuration](#configuration)
- [Roadmap](#roadmap)
- [Contributing](#contributing)
- [Security & disclaimer](#security--disclaimer)

---

## About the project

Obscurra focuses on a self‑hosted VPN flow: you own the server, and the app is just a clean Flutter UI that talks to that server.  
The goal is to be minimal, transparent, and easy to hack on for anyone learning Flutter, networking, or Linux‑based VPN setups.

---

## Features

- Simple connect / disconnect button for a configured VPN server.  
- Status indicators: connected / disconnected / error.  
- Logs section for basic connection events (planned).  
- Targeted at Linux servers (Ubuntu / Debian / etc.) where you run your own VPN stack.  
- Designed to be open‑source and hackable, not a closed commercial VPN.

---

## Tech stack

- **Client:** Flutter (Dart)  
- **Platforms (initial):** Android (others can be added as plugins allow)  
- **VPN side:** Linux server running a VPN protocol such as WireGuard / OpenVPN / V2Ray (actual protocol choice is pluggable and can evolve)  
- **Architecture goal:** Clean separation of UI, VPN control logic, and configuration so the VPN “engine” can be swapped or extended.

---

## Project structure

> Note: This is the *intended* structure; adjust these names to match your actual directories.

```text
obscura/
├─ lib/
│  ├─ main.dart           # App entry point
│  ├─ ui/                 # Screens, widgets, themes
│  ├─ vpn/                # VPN service integration & logic
│  ├─ config/             # Models and config handling
│  └─ utils/              # Helpers, logging, etc.
├─ android/               # Android native integration
├─ ios/                   # iOS native integration (future)
├─ test/                  # Unit / widget tests
├─ pubspec.yaml           # Flutter/Dart dependencies & metadata
└─ README.md              # You are here
```

---

## Getting started

### Prerequisites

- Flutter SDK installed and on your PATH.  
- A device / emulator to run the app (Android Studio or VS Code with Flutter extension).  
- A Linux server (VPS or bare metal) where you can install and configure a VPN (WireGuard/OpenVPN/etc.).  
- Optional: A domain name pointing to your server for easier configuration.

---

### Installation

Clone the repository:

```bash
git clone https://github.com/mohitchamoIi/obscura.git
cd obscura
```

Fetch dependencies:

```bash
flutter pub get
```

---

### Running the app

Run on a connected device or emulator:

```bash
flutter run
```

If you have multiple devices/emulators:

```bash
flutter devices
flutter run -d <device_id>
```

---

## Linux VPN server (high level)

Obscurra is designed around “bring your own server”. The app expects that you already have (or are setting up) a Linux server with a VPN stack.

A typical high‑level flow could be:

1. **Choose a VPN protocol**  
   - Example: WireGuard, OpenVPN, V2Ray, etc.  
   - Install the corresponding server package on your Linux machine.

2. **Configure the server**  
   - Generate keys / certificates as required by your protocol.  
   - Open the VPN port in your firewall.  
   - Enable IP forwarding and configure routing if you want full‑tunnel VPN.

3. **Create client config**  
   - Generate a client profile / config (key, username/password, config file, etc.).  
   - Map that information into Obscurra’s configuration (IP/host, port, protocol, credentials).

4. **Test from a desktop client** (optional but recommended)  
   - Verify that the VPN works from a standard client (e.g., `wg-quick`, OpenVPN client) before wiring it into Obscurra.

> Detailed, protocol‑specific guides can live in a `docs/` directory or wiki as the project matures.

---

## Configuration

Configuration can be handled in multiple ways; one simple approach is to have a Dart config file or environment‑style values.

Example (pseudo‑config):

```dart
class ObscurraConfig {
  static const String vpnServerHost = "your.server.ip.or.domain";
  static const int vpnServerPort = 51820; // example for WireGuard
  static const String vpnProtocol  = "wireguard"; // or "openvpn", etc.

  // Credentials / keys would ideally NOT be hardcoded in production.
  static const String vpnClientPrivateKey = "<your_client_private_key>";
  static const String vpnClientPublicKey  = "<your_client_public_key>";
}
```

Recommended practices:

- Keep secrets out of version control (use .gitignore and secure storage).  
- Use different configs for development vs production.  
- Consider adding a `config.example.dart` as a template for contributors.

---

## Roadmap

- [ ] Basic connect / disconnect UI with one server profile.  
- [ ] Connection status screen with simple logs.  
- [ ] Support for multiple servers (server list + selection).  
- [ ] Better error handling & user‑friendly messages.  
- [ ] Per‑platform integration improvements (Android, then iOS, then desktop if possible).  
- [ ] Settings screen for advanced options (split tunneling, routing rules, etc.).  
- [ ] Documentation for at least one full Linux VPN setup (e.g., WireGuard on Ubuntu).

Feel free to open an issue or discussion to propose additional features.

---

## Contributing

Contributions, ideas, and feedback are very welcome!

1. **Fork** the repository.  
2. **Create** a feature branch:  
   ```bash
   git checkout -b feature/your-feature-name
   ```  
3. **Commit** your changes with clear messages:  
   ```bash
   git commit -m "Add: short description of change"
   ```  
4. **Push** to your fork:  
   ```bash
   git push origin feature/your-feature-name
   ```  
5. **Open a Pull Request** and describe:
   - What you changed.  
   - How to test it.  
   - Any screenshots or logs if relevant.

Types of contributions:

- Flutter UI/UX improvements.  
- VPN integration (plugins, native bridge code, config handling).  
- Linux server setup scripts or docs.  
- Bug fixes, refactors, tests, and docs.

---

## Security & disclaimer

- This project deals with network traffic and potentially sensitive data.  
-  always audit the code and server configuration before using it in a real environment.  
- Make sure your usage complies with local laws, your ISP’s policies, and the terms of any network you connect through.  
- Do not use this project for illegal activities or to violate any service’s terms of use.

---



```text
Copyright (c) 2025 Mohit Chamoli

```
