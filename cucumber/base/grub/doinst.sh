#!/bin/bash

if [ -e usr/lib64 ]; then
	grubdir=usr/lib64/grub
else
	grubdir=usr/lib/grub
fi

# Check if we are using an updatable version of Grub, and enumerate the
# updateable targets.
# THIS IS A BAND-AID FIX. IT WILL BREAK WHEN YOU UPGRADE GRUB TO A NEWER VERSION
targets=""
if diff boot/grub/i386-pc/boot.img $grubdir/i386-pc/boot.img; then
	targets+=" i386-pc"
fi
if diff boot/grub/i386-efi/boot.mod $grubdir/i386-efi/boot.mod; then
	targets+=" i386-efi"
fi
if diff boot/grub/x86_64-efi/boot.mod $grubdir/x86_64-efi/boot.mod; then
	targets+=" x86_64-efi"
fi

echo Updating Grub modules for: $targets

# Copy the updated files
for target in $targets; do
	for file in $(ls boot/grub/$target); do
		cp -v $grubdir/$target/$file boot/grub/$target/
	done
done

