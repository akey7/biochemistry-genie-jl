module Index
using GenieFramework
@genietools

function ui()
    [
        p(a("Hill Equation", href = "/hill")),
        p(a("Michaelis-Menten", href="/mm")),
        p(a("Linear Pathway Page", href="/linear"))
    ]
    
end

@page("/", ui)
end
