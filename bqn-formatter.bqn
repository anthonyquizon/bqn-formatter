#!/usr/bin/env bqn

c←•FLines "test.bqn"
[a,b]←⍉>2⊸↑¨c⊔˜¨1⌊+`¨('#'=c)∧¬≠`⊸>¨'"'=c  # separate code (a) and comments (b). Avoid # characters in strings
m←{¬∧´' '⊸=𝕩}¨a                           # remove tail whitespace from code
a↩{⌽(∨`' '⊸≠)⊸/⌽𝕩}¨⌾(m⊸/)a
s←' '¨¨↕¨(m∧(0≠≠¨b)∧0≠≠¨a)×1+(⌈´≠¨a)-≠¨a  # calculate comment prefix whitespace 
•Out 1↓∾∾(@+10)⊸∾¨<˘⍉[a,s∾¨b]             # prepend whitespace and recombine code and comments
