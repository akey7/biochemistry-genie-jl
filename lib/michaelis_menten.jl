module MichaelisMenten

export substrate_concentrations, km_range, vmax_range, mm_eqn, set_km_cache, set_vmax_cache, km_cache, vmax_cache

km_cache = 0.0
vmax_cache = 0.0

function set_vmax_cache(vmax)
    global vmax_cache = vmax
end

function set_km_cache(km)
    global km_cache = km
end

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