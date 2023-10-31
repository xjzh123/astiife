# ASTIIFE

AST IIFE for nim. Generate code with AST.

Example:

```nim
import astiife

ast:
  result = newStmtList()
  for i in ["", "8", "16", "32", "64"]:
    for j in ["int", "uint"]:
      let t = ident(j & i)
      let s = newLit(j & i)
      result.add:
        quote do:
          proc echoIntType(it: `t`) {.used.} =
            echo `s`
```
