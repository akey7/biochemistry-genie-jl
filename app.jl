module App
using Main.Hill
using GenieFramework, PlotlyBase
@genietools

@app begin
    @out trace2 =
        [PlotlyBase.scatter(x = ligand_concentrations(), y = hill_eqn(1.0e-3, 1.0))]

    @out layout2 = PlotlyBase.Layout(
        title = "n = 1.0",
        yaxis = attr(range = [0, 1], title = "Fraction of Sites Bound"),
        xaxis = attr(
            range = [minimum(ligand_concentrations()), maximum(ligand_concentrations())],
            title = "[L]",
        ),
    )

    @in hill_coeff_in = 1.0
    @out hill_coeff_out = 1.0

    @onchange hill_coeff_in begin
        hill_coeff_out = round(hill_coeff_in, digits = 2)

        trace2 = [
            PlotlyBase.scatter(
                x = ligand_concentrations(),
                y = hill_eqn(1.0e-3, hill_coeff_in),
            ),
        ]
        
        layout2 = PlotlyBase.Layout(title = "n = $hill_coeff_out")
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
