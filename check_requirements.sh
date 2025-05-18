#!/bin/bash

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}=== Arch Linux Installer - System Requirements Check ===${NC}"
echo

# Check if running as root
if [[ $EUID -ne 0 ]]; then
   echo -e "${RED}✗ This script must be run as root${NC}"
   exit 1
else
   echo -e "${GREEN}✓ Running as root${NC}"
fi

# Check if booted in UEFI mode
if [[ -d /sys/firmware/efi/efivars ]]; then
    echo -e "${GREEN}✓ UEFI mode detected${NC}"
else
    echo -e "${YELLOW}! BIOS mode detected${NC}"
fi

# Check internet connectivity
if ping -c 1 archlinux.org &> /dev/null; then
    echo -e "${GREEN}✓ Internet connection available${NC}"
else
    echo -e "${RED}✗ No internet connection${NC}"
    echo "  Please connect to the internet before continuing"
    exit 1
fi

# Check available memory
total_mem=$(grep MemTotal /proc/meminfo | awk '{print $2}')
total_mem_mb=$((total_mem / 1024))
if [[ $total_mem_mb -lt 512 ]]; then
    echo -e "${RED}✗ Insufficient memory (${total_mem_mb}MB)${NC}"
    echo "  At least 512MB RAM is required"
    exit 1
else
    echo -e "${GREEN}✓ Memory check passed (${total_mem_mb}MB)${NC}"
fi

# Check CPU architecture
arch=$(uname -m)
if [[ "$arch" == "x86_64" ]]; then
    echo -e "${GREEN}✓ 64-bit CPU architecture${NC}"
else
    echo -e "${RED}✗ Unsupported CPU architecture: $arch${NC}"
    echo "  This installer requires x86_64"
    exit 1
fi

# Check available disk space
echo
echo -e "${YELLOW}Available disks:${NC}"
lsblk -d | grep -E 'disk|rom' | awk '{print "  " $1 " - " $4}'
echo

# Check for required commands
commands=("fdisk" "mkfs.ext4" "mkfs.fat" "pacstrap" "arch-chroot" "genfstab")
missing_commands=()

for cmd in "${commands[@]}"; do
    if ! command -v $cmd &> /dev/null; then
        missing_commands+=($cmd)
    fi
done

if [[ ${#missing_commands[@]} -eq 0 ]]; then
    echo -e "${GREEN}✓ All required commands are available${NC}"
else
    echo -e "${RED}✗ Missing commands: ${missing_commands[*]}${NC}"
    echo "  Please install the missing tools before continuing"
    exit 1
fi

echo
echo -e "${GREEN}All checks passed! You can proceed with the installation.${NC}"
echo -e "${YELLOW}Remember: This installer will ERASE the selected disk!${NC}"
echo