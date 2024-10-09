module LinearPathwayPage

using GenieFramework
using Main.LinearPathway

@genietools

@app begin
    initial_config = fig_5a_defaults()
    initial_input_2_off_minute = step_to_minutes(initial_config[:input_2_turn_off_step])
    initial_input_2_on_minute = step_to_minutes(initial_config[:input_2_turn_on_step])

    @in Range_r = RangeData(initial_input_2_off_minute:initial_input_2_on_minute)

    @out input_2_off_minute = 10
    @out input_2_on_minute = 60

    @onchange Range_r begin
        input_2_off_minute = Range_r["min"]
        input_2_on_minute = Range_r["max"]
    end
end

function ui()
    [
        a("Return to demonstration list", href = "/"),
        h4("Linear pathway!"),
        p("Select Input 2 availability (in minutes):"),
        GenieFramework.range(5:5:90, :Range_r, label = true),
        p("Off: {{input_2_off_minute}} On: {{input_2_on_minute}}")
    ]
    
end

@page("/linear", ui)
end
