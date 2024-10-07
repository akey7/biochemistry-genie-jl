module App
using Printf
using Main.Hill
using GenieFramework
using PlotlyBase
@genietools

function hill_eqn_trace(hill_coeff)
    [PlotlyBase.scatter(x = ligand_concentrations(), y = hill_eqn(1.0e-3, hill_coeff))]
end

function hill_eqn_layout(hill_coeff)
    hill_coeff_formatted = round(hill_coeff, digits = 2)

    xtick_vals = range(minimum(ligand_concentrations()), maximum(ligand_concentrations()), length=5)
    xtick_text = [@sprintf("%.2e", xtick_val) for xtick_val ∈ xtick_vals]

    ytick_vals = range(0.0, 1.0, length = 5)
    ytick_text = [@sprintf("%.2f", yt) for yt ∈ ytick_vals]

    PlotlyBase.Layout(
        title = "n = $hill_coeff_formatted",
        yaxis = attr(
            tickmode = "array",
            tickvals = ytick_vals,
            ticktext = ytick_text,
            range = [0.0, 1.0], 
            title = "Fraction of Sites Bound"
        ),
        xaxis = attr(
            tickmode = "array",
            tickvals = xtick_vals,
            ticktext = xtick_text,
            range = [minimum(ligand_concentrations()), maximum(ligand_concentrations())],
            title = "[L]",
        ),
    )
end

@app begin
    @out trace2 = hill_eqn_trace(1.0)
    @out layout2 = hill_eqn_layout(1.0)
    @in hill_coeff_in = 1.0
    @out hill_coeff_out = 1.0

    @onchange hill_coeff_in begin
        hill_coeff_out = round(hill_coeff_in, digits = 2)
        trace2 = hill_eqn_trace(hill_coeff_in)
        layout2 = hill_eqn_layout(hill_coeff_in)
    end
end

function ui()
    row([
        cell(
            class = "st-col col-6",
            [
                h4("Hill Equation"),
                p("Select value for Hill coefficient (n):"),
                slider(range(start = 0.1, stop = 4.0, length = 20), :hill_coeff_in),
                p("Hill coefficient: {{hill_coeff_out}}"),
                plot(:trace2, layout = :layout2),
            ],
        ),
    ])
end


@page("/", ui)
end
