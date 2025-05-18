#!/bin/bash

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}=== Checking for missing packages ===${NC}"
echo

# Get current installed packages
pacman -Qqe | sort > /tmp/installed_packages.txt

# Get packages from apps.csv
cut -d',' -f2 /home/benjamin/workspace/arch_installer/apps.csv | sort | uniq > /tmp/apps_csv_packages.txt

# Find missing packages
missing_count=$(comm -23 /tmp/installed_packages.txt /tmp/apps_csv_packages.txt | wc -l)

echo -e "${YELLOW}Found $missing_count installed packages not in apps.csv${NC}"
echo

# Show categories of missing packages
echo -e "${GREEN}Missing packages by type:${NC}"
echo

echo "System libraries:"
comm -23 /tmp/installed_packages.txt /tmp/apps_csv_packages.txt | grep -E '^lib' | head -10

echo
echo "Development tools:"
comm -23 /tmp/installed_packages.txt /tmp/apps_csv_packages.txt | grep -E '^(gcc|clang|make|cmake|go|cargo)' | head -10

echo
echo "Python packages:"
comm -23 /tmp/installed_packages.txt /tmp/apps_csv_packages.txt | grep -E '^python-' | head -10

echo
echo "AUR packages:"
pacman -Qm | cut -d' ' -f1 | while read pkg; do
    if ! grep -q "^[^,]*,$pkg," /home/benjamin/workspace/arch_installer/apps.csv; then
        echo "$pkg"
    fi
done | head -10

echo
echo -e "${BLUE}To add missing packages to apps.csv, use format:${NC}"
echo "category,package-name,description"
echo
echo -e "${YELLOW}Common categories:${NC}"
echo "essential, network, tools, development, system, python, build, debug, lsp"

# Cleanup
rm -f /tmp/installed_packages.txt /tmp/apps_csv_packages.txt