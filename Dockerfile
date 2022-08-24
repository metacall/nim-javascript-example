#
#	MetaCall Embedding NodeJS Example by Parra Studios
#	An example of embedding NodeJS into C/C++.
#
#	Copyright (C) 2016 - 2020 Vicente Eduardo Ferrer Garcia <vic798@gmail.com>
#
#	Licensed under the Apache License, Version 2.0 (the "License");
#	you may not use this file except in compliance with the License.
#	You may obtain a copy of the License at
#
#		http://www.apache.org/licenses/LICENSE-2.0
#
#	Unless required by applicable law or agreed to in writing, software
#	distributed under the License is distributed on an "AS IS" BASIS,
#	WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#	See the License for the specific language governing permissions and
#	limitations under the License.
#

FROM nimlang/nim:1.6.6-alpine-slim

# Image descriptor
LABEL copyright.name="Vicente Eduardo Ferrer Garcia" \
	copyright.address="vic798@gmail.com" \
	maintainer.name="Vicente Eduardo Ferrer Garcia" \
	maintainer.address="vic798@gmail.com" \
	vendor="MetaCall Inc." \
	version="0.1"

# Set working directory to home
WORKDIR /root

# Clone and build the project
RUN curl -sL https://raw.githubusercontent.com/metacall/install/master/install.sh | sh

# Copy source files
COPY main.nim metacall.nim /root/
COPY script.js /home/scripts/script.js

# Set up enviroment variables
ENV LOADER_SCRIPT_PATH=/home/scripts

		# -I$METACALL_PATH/include \
		# test.c \
		# -B$(dirname ${LDLIB_PATH}) \
		# -Wl,--dynamic-linker=${LDLIB_PATH} \
		# -Wl,-rpath=${METACALL_PATH}/lib \
		# -L$METACALL_PATH/lib \
		# -lmetacall \

# Build the nim source (and run the executable for testing)
RUN echo "Build and run Nim JavaScript Example" \
	&& export METACALL_PATH="/gnu/store/`ls /gnu/store/ | grep metacall | head -n 1`" \
	&& export LDLIB_PATH="`find /gnu/store/ -type f -wholename '*-glibc-*/lib/ld-*.so' | head -n 1`" \
	&& nim c \
		--cincludes:${METACALL_PATH}/include \
		--passL="-B$(dirname ${LDLIB_PATH})" \
		--passL="-Wl,--dynamic-linker=${LDLIB_PATH}" \
		--passL="-Wl,-rpath=${METACALL_PATH}/lib" \
		--clibdir:${METACALL_PATH}/lib -r main.nim \
	&& ./main

CMD [ "/root/main" ]
