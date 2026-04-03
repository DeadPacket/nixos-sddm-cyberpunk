# NixOS SDDM Cyberpunk Theme (Debugging Project)

## Overview
This project documents the process of integrating and debugging a custom SDDM cyberpunk theme within a declarative NixOS environment. The goal was to create a fully reproducible and customizable login experience while maintaining system stability and adhering security best practices.

## Objectives
- Deploy a custom SDDM theme on NixOS
- Maintain reproducability using declarative configuration
- Debug dependency and path-related issues within the NixOS ecosystem
- Maintain a secure and clean system configuration suitable for public sharing

## Technologies Used
- NixOS (Declarative System Configuration)
- SDDM (Simple Desktop Display Manager)
- Qt / QML (Theme Framework)
- i3 Window Manager
- Git (Version Control)

## What Was Attempted
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
     - Endured proper installation path: $out/share/sddm/themes/cyberpunk

3. Path & Reproducibility Issues
     - Initial configuration referenced absolute paths (/etc/nixos/...)
     - Refactored toward project-contained structure for portability

4. SDDM Theme Fallback Behavior
     - Debugged fallback to default theme due to missing sddm-greeter
     - Investigated nixos systemd logs: journalctl - display-manager -b

## Security Considerations
This repository has been intentionally sanitized to avoid exposing sensitive information.
- Removed or Avoided"
     - SSH Keys
     - API Keys
     - Users
     - Passwords
     - Private Tokens
     - VPN Account Details

- Replaced system-specific files via .gitignore:
     - hardware-configuration.nix
     - secrets.nix
     - result

- Key Principle
     - Public infrastructure code should be reproducible WITHOUT exposing sensitive information

## Project Structure
nixos-sddm-cyberpunk/
- .gitignore
- configuration-public.nix
- README.md
- sddm-config.txt
- sddm-debug.log
- themes
     - cyberpunk/
	- Main.qml
	- theme.conf

## Current Status
The theme integration process exposed multiple complexeties related to:
- Nix Store Immutability
- SDDM Runtime Expectations
- Qt Dependency Management

This Project is currently archived for future iteration, with plans to explore:
- greetd + Custom Greeter (Greeter Flexibility & Control)
- Wayland-Native Login Environments
- Fully Custom UI Pipelines

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
