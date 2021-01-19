#!/usr/bin/env python3

from migen import *
from migen.genlib.io import CRG
from migen.genlib.cdc import MultiReg

import nexys4ddr

from litex.soc.integration.soc_core import *
from litex.soc.integration.builder import *
from litex.soc.interconnect.csr import *

from litex.soc.cores import gpio
from module import rgbled
from module import sevensegment
from module import vgacontroller


# BaseSoC ------------------------------------------------------------------------------------------

class BaseSoC(SoCCore):
    def __init__(self):
        platform = nexys4ddr.Platform()
        # SoC with CPU
        SoCCore.__init__(self, platform,
                         cpu_type="picorv32",  # the cpu type
                         clk_freq=100e6,  #configure frequency of the SOC (max 100e-6)
                         integrated_rom_size=0x9000,  #configure ROM Size (max unknown)
                         integrated_main_ram_size=16 * 1024) #configure memory available(max is 128mib) => check LiteX DRAM

        # Clock Reset Generation
        self.submodules.crg = CRG(platform.request("clk100"), ~platform.request("cpu_reset"))

        # Leds
        SoCCore.add_csr(self, "leds")
        user_leds = Cat(*[platform.request("led", i) for i in range(16)])
        self.submodules.leds = gpio.GPIOOut(user_leds)

        # Switchs
        SoCCore.add_csr(self, "switchs")
        user_switchs = Cat(*[platform.request("sw", i) for i in range(16)])
        self.submodules.switchs = gpio.GPIOIn(user_switchs)

        # Buttons
        SoCCore.add_csr(self, "buttons")
        user_buttons = Cat(*[platform.request("btn%c" % c) for c in ['c', 'd', 'u', 'r', 'l']])
        self.submodules.buttons = gpio.GPIOIn(user_buttons)

        # RGB leds
        SoCCore.add_csr(self, "led16")
        self.submodules.led16 = rgbled.RGBLed(platform.request("led", 16))

        SoCCore.add_csr(self, "led17")
        self.submodules.led17 = rgbled.RGBLed(platform.request("led", 17))

        # 7segments Display
        SoCCore.add_csr(self, "display")
        display_segments = Cat(*[platform.request("display_segment", i) for i in range(8)])
        display_digits = Cat(*[platform.request("display_digit", i) for i in range(8)])
        self.submodules.display = sevensegment.SevenSegment(display_segments, display_digits)

        # VGA
        SoCCore.add_csr(self, "vga_cntrl")
        vga_red = Cat(*[platform.request("vga_red", i) for i in range(4)])
        vga_green = Cat(*[platform.request("vga_green", i) for i in range(4)])
        vga_blue = Cat(*[platform.request("vga_blue", i) for i in range(4)])
        self.submodules.vga_cntrl = vgacontroller.VGAcontroller(platform.request("hsync"), platform.request("vsync"),
                                                                vga_red, vga_green, vga_blue)


# Build --------------------------------------------------------------------------------------------
if __name__ == "__main__":
    builder = Builder(BaseSoC())
    builder.build()
