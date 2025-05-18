#!/bin/bash

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}=== Arch Installer Package Summary ===${NC}"
echo

# Count packages by category
echo -e "${GREEN}Packages by category:${NC}"
cut -d',' -f1 /home/benjamin/workspace/arch_installer/apps.csv | sort | uniq -c | sort -nr

echo
echo -e "${YELLOW}Total packages:${NC}"
wc -l < /home/benjamin/workspace/arch_installer/apps.csv

echo
echo -e "${GREEN}AUR packages:${NC}"
grep -c "(AUR)" /home/benjamin/workspace/arch_installer/apps.csv

echo
echo -e "${BLUE}Latest additions:${NC}"
tail -10 /home/benjamin/workspace/arch_installer/apps.csv | cut -d',' -f2,3