#!/bin/bash

##
# Copyright IBM Corporation 2016
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
##

# This script clones and builds the Kitura sample app.

# If any commands fail, we want the shell script to exit immediately.
set -e

# Clone and build Kitura
# The Git branch to clone should be set as an environment variable.
# If branch environment var is not set, then using develop as the default value.
if [ -z "$KITURA_BRANCH" ]; then
  KITURA_BRANCH="master"
fi

echo ">> About to clone branch '$KITURA_BRANCH' for Kitura-TodoList"
# Clone Kitura repo
cd /root && rm -rf Kitura-TodoList && git clone -b $KITURA_BRANCH https://github.com/IBM-Swift/Kitura-TodoList.git

# Make the Kitura folder the working directory
cd /root/Kitura-TodoList

# Build Kitura
echo ">> About to build Kitura-TodoList..."
swift build --fetch
CC_FLAGS="-Xcc -fblocks"
for MODULE_MAP in `find /root/Kitura-TodoList/Packages -name module.modulemap`;
do
  CC_FLAGS+=" -Xcc -fmodule-map-file=$MODULE_MAP"
done
echo ">> CC_FLAGS: $CC_FLAGS"
swift build $CC_FLAGS
echo ">> Build for Kitura-TodoList completed (see above for results)."
