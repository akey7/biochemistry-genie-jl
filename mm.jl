module MichaelisMentenPage
using Printf
using Main.MichaelisMenten
using GenieFramework
using PlotlyBase
@genietools

@app begin
    vmax_midpoint = (minimum(vmax_range()) + maximum(vmax_range())) / 2.0
    km_midpoint = (minimum(km_range()) + maximum(km_range())) / 2.0
    @in vmax_in = vmax_midpoint
    @in km_in = km_midpoint
end

function mm_ui()
    [
        a("Return to demonstration list", href = "/"),
        h4("Michaelis-Menten"),
        p("Select a Vmax:"),
        slider(vmax_range(), :vmax_in, labelalways=true),
        p("Select a Km:"),
        slider(km_range(), :km_in, labelalways=true),
    ]
end

@page("/mm", mm_ui)
end