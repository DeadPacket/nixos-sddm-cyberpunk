# NixOS SDDM Cyberpunk Login Theme 
A custom SDDM login theme built and debugged within a fully declarative NixOS environment.

## Overview
This project documents the process of integrating and debugging a custom SDDM cyberpunk theme within a declarative NixOS environment. The goal was to create a fully reproducible and customizable login experience while maintaining system stability and adhering security best practices.

## Objectives
- Deploy a custom SDDM theme on NixOS
- Maintain reproducibility using declarative configuration
- Debug dependency and path-related issues within the NixOS ecosystem
- Maintain a secure and clean system configuration suitable for public sharing

## Screenshots
- Default State
  - ![SDDM Login Screen](./Screenshots/sddm_login_screen.png)
- Active Login State
  - ![SDDM Login Screen Active](./Screenshots/sddm_login_screen-active.png)

## Technologies Used
- NixOS (Declarative System Configuration)
- SDDM (Simple Desktop Display Manager)
- Qt / QML (Theme Framework)
- i3 Window Manager
- Git (Version Control)

## Implemented
- Packaged theme using 'stdenv.mkDerivation'
- Configured SDDM with custom theme
- Resolved Qt dependency issues
- Debugged theme loading failures

## Key Challenges
This project involved troubleshooting several non-trivial issues:
1. Dependency Resolution (Qt Packages)
   - Encountered missing Qt modules (qtquickcontrols, qtquickcontrols2)
   - Resolved by identifying correct package namespaces within kdePackages and Qt6

2. Theme Packaging in Nix Store
   - Crafted a custom derivation using stdenv.mkDerivation
   - Ensured proper installation path: $out/share/sddm/themes/cyberpunk

3. Path & Reproducibility Issues
   - Initial configuration referenced absolute paths (/etc/nixos/...)
   - Refactored toward project-contained structure for portability

4. SDDM Theme Fallback Behavior
   - Debugged fallback to default theme due to missing sddm-greeter
   - Investigated nixos systemd logs: journalctl - display-manager -b

## Security Considerations
This repository has been intentionally sanitized to avoid exposing sensitive information.
1. Removed or Avoided
   - SSH Keys
   - API Keys
   - User-Specific Data
   - Passwords
   - Private Tokens
   - VPN Account Details

2. Replaced system-specific files via .gitignore:
   - hardware-configuration.nix
   - secrets.nix
   - result

3. Key Principle
   - Public infrastructure code should be reproducible WITHOUT exposing sensitive information

## Real-World Relevance
This project reflects real-world Linux engineering tasks:
  - Debugging display manager failures in production systems
  - Managing UI frameworks (Qt/QML) within controlled environments
  - Integrating system services with user-facing components
  - Building reproducible infrastructure using declarative configuration
These skills directly apply to enterprise Linux, infrastructure engineering, and system reliability roles.

## Project Structure
nixos-sddm-cyberpunk/
  - .gitignore
  - configuration-public.nix
  - README.md
  - sddm-config.txt
  - sddm-debug.log
  - screenshot/
	- sddm_login_screen.png
	- sddm_login_screen-active.png
  - themes/
    - cyberpunk/
	- Main.qml
	- theme.conf

## Project Outcome
This project exposed key challenges in:
  - Nix Store Immutability
  - SDDM Runtime Expectations
  - Qt Dependency Management
These insights informed a transition to a more minimal and secure login architecture using greetd.

## Lessons Learned
- Declarative systems require strict alignment between config and filesystem state
- Debugging in NixOS often involves understanding evaluation vs runtime behavior
- Reproducibility is not automatic, therefore, must be designed intentionally
- Security and configurability must be balanced carefully

## Future Work
- Transition to greetd with a custom greeter UI
- Implement a fully themed login environment without SDDM limitations
- Expand into system hardening and secure configuration management

## Portfolio Reference
This Project Demonstrates:
  - Linux System Engineering (NixOS)
  - Debugging Complex Dependency Chains
  - Infrastructure-As-Code Practices
  - Security-Conscious Configuration Design
  - Persistence Through Iterative Problem Solving

## Acknowledgements
- NixOS Documentation & Community Resources
- Open-Source Contributors to SDDM & Qt Ecosystem

## Next Steps
Based on the limitations encountered with SDDM, I designed a minimal and security-focused login system using greetd:
[NixOS greetd Cyberpunk Login System](https://github.com/DeadPacket/nixos-greetd-cyberpunk)
