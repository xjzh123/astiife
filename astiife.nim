## AST IIFE for nim. Generate code with AST.

import macros

macro ast*(body: untyped): untyped =
  let name = genSym(nskMacro, "iife")

  quote do:
    macro `name`(): untyped =
      `body`
    `name`()

when isMainModule:
  var x = 1

  ast:
    quote do:
      echo x

  ast:
    quote do:
      proc foo() {.used.} =
        echo 1

  foo()

  ast:
    result = newStmtList()
    for i in ["", "8", "16", "32", "64"]:
      for j in ["int", "uint"]:
        let t = ident(j & i)
        let s = newLit(j & i)
        result.add:
          quote do:
            proc bar(it: `t`) {.used.} =
              echo `s`

  bar(1)
  bar(1'u8)
