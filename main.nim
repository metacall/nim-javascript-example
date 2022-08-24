import metacall

if initialize() != 0:
    quit(1)

# Load a script from a buffer
let tag = "node"
let script = "module.exports = { add: (a, b) => a + b };"
if load_from_memory(tag.cstring, script, len(script).csize_t, nil) != 0:
    quit(2)

# Initialize call arguments
let args: array[2,pointer] = [
    value_create_double(3.0),
    value_create_double(6.0)
]
let name = "add"

# Invoke the function add of NodeJS
var result = v_s(name.cstring, args.unsafeAddr, 2)

# Clear arguments
value_destroy(args[0])
value_destroy(args[1])

let resultd = value_to_double(result)

# Check if the result value is correct
if resultd != 9.0:
    quit(3)

echo "Result: " & $resultd

# Clear result value
value_destroy(result)

# Destroy MetaCall
if destroy() != 0:
    quit(4)
