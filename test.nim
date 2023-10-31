import macros
import astiife

import std/[strscans, cmdline]

from math import `^`

var
  a, b: int
  op: char

proc someOp(input: string, op: var char, start: int): int =
  if input[start] in {'+','-','*','/','^'}:
    op = input[start]
    1
  else:
    quit("No op")

let params = commandLineParams()

let arg =
  if params.len > 0:
    params[0]
  else:
    when not defined(js):
      stdin.readLine()
    else:
      quit("Empty argument")

if not scanf(arg, "$i${someOp}$i", a, op, b):
  quit("Invalid expression")

ast:
  result = nnkIfStmt.newNimNode()
  for op2 in {'+','-','*','/','^'}:
    for a2 in 0..10:
      for b2 in 0..10:
        var ans = nnkStrLit.newNimNode()
        ans.strVal =
          case op2
          of '+':
            $(a2 + b2)
          of '-':
            $(a2 - b2)
          of '*':
            $(a2 * b2)
          of '/':
            if b2 == 0:
              continue
            $(a2.float / b2.float)
          of '^':
            $(a2.int64 ^ b2.int64)
          else:
            continue
        result.add nnkElifBranch.newTree(
          quote do: (op == `op2` and a == `a2` and b == `b2`),
          quote do: echo `ans`
        )
  result.add nnkElifBranch.newTree(
    quote do: quit("Operand too big or invalid")
  )
