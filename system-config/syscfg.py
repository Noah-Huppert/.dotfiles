#!/usr/bin/env python3

import logging
import sys
import distro

DISTRO_ARCH = 'Arch Linux'

def main() -> int:
    # Setup logger
    logger = logging.getLogger('syscfg')

    logger.setLevel(logging.DEBUG)

    hndlr = logging.StreamHandler(sys.stdout)
    hndlr.setFormatter(logging.Formatter("%(name)s [%(levelname)s]: %(message)s"))

    logger.addHandler(hndlr)

    # Determine operating system
    if sys.platform != 'linux':
        logger.error("tool can only run on linux")
        return 1

    # Determine linux distribution
    distro_info = distro.linux_distribution()
    distro_name = None

    if 'Arch Linux' in distro_info:
        distro_name = DISTRO_ARCH

    logger.debug(distro_name)

    return 0

if __name__ == '__main__':
    sys.exit(main())
