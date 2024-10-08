module Index
using GenieFramework
@genietools

function ui()
    [
        p(a("Hill Equation", href = "/hill")),
        a("Michaelis-Menten", href="/mm")
    ]
    
end

@page("/", ui)
end
