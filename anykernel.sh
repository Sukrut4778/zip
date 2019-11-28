# AnyKernel2 Ramdisk Mod Script
# osm0sis @ xda-developers

## AnyKernel setup
# EDIFY properties
kernel.string=Pikachu KERNEL
do.devicecheck=1
do.modules=1
do.cleanup=1
do.system=1
do.initd=1
do.cleanuponabort=0
device.name1=rosy

# shell variables
block=/dev/block/platform/soc/7824900.sdhci/by-name/boot;
is_slot_device=0;

## AnyKernel methods (DO NOT CHANGE)
# import patching functions/variables - see for reference
. /tmp/anykernel/tools/ak2-core.sh;

# Check for MIUI
is_miui="$(file_getprop /system/build.prop 'ro.miui.ui.version.code')"
if [[ -z $is_miui ]]; then
    ui_print "You are running a custom ROM"
    rm -rf /tmp/anykernel/modules

# If the kernel image and dtbs are separated in the zip
decompressed_image=/tmp/anykernel/kernel/Image.gz-dtb
compressed_image=$decompressed_image.gz-dtb
if [ -f $compressed_image ]; then

  # Concatenate all of the dtbs to the kernel
  rm sdm450-qrd_rosy.dtb
  mv  /tmp/anykernel/dtbs/sdm450-qrd_rosy_aosp.dtb sdm450-qrd_rosy.dtb
  cat $compressed_image /tmp/anykernel/dtbs/sdm450-qrd_rosy.dtb > /tmp/anykernel/Image.gz-dtb;
fi;

else
    ui_print "You are running MIUI"

# If the kernel image and dtbs are separated in the zip
decompressed_image=/tmp/anykernel/kernel/Image.gz-dtb
compressed_image=$decompressed_image.gz-dtb
if [ -f $compressed_image ]; then

  # Concatenate all of the dtbs to the kernel
  rm sdm450-qrd_rosy_aosp.dtb
  mv  /tmp/anykernel/dtbs/sdm450-qrd_rosy.dtb sdm450-qrd_rosy_aosp.dtb
  cat $compressed_image /tmp/anykernel/dtbs/sdm450-qrd_rosy_aosp.dtb > /tmp/anykernel/Image.gz-dtb;
fi;
fi

## AnyKernel install
dump_boot;

write_boot;

## end install

