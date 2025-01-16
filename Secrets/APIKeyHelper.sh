#!/bin/bash
# APIKeyHelper: Paul Solt
# Copy the Secret to our buildable folder so we can set the API key without commiting it to Github
# NOTE: We use this in a build script

# 1) Use the declared input file for the real secret:
SOURCE_FILE="$SCRIPT_INPUT_FILE_0"

# 2) Destination inside the project
DEST_FILE="${PROJECT_DIR}/Secrets/Secret.swift"
TEMPLATE_FILE="${PROJECT_DIR}/Secrets/SecretTemplate.swift"

echo "PROJECT_DIR:  '${PROJECT_DIR}'"
echo "SOURCE_FILE:  '${SOURCE_FILE}'"
echo "DEST_FILE:    '${DEST_FILE}'"

# --------------------------------------------------------
# STEP A: Skip if the file already exists
# --------------------------------------------------------
if [ -f "${DEST_FILE}" ]; then
  echo "Secret file already exists at '${DEST_FILE}'. Skipping copy."
  exit 0
fi

# --------------------------------------------------------
# STEP B: If the user hasn't created a Secret.swift yet,
#         copy from real Secret.swift or the template
# --------------------------------------------------------
if [ -f "${SOURCE_FILE}" ]; then
    echo "Found real secret at: ${SOURCE_FILE}"
    if cp "${SOURCE_FILE}" "${DEST_FILE}"; then
        echo "Copied real secret to ${DEST_FILE}"
    else
        echo "ERROR: Failed to copy ${SOURCE_FILE} → ${DEST_FILE}"
        exit 1
    fi
elif [ -f "${TEMPLATE_FILE}" ]; then
    echo "No real secret found at ${SOURCE_FILE}."
    echo "Using template file to ensure the build doesn't break."
    if cp "${TEMPLATE_FILE}" "${DEST_FILE}"; then
        echo "Copied template to ${DEST_FILE}"
    else
        echo "ERROR: Failed to copy template from ${TEMPLATE_FILE}"
        exit 1
    fi
else
    echo "ERROR: Neither real Secret.swift nor SecretTemplate.swift found."
    exit 1
fi
