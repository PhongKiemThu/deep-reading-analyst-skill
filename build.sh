#!/bin/bash
# Build script for Deep Reading Analyst skill
# This script packages the source files into a .skill file (ZIP archive)

set -e  # Exit on error

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}Building Deep Reading Analyst skill...${NC}"

# Check if src directory exists
if [ ! -d "src/deep-reading-analyst" ]; then
    echo "Error: src/deep-reading-analyst directory not found"
    exit 1
fi

# Create a temporary build directory
BUILD_DIR=$(mktemp -d)
echo "Using temporary directory: $BUILD_DIR"

# Copy source files to build directory
cp -r src/deep-reading-analyst "$BUILD_DIR/"

# Change to build directory and create the archive
cd "$BUILD_DIR"
zip -r deep-reading-analyst.skill deep-reading-analyst/ -q

# Move the built file back to project root
mv deep-reading-analyst.skill "$OLDPWD/"

# Clean up
cd "$OLDPWD"
rm -rf "$BUILD_DIR"

# Show file size and contents
echo -e "${GREEN}✓ Build successful!${NC}"
echo ""
echo "Output: deep-reading-analyst.skill"
echo "Size: $(ls -lh deep-reading-analyst.skill | awk '{print $5}')"
echo ""
echo "Contents:"
unzip -l deep-reading-analyst.skill

echo ""
echo -e "${GREEN}Skill package is ready for distribution!${NC}"
