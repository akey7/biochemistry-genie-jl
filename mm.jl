module HillEqnPage
using Printf
using Main.MichaelisMenten
using GenieFramework
using PlotlyBase
@genietools

@app begin
    
end

function mm_ui()
    [
        a("Return to demonstration list", href = "/"),
        h4("Michaelis-Menten")
    ]
end

@page("/mm", mm_ui)
end