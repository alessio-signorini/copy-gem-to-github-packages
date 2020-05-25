#!/usr/bin/env sh
set -eu

/fetch.sh && /repack.sh && /push.sh && /cleanup.sh