#!/bin/bash
################################################################################
#
# check-secrets-hook.sh
# ----------------
# A pre-commit hook used to check for SOPS unencrypted yaml files of kind
# secret.
#
# @author Nicholas Wilde, 0x08b7d7a3
# @date 30 Mar 2021
# @version 0.0.1
#
################################################################################

set -e

# OSX GUI apps do not pick up environment variables the same way as Terminal apps and there are no easy solutions,
# especially as Apple changes the GUI app behavior every release (see https://stackoverflow.com/q/135688/483528). As a
# workaround to allow GitHub Desktop to work, add this (hopefully harmless) setting here.
export PATH=$PATH:/usr/local/bin

for f in "$@"; do
  grep -lZRPi '^kind:\s+secret' "$f" | xargs -r0 grep -L 'ENC.AES256'
done
