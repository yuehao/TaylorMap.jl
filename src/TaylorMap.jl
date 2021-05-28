module TaylorMap

using TaylorSeries
export TaylorMapNd

struct TaylorMapNd{T} <: AbstractVector{T} 
    dim::UInt8
    max_order::UInt8
    tpsc::Vector{TaylorN{T}}
    function TaylorMapNd(::Type{T}, d::Int, o::Int) where {T}
        new{T}(d, o, set_variables(T, "x", numvars=d, order=o))
    end
end

Base.size(z::TaylorMapNd)=z.dim
Base.IndexStyle(::Type{<:TaylorMapNd})=IndexLinear()

Base.getindex(z::TaylorMapNd, i::Int)=Base.getindex(z.tpsc,i)
Base.setindex!(z::TaylorMapNd, v, i::Int)=(z.tpsc[i]=v)


function get_linear_map(z::TaylorMapNd{T}) where {T}
    linmap=Array{Float64, 2}(undef, z.dim, z.dim)
    for i = 1:z.dim
        linmap[i,:]=z.tpsc[i].coeffs[2].coeffs
    end
    linmap
end

end # module
