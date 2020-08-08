#=
This file is part of the replication code for: Hasenzagl, T., Pellegrino, F., Reichlin, L., & Ricco, G. (2020). A Model of the Fed's View on Inflation.
Please cite the paper if you are using any part of the code for academic work (including, but not limited to, conference and peer-reviewed papers).
=#

function monthly2quarterly(a,n)

    #=
    Filename: monthly2quarterly.jl
    a: quarterly data
    n: length of resulting monthly array
    =#

    if ndims(a) == 1
        nQ = 1;
    else
        nQ = size(a,2);
    end

    a[ismissing.(a)] .= NaN;
    b = hcat([kron(a[:,i], [NaN; NaN; 1]) for i=1:nQ]...) |> Array{Union{Float64, Missing}};
    b[isnan.(b)] .= missing;

    if size(b,1) < n
        b = [b; missing.*ones(n-size(b,1), nQ)];
    end

    return b;
end
