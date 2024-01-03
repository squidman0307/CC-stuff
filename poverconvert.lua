local convert = {}

function convert.tfe(eu)
    local fe = eu * 4
    return fe
end

function convert.teu(fe)
    local eu = fe / 4
    return eu
end


return convert
