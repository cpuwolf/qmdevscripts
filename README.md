
## Project Overview

**qmdevscripts** is a Lua‑based framework for controlling USB HID hardware devices and bridging them with flight simulators (X-Plane 11/12 and Microsoft Flight Simulator 2020/2024).

The repository contains:

- Shared Lua device framework and object model
- Per‑aircraft configuration scripts for X-Plane
- Per‑aircraft configuration scripts for Microsoft Flight Simulator

## Main Features

- **Lua scripting for hardware control**: All device behavior is defined in Lua.
- **Support for multiple simulators**:
  - X-Plane 11 / 12
  - Microsoft Flight Simulator 2020 / 2024
- **Hardware abstraction layer**: Common Lua classes abstract each physical device so that aircraft profiles focus only on mapping and logic.
- **Reusable core library**: Shared base classes under `com/` are reused across both simulators.

## Supported Hardware

The framework supports multiple QuickMade hardware devices, including but not limited to:

1. **QGMC710** – General aviation / Hotstart TBM-900 style controller
2. **QMCP737C** – MCP panel for Boeing 737 family (ZIBO, Level-up, MAX, IXEG, Flightfactor, etc.)
3. **QCDU B737/A320** – CDU/FMS units for Boeing 737 and Airbus A320 families
4. **QG1K PFD/MFD** – G1000 glass cockpit (PFD / MFD)
5. **QFCU** – Airbus A320 FCU style controller (Flightfactor, Toliss, JARDesign, etc.)

## Repository Layout

The current folder structure is:

- **`xp/`** – X-Plane 11/12 aircraft‑specific Lua configuration files  
  Each file typically represents one hardware–aircraft combination (for example `QMCP737C_ZIBO738.lua`).
- **`msfs/`** – Microsoft Flight Simulator 2020/2024 aircraft‑specific Lua configuration files  
  For example `QMCP737C_PMDG737.lua`, `QFCU_PMDG_777.lua`, etc.
- **`com/oop/`** – Lightweight object‑oriented helpers for Lua  
  - `Object.lua` – base object implementation  
  - `class.lua` – helper for defining classes  
  - `include.lua` – simple module include helper  
  - `package.lua` – package and module loading helper
- **`com/sim/`** – Shared simulator‑agnostic core
  - `Qmdev.lua` – core device base class used by all hardware
  - `QmReload.lua` – helper for reloading / resetting configurations
  - `com/sim/qm/` – concrete hardware abstraction classes (QMCP737C, QFCU, QCDU, QGMC710, QG1K, QMPE, QMOVH, etc.), shared by both X-Plane and MSFS profiles

> Additional API documentation is available in the QuickMade wiki:  
> `https://github.com/cpuwolf/Quickmadedevice/wiki/Qmdev-.lua-files`

### File Naming Convention

Lua profile files follow this pattern:

```
<hardware_name>_<aircraft_model_name>.lua
```

For example: `QMCP737C_ZIBO738.lua` means “QMCP737C hardware mapped for the ZIBO 737‑800 aircraft”.

## Core Architecture

1. **Hardware abstraction classes** – Implemented under `com/sim/qm/`, one class per hardware family.
2. **Per‑aircraft profiles** – Located in `xp/` and `msfs/`, each file binds a specific aircraft to a specific hardware class.
3. **Data reference system** – The `iDataRef` helper (see the Lua API developer guide) manages reading and tracking simulator datarefs / simvars.
4. **Configuration API** – Methods such as `CfgEncFull`, `CfgCmd`, `CfgVal`, `CfgTog`, `CfgRpn`, etc., are used to map encoders, buttons and LEDs to simulator functions.

## Main Capabilities

- **Encoder configuration** – Heading, altitude, speed, V/S, baro and other rotary controls.
- **Button mapping** – Map hardware buttons to simulator commands, RPN scripts or custom Lua functions.
- **Display and LED handling** – Drive numeric displays and indicators from simulator data.
- **Multi‑platform** – The same core device classes can be reused for both X-Plane and MSFS.
- **Modular design** – Each hardware–aircraft pair is isolated in its own Lua profile file.

## Recommended VSCode Extensions

To make Lua development and collaboration easier, it is recommended to use Visual Studio Code with:

1. **Lua language support**
   - [Lua by sumneko](https://marketplace.visualstudio.com/items?itemName=sumneko.lua)  
     Provides syntax highlighting, IntelliSense, debugging and linting for Lua, suitable for this project.

## What This Project Is

This repository is essentially a **hardware driver and configuration framework** that lets flight‑sim enthusiasts use real‑world style hardware (MCP, CDU, FCU, G1000, etc.) to control aircraft inside the simulator, providing a more immersive and realistic cockpit experience.