syntax match coffeeConstructor +constructor:+
syntax match coffeeKeywords +module\.exports\|module\|exports+
hi link coffeeConstructor Operator
hi link coffeeKeywords Operator
