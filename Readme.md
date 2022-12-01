
# Makefile Template

This repo contains Makefile template with J-Link scripts(flash and erase). Base Makefile was taken from STM32CubeMX software and little changes were made:
- It uses G++ instead GCC.
- Added support for `.cpp` files.
- Makefile config variables are placed on the top of Makefile.
- `flash` and `erase` commands were added. They create J-Link script for each action.
- Different memory usage report after build.