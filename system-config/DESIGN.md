# Design
System configuration design.

# Table Of Contents
- [Overview](#overview)
- [Operating Systems](#operating-systems)
- [Modules](#modules)
- [Actions](#actions)
- [Configuration](#configuration)

# Overview
The system configuration tool completely sets up my linux environment.  

*Modules* handle the configuration of an individual piece of the system.  

*Actions* change the state of the system. They are used in *modules* to 
complete configuration. Some *actions* must modify the state of the system in 
different ways depending on the operating system.  

*Configuration* can be used to modify the details of how a *module* sets up 
a system.

# Operating Systems
This tool is designed to work on linux exclusively.  

Currently [Arch Linux](http://archlinux.org/) is the only supported linux 
distribution.  

However the tool is designed to handle different distributions in the future.  

To support a new linux distribution some actions would have to be modified to 
use distribution specific commands (ex: a different package manager `pacman` 
vs `apt`).

# Modules
A module should provide the following functions:

- Check
    - Determine if a module has already configured the part of the system it 
        is responsible for
- Run
    - Run actions to configure system
- Remove
    - Remove the configuration the module provided
    - Some modules can not complete this step

# Actions
An action can accept arguments. Some actions will do different things based on 
the linux distribution.

# Configuration
TODO
