#!/bin/bash
# post-link.sh – download MLST and AMR databases after installation

set -e

# Find the installed package location
PACKAGE_DIR=$(cd "$(dirname "$0")/../lib/python*/site-packages/kleboscope" && pwd)

if [ -d "$PACKAGE_DIR/modules/kleb_mlst_module" ]; then
    echo "Updating MLST database..."
    (cd "$PACKAGE_DIR/modules/kleb_mlst_module" && bash database.sh)
else
    echo "Warning: MLST module not found at $PACKAGE_DIR/modules/kleb_mlst_module"
fi

if [ -d "$PACKAGE_DIR/modules/kleb_amr_module" ]; then
    echo "Updating AMR database..."
    (cd "$PACKAGE_DIR/modules/kleb_amr_module" && bash database.sh)
else
    echo "Warning: AMR module not found at $PACKAGE_DIR/modules/kleb_amr_module"
fi

echo "Kleboscope databases setup complete."
