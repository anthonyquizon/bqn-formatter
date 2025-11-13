# BQN Formatter (bf)

Formats BQN code into two separate columns for code and comments

Before:

<img width="707" alt="Screenshot 2024-07-17 at 12 14 51 pm" src="https://github.com/user-attachments/assets/ed1ef835-cace-4b81-b609-192972b423c2">

After:

<img width="939" alt="Screenshot 2024-07-17 at 12 15 09 pm" src="https://github.com/user-attachments/assets/593c06bf-1a90-4f0b-9089-ebceb29f3d14">


---

Vim example:
```vim
fu FmtBQN() 
    let c=join(getline(1, '$'), "\n")
    let t=tempname()
    let f=<<EOF 
    c←•FLines "/dev/stdin"
    [a,b]←⍉>2⊸↑¨c⊔˜¨1⌊+`¨('#'=c)∧¬≠`⊸>¨'"'=c  # separate code (a) and comments (b). Avoid # characters in strings
    m←{¬∧´' '⊸=𝕩}¨a                           # remove tail whitespace from code
    a↩{⌽(∨`' '⊸≠)⊸/⌽𝕩}¨⌾(m⊸/)a
    s←' '¨¨↕¨(m∧(0≠≠¨b)∧0≠≠¨a)×1+(⌈´≠¨a)-≠¨a  # calculate comment prefix whitespace 
    •Out 1↓∾∾(@+10)⊸∾¨<˘⍉[a,s∾¨b]             # prepend whitespace and recombine code and comments
EOF
    call writefile(f, t)
    let o = system('bqn '. t, c)
    call setline(1, split(o, "\n",1))
    call delete(t)
endf
nor <leader>ff :call FmtBQN()<CR>
```
