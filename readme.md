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

## Why to make this

I know this provides a very basic feature, but I really see many macros that are used at once to generate some definitions.

```nim
macro foo(x: untyped): untyped =
  # Many lines...

foo()
```

This is not that graceful, is it? So I made this. I know maybe IIFE isn't a very proper name for macros, as IIFE contains a "function" in it. But it's intuitive enough, isn't it?
