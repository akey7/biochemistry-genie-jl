module MichaelisMenten

export substrate_concentrations, km_range, vmax_range, mm_eqn

function substrate_concentrations()
    collect(range(start=0, stop=0.1, length=100))
end

function km_range()
    range(start=1.0e-3, stop=1.0e-2, length=20)
end

function vmax_range()
    range(start=1.0e-3, stop=3.0e-3, length=20)
end

function mm_eqn(vmax, km)
    function mm(substrate_concentration)
        vmax * substrate_concentration / (km + substrate_concentration)
    end
    mm.(substrate_concentrations())
end

end