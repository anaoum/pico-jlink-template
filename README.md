# Raspberry Pi Pico/J-Link/CMake/VSCode Template

This repository contains a sample project for programming the Raspberry Pi Pico (and all RP2040-based boards) using the following tool stack:
* [Raspberry Pi Pico SDK](https://github.com/raspberrypi/pico-sdk)
* [CMake](https://cmake.org)
* [J-Link](https://www.segger.com/products/debug-probes/j-link/)
* [Visual Studio Code](https://code.visualstudio.com)
    * [Cortex-Debug](https://marketplace.visualstudio.com/items?itemName=marus25.cortex-debug)
    * [CMake Tools](https://marketplace.visualstudio.com/items?itemName=ms-vscode.cmake-tools)
    * [C/C++ Tools](https://marketplace.visualstudio.com/items?itemName=ms-vscode.cpptools)
* [Arm GNU Toolchain](https://developer.arm.com/tools-and-software/open-source-software/developer-tools/gnu-toolchain)

As is, this template project is Mac-specific. However, little would need to change for use on other operating systems. Specifically just the paths contained in `.envrc`. I provide the Mac-specific instructions for installing dependencies below.

## Mac Dependencies

If not already installed, install [Homebrew](https://brew.sh):
```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

Use the following commands to install CMake, direnv, the Arm GNU Toolchain, VSCode, and the required VSCode extensions:
```bash
brew install cmake direnv
brew tap ArmMbed/homebrew-formulae
brew install arm-none-eabi-gcc
brew install --cask visual-studio-code

code --install-extension marus25.cortex-debug
code --install-extension ms-vscode.cmake-tools
code --install-extension ms-vscode.cpptools
```

In order to install J-Link tools, download and install the appropriate package of [J-Link Software and Documentation Pack](https://www.segger.com/downloads/jlink/#J-LinkSoftwareAndDocumentationPack).

## Usage

You will need to allow the `.envrc` file to be run using:
```bash
direnv allow
```
The .envrc file defines the `PICO_SDK_PATH`, as well as some variables used when interacting with J-Link: `JL_DEVICE` and `JL_SPEED` (set to `RP2040_M0_0` and `15000` by default).

### Visual Studio Code

Open the project folder using:
```bash
code .
```

If you have not used CMake Tools in VSCode before, you will be prompted to select the correct Kit. In our case, this is `arm-none-eabi-gcc` located in `/opt/homebrew/bin`. For more information, see the relevant documentation about [CMake Tools Kits](https://vector-of-bool.github.io/docs/vscode-cmake-tools/kits.html).

You should now be able to build the project in VSCode using the relevant CMake commands.

#### VSCode Debugging
The project template includes four Debug launch configurations in .vscode/launch.json:
1. JLink GDB - Starts and connects to a JLinkGDBServer.
2. JLink GDB (RTT) - Starts and connects to a JLinkGDBServer with RTT enabled (output in the VSCode Terminal/RTT pane)
3. JLink GDB (Semihosting) - Starts and connects to a JLinkGDBServer with semihosting enabled (output on telnet port 3334)
4. JLink Flash - Flashes the code using the script `tools/jlink-flash`

### Command Line

To generate makefiles:
```bash
cmake -B build -S .
```

Build:
```bash
make -C build -j8
```

Flash:
```bash
./tools/jlink-flash build/hello.bin
```

For convenience, a Makefile is provided at the root folder to simplify the above commands to:
```bash
make flash
```

#### CLI Debugging

* The script at `tools/jlink-debug` starts a JLinkGDBServer and connects using the GDB command-line interface.
* The script at `tools/jlink-rtt` starts a JLink session and connects a JLinkRTTClient for viewing.
