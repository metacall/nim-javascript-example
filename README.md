# MetaCall Nim JavaScript Example

This example shows how to embed JavaScript into Nim using MetaCall. In other words, calling JavaScript functions from Nim. The instructions are focused on Linux but it can be ported to other platforms easily.

## Dependencies

For this example we will use Linux distribution, which includes its own ld and this will require some extra flags at compile time for Nim. If you are installing MetaCall in a different way, probably you won't need those flags. Just link `libmetacall` from whenever you have it and use it with Nim.

```sh
curl -sL https://raw.githubusercontent.com/metacall/install/master/install.sh | sh
```

For additional install information, check out: https://github.com/metacall/core/blob/develop/docs/README.md#41-installation

## Build

Note: MetaCall Nim Port is not published in `nimble` yet. So you have to download the port manually and use it. This would be a nice **TODO**, but for now we use the `metacall.nim` file copied directly from the `metacall/core` repository.

For building, clone the Nim/JavaScript example and build it.

```sh
git clone https://github.com/metacall/nim-javascript-example.git
cd nim-javascript-example
export METACALL_PATH="/gnu/store/`ls /gnu/store/ | grep metacall | head -n 1`"
export LDLIB_PATH="`find /gnu/store/ -type f -wholename '*-glibc-*/lib/ld-*.so' | head -n 1`"
nim c \
	--cincludes:${METACALL_PATH}/include \
	--passL="-B$(dirname ${LDLIB_PATH})" \
	--passL="-Wl,--dynamic-linker=${LDLIB_PATH}" \
	--passL="-Wl,-rpath=${METACALL_PATH}/lib" \
	--clibdir:${METACALL_PATH}/lib -r main.nim
```

## Run

From repository root directory, run the following commands:

```bash
export LOADER_SCRIPT_PATH="`pwd`"
./main
```

## Docker

Building and running with Docker:

```bash
docker build -t metacall/nim-javascript-example .
docker run --rm -it metacall/nim-javascript-example
```
