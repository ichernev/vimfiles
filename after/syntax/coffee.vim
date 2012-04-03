syntax match coffeeConstructor +constructor:+
syntax match coffeeKeywords +module\.exports\|module\|exports+
syntax match coffeeJsError +===+
hi link coffeeConstructor Operator
hi link coffeeKeywords Operator
hi link coffeeJsError Error
