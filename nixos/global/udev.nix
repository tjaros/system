{
  users.groups.chipwhisperer = {};
  users.groups.chipwhisperer.members = ["tjaros"];

  users.groups.pulseaudio = {};
  users.groups.pulseaudio.members = ["tjaros"];

  services.udev.extraRules = ''
        # USB-Blaster
        SUBSYSTEM=="usb", ATTR{idVendor}=="09fb", ATTR{idProduct}=="6001", MODE="0666"
        SUBSYSTEM=="usb", ATTR{idVendor}=="09fb", ATTR{idProduct}=="6002", MODE="0666"
        SUBSYSTEM=="usb", ATTR{idVendor}=="09fb", ATTR{idProduct}=="6003", MODE="0666"
        # USB-Blaster II
        SUBSYSTEM=="usb", ATTR{idVendor}=="09fb", ATTR{idProduct}=="6010", MODE="0666"
        SUBSYSTEM=="usb", ATTR{idVendor}=="09fb", ATTR{idProduct}=="6810", MODE="0666"


        # chipwhisperer

        SUBSYSTEMS=="usb", ATTRS{idVendor}=="2b3e", ATTRS{idProduct}=="*", MODE="0664", GROUP="chipwhisperer"
        SUBSYSTEM=="tty", ATTRS{idVendor}=="2b3e", ATTRS{idProduct}=="*", MODE="0664", GROUP="chipwhisperer", SYMLINK+="cw_serial%n"
        SUBSYSTEM=="tty", ATTRS{idVendor}=="03eb", ATTRS{idProduct}=="6124", MODE="0664", GROUP="chipwhisperer", SYMLINK+="cw_bootloader%n"

        SUBSYSTEM=="tty", ATTRS{idVendor}=="03eb", ATTRS{idProduct}=="6124", MODE="0664", GROUP="chipwhisperer", SYMLINK+="cw_bootloader%n"
        # KMonad user access to /dev/uinput
        SUBSYSTEM="input", MODE="0660", GROUP="input"

        # NXP Device access
        SUBSYSTEM=="hidraw", KERNEL=="hidraw*", ATTRS{idVendor}=="0d28", MODE="0666"
        SUBSYSTEM=="hidraw", KERNEL=="hidraw*", ATTRS{idVendor}=="1fc9", MODE="0666"
        SUBSYSTEM=="hidraw", KERNEL=="hidraw*", ATTRS{idVendor}=="15a2", MODE="0666"

        # Fastboot access
        SUBSYSTEM=="usb", ATTRS{idVendor}=="0d28", MODE="0666"
        SUBSYSTEM=="usb", ATTRS{idVendor}=="1fc9", MODE="0666"
        SUBSYSTEM=="usb", ATTRS{idVendor}=="15a2", MODE="0666"


    # STLINK
    # STM32 nucleo boards, with onboard st/linkv2-1
    # ie, STM32F0, STM32F4.
    # STM32VL has st/linkv1, which is quite different

    SUBSYSTEMS=="usb", ATTRS{idVendor}=="0483", ATTRS{idProduct}=="374a", \
        MODE:="0666", \
        SYMLINK+="stlinkv2-1_%n"

    SUBSYSTEMS=="usb", ATTRS{idVendor}=="0483", ATTRS{idProduct}=="374b", \
        MODE:="0666", \
        SYMLINK+="stlinkv2-1_%n"

    SUBSYSTEMS=="usb", ATTRS{idVendor}=="0483", ATTRS{idProduct}=="3752", \
        MODE:="0666", \
        SYMLINK+="stlinkv2-1_%n"

    # STLink V3SET in Dual CDC mode
    SUBSYSTEMS=="usb", ATTRS{idVendor}=="0483", ATTRS{idProduct}=="3752", \
        MODE:="0666", \
        SYMLINK+="stlinkv3_%n"

    # STLink V3SET in Dual CDC mode
    SUBSYSTEMS=="usb", ATTRS{idVendor}=="0483", ATTRS{idProduct}=="3753", \
        MODE:="0666", \
        SYMLINK+="stlinkv3_%n"

    # STLink V3SET MINIE
    SUBSYSTEMS=="usb", ATTRS{idVendor}=="0483", ATTRS{idProduct}=="3754", \
        MODE:="0666", \
        SYMLINK+="stlinkv3_%n"

    # STLink V3SET
    SUBSYSTEMS=="usb", ATTRS{idVendor}=="0483", ATTRS{idProduct}=="374d", \
        MODE:="0666", \
        SYMLINK+="stlinkv3_%n"

    # STLink V3SET
    SUBSYSTEMS=="usb", ATTRS{idVendor}=="0483", ATTRS{idProduct}=="374e", \
        MODE:="0666", \
        SYMLINK+="stlinkv3_%n"

    # STLink V3SET in normal mode
    SUBSYSTEMS=="usb", ATTRS{idVendor}=="0483", ATTRS{idProduct}=="374f", \
        MODE:="0666", \
        SYMLINK+="stlinkv3_%n"

    # STLink V3PWR
    SUBSYSTEMS=="usb", ATTRS{idVendor}=="0483", ATTRS{idProduct}=="3757", \
        MODE:="0666", \
        SYMLINK+="stlinkv3_%n"


    # STM32 discovery boards, with onboard st/linkv2
    # ie, STM32L, STM32F4.
    # STM32VL has st/linkv1, which is quite different

    SUBSYSTEMS=="usb", ATTRS{idVendor}=="0483", ATTRS{idProduct}=="3748", \
        MODE:="0666", \
        SYMLINK+="stlinkv2_%n"


    # STM32 discovery boards, with onboard st/linkv1
    # ie, STM32VL

    SUBSYSTEMS=="usb", ATTRS{idVendor}=="0483", ATTRS{idProduct}=="3744", \
        MODE:="0666", \
        SYMLINK+="stlinkv1_%n"


  '';
}
