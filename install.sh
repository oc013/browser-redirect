#!/bin/bash

THIS_DIR="$(dirname "$0")"

PROGRAM_NAME="browser-redirect.sh"
REDIRECT_MATCHES_FILE="${HOME}/browser-redirect-matches.txt"
TARGET_DESKTOP_DIR_PATH="${HOME}/.local/share/applications"
SOURCE_DESKTOP_FILE_PATH="${THIS_DIR}/browser-redirect.desktop"
TEMPLATE_DESKTOP_FILE_PATH="${THIS_DIR}/browser-redirect.template.desktop"
INSTALL_DIR="${HOME}/.local/bin"

# Create matches file if it doesn't exist
if [ ! -f "${REDIRECT_MATCHES_FILE}" ]; then
    touch "${REDIRECT_MATCHES_FILE}"
fi

# Make install directory
if [ ! -d "${INSTALL_DIR}" ]; then
    mkdir -p "${INSTALL_DIR}"
fi

cp "${THIS_DIR}/${PROGRAM_NAME}" "${INSTALL_DIR}/${PROGRAM_NAME}"

sed "s|€ExecCommand€|${INSTALL_DIR}/${PROGRAM_NAME} %u|g" "${TEMPLATE_DESKTOP_FILE_PATH}" > "${SOURCE_DESKTOP_FILE_PATH}"

# Installs icons to /.local/share/icons/hicolor/512x512/apps/browser-redirect.png
xdg-icon-resource install --novendor --size 16 icons/16/browser-redirect.png
xdg-icon-resource install --novendor --size 32 icons/32/browser-redirect.png
xdg-icon-resource install --novendor --size 64 icons/64/browser-redirect.png
xdg-icon-resource install --novendor --size 128 icons/128/browser-redirect.png
xdg-icon-resource install --novendor --size 256 icons/256/browser-redirect.png
xdg-icon-resource install --novendor --size 512 icons/512/browser-redirect.png

# Installs .desktop file to $HOME/.local/share/applications/
desktop-file-install --dir="${TARGET_DESKTOP_DIR_PATH}" --rebuild-mime-info-cache "${SOURCE_DESKTOP_FILE_PATH}"

# Refresh desktop database
update-desktop-database "${TARGET_DESKTOP_DIR_PATH}"

echo "Install complete!"
echo "Add matches you wish to redirect to the alternative browser in the file ${REDIRECT_MATCHES_FILE}"
echo "Go to Settings > Default Applications > Web and choose \"Browser Redirect\""
