# bsp - Radxa BSP Build Tool

[![Build](https://github.com/radxa-repo/bsp/actions/workflows/build.yml/badge.svg)](https://github.com/radxa-repo/bsp/actions/workflows/build.yml)

`bsp` aims to provide a standardized way to build Linux kernel and U-Boot for Radxa boards, so the build output can be easliy included in our image generation pipeline.


```shell
cd output
../bsp --no-prepare-source linux rockchip -r 1

Parameter Description:
--no-prepare-source # Compile using local modifications. If this parameter is not added, the latest code will be synchronized from the Radxa kernel warehouse and the local modifications will be overwritten.

-r 1 # Specify the kernel version number as 1
```