# System Configure
Tool for configuring a Linux system.

# Table Of Contents
- [Overview](#overview)
- [Supported Operating Systems](#supported-operating-systems)
- [Module Structure](#module-structure)
- [Helpers](#helpers)

# Overview
System configure organizing different aspects of configuration into *modules*.  

Modules are installed in a specific order and may even require reboots.

Run the system configure script by executing the `syscfg` file.

# Supported Operating Systems
Currently only Arch Linux is supported.  

The `SYSCFG_OS` environment variable will be set to a specific value based on
the OS. For Arch Linux it will be set to `arch`. In this future this 
environment variable can be used to execute different behavior based on the 
OS.

# Module Structure
Modules are located in the [`modules/`](modules/) directory. Each module has 
its own sub-folder.

The [`modules/modules-order.txt`](modules/modules-order.txt) file contains the 
directory names of the modules to run. Modules will be executed in the order 
they appear in this file.

Each module has a `run` and `verify` script. These files can be any type of 
executable.

The `run` script should execute the module configuration steps. The `verify` 
script should determine if the module has been run successfully. 

The `run` script should exit with an exit code of zero if it succeeds. The 
`verify` script should output `OK` if a module is successfully verified. If an
error occurs while verifying a module the `verify` script should exit with a 
non zero exit code.

# Helpers
Helpers are utility scripts which perform common actions. Such as installing a
package.

These helpers can use the `SYSCFG_OS` environment variable to execute different 
behavior based on the OS. Like using a different package manager.  

TODO: OS dependant configuration
