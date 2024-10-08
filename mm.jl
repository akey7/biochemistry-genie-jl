module MichaelisMentenPage
using Printf
using Main.MichaelisMenten
using GenieFramework
using PlotlyBase
@genietools

function mm_trace()
    [PlotlyBase.scatter(x = substrate_concentrations(), y = mm_eqn(vmax_cache, km_cache))]
end

function mm_layout()
    km_formatted = @sprintf("%.2e", km_cache)
    vmax_formatted = @sprintf("%.2e", vmax_cache)
    max_vmax = 3.0e-3

    xtick_vals = range(
        minimum(substrate_concentrations()),
        maximum(substrate_concentrations()),
        length = 5
    )
    xtick_text = [@sprintf("%.2e", xtick_val) for xtick_val ∈ xtick_vals]

    ytick_vals = range(0.0, max_vmax, length=5)
    ytick_text = [@sprintf("%.2e", yt) for yt ∈ ytick_vals]

    PlotlyBase.Layout(
        title = "Vmax=$vmax_formatted, Km=$km_formatted",
        yaxis = attr(
            tickmode = "array",
            tickvals = ytick_vals,
            ticktext = ytick_text,
            range = [0.0, max_vmax],
            title = "V (M / min)"
        ),
        xaxis = attr(
            tickmode = "array",
            tickvals = xtick_vals,
            ticktext = xtick_text,
            range = [minimum(substrate_concentrations()), maximum(substrate_concentrations())],
            title = "[S] (M)"
        )
    )
end

@app begin
    vmax_midpoint = (minimum(vmax_range()) + maximum(vmax_range())) / 2.0
    km_midpoint = (minimum(km_range()) + maximum(km_range())) / 2.0
    set_vmax_cache(vmax_midpoint)
    set_km_cache(km_midpoint)
    @in vmax_in = vmax_midpoint
    @in km_in = km_midpoint
    @out layout = mm_layout()
    @out trace = mm_trace()

    @onchange km_in begin
        set_km_cache(km_in)
        trace = mm_trace()
        layout = mm_layout()
    end

    @onchange vmax_in begin
        set_vmax_cache(vmax_in)
        trace = mm_trace()
        layout = mm_layout()
    end
end

function mm_ui()
    vmax_min = minimum(vmax_range())
    vmax_max = maximum(vmax_range())
    km_min = minimum(km_range())
    km_max = maximum(km_range())

    [
        a("Return to demonstration list", href = "/"),
        h4("Michaelis-Menten"),
        p("Select a Vmax:"),
        slider(
            range(start = vmax_min, stop = vmax_max, length = 20),
            :vmax_in,
            labelalways = true,
        ),
        p("Select a Km:"),
        slider(
            range(start = km_min, stop = km_max, length = 20),
            :km_in,
            labelalways = true,
        ),
        plot(:trace, layout=:layout)
    ]
end

@page("/mm", mm_ui)
end