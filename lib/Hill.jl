module Hill 

export hill_eqn, ligand_concentrations

function ligand_concentrations()
    collect(range(start=0.0, stop=2.5e-3, length=100))
end

function hill_eqn(ka::Float64, n::Float64)
    function hill(ligand_concentration)
        ligand_concentration^n / (ka^n + ligand_concentration^n)
    end
    hill.(ligand_concentrations())
end

end