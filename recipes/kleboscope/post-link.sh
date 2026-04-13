#!/bin/bash
# post-link.sh – run database.sh scripts for MLST and AMR

set -e

# Use CONDA_PREFIX if set, otherwise fallback to PREFIX (conda build environment)
if [ -n "$CONDA_PREFIX" ]; then
    PREFIX="$CONDA_PREFIX"
fi

# Find the site-packages directory for the current Python
SITE_PACKAGES=$(python -c "import site; print(site.getsitepackages()[0])" 2>/dev/null || echo "")

if [ -z "$SITE_PACKAGES" ]; then
    # Fallback: try to find it manually
    SITE_PACKAGES="$PREFIX/lib/python*/site-packages"
    # Expand the wildcard
    SITE_PACKAGES=$(ls -d $SITE_PACKAGES 2>/dev/null | head -1)
fi

if [ -z "$SITE_PACKAGES" ] || [ ! -d "$SITE_PACKAGES" ]; then
    echo "ERROR: Could not locate site-packages directory"
    exit 1
fi

KLEBO_DIR="$SITE_PACKAGES/kleboscope"
if [ ! -d "$KLEBO_DIR" ]; then
    echo "ERROR: kleboscope package not found at $KLEBO_DIR"
    exit 1
fi

echo "Kleboscope installed at: $KLEBO_DIR"

# Run MLST database download
MLST_MODULE="$KLEBO_DIR/modules/kleb_mlst_module"
if [ -f "$MLST_MODULE/database.sh" ]; then
    echo "Updating MLST database..."
    (cd "$MLST_MODULE" && bash database.sh)
else
    echo "Warning: MLST database.sh not found"
fi

# Run AMR database download
AMR_MODULE="$KLEBO_DIR/modules/kleb_amr_module"
if [ -f "$AMR_MODULE/database.sh" ]; then
    echo "Updating AMR database..."
    (cd "$AMR_MODULE" && bash database.sh)
else
    echo "Warning: AMR database.sh not found"
fi

echo "Kleboscope databases setup complete."
