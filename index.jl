module Index
using GenieFramework
@genietools

function ui()
    [
        a("Hill Equation", href = "/hill")
    ]
    
end

@page("/", ui)
end
