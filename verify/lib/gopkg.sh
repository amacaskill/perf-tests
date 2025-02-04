#!/bin/bash

# Copyright 2020 The Kubernetes Authors.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

set -euo pipefail

# Find all directories with go.mod file,
# exluding go.mod from vendor/ and _logviewer
MODULE_BASED=$(find . -type d -name vendor -prune \
  -o -type f -name go.mod -printf "%h\n" \
  | sort -u)

# Find all directrories with vendor/ directory
VENDOR_BASED=$(find . -type d -name vendor -printf "%h\n" | sort -u)

# There might be an overlap between $MODULE_BASED and $VENDOR_BASED.
# Find vendor only
VENDOR_ONLY=$(comm -13 \
  <(echo $MODULE_BASED | tr " " "\n") \
  <(echo $VENDOR_BASED | tr " " "\n"))
