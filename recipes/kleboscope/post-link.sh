#!/bin/bash
# post-link.sh – download MLST and AMR databases after installation

set -e

# Find the site-packages directory of the conda environment
CONDA_PREFIX=${CONDA_PREFIX:-$PREFIX}
if [ -z "$CONDA_PREFIX" ]; then
    echo "ERROR: CONDA_PREFIX not set. Cannot locate kleboscope installation."
    exit 1
fi

# Locate the kleboscope package inside site-packages
SITE_PACKAGES=$(find "$CONDA_PREFIX/lib" -type d -name "site-packages" | head -1)
if [ -z "$SITE_PACKAGES" ]; then
    echo "ERROR: Could not find site-packages in $CONDA_PREFIX"
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
    echo "Warning: MLST database.sh not found at $MLST_MODULE"
fi

# Run AMR database download
AMR_MODULE="$KLEBO_DIR/modules/kleb_amr_module"
if [ -f "$AMR_MODULE/database.sh" ]; then
    echo "Updating AMR database..."
    (cd "$AMR_MODULE" && bash database.sh)
else
    echo "Warning: AMR database.sh not found at $AMR_MODULE"
fi

echo "Kleboscope databases setup complete."
