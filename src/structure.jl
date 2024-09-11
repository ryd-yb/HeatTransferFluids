export Structure, Tube, Helix, Valve

"""
    Structure

A structure is an element through which a fluid flows.
"""
abstract type Structure end

"""
    Tube{T<:AbstractQuantity}

A tube with a diameter and length through which a fluid flows.

# Fields
- `diameter::T`: the diameter of the tube
- `length::T`: the length of the tube
"""
struct Tube{T<:AbstractQuantity} <: Structure
    diameter::T
    length::T

    function Tube(; diameter::T, length::T) where {T}
        @assert dimension(diameter) == dimension(u"m") "diameter must have units of length"
        @assert dimension(length) == dimension(u"m") "length must have units of length"
        @assert ustrip(diameter) > 0 "diameter must be positive"
        @assert ustrip(length) > 0 "length must be positive"
        new{T}(diameter, length)
    end
end

"""
    Helix{T<:Tube,V<:AbstractQuantity}

A tube in the shape of a helix with a diameter and pitch.

# Fields
- `tube::T`: the tube that is coiled
- `diameter::V`: the diameter of the coil
- `pitch::V`: the pitch of the coil
"""
struct Helix{T<:Tube,V<:AbstractQuantity} <: Structure
    tube::T
    diameter::V
    pitch::V

    function Helix(t::T; diameter::V, pitch::V) where {T,V}
        @assert dimension(diameter) == dimension(u"m") "diameter must have units of length"
        @assert dimension(pitch) == dimension(u"m") "pitch must have units of length"
        @assert ustrip(diameter) > 0 "diameter must be positive"
        @assert ustrip(pitch) > 0 "pitch must be positive"
        new{T,V}(t, diameter, pitch)
    end
end

"""
    Valve{T<:AbstractQuantity}

A valve parametrized by a flow rate and flow factor.

# Fields
- `flow_rate::T`: the flow rate of the valve
- `flow_factor::T`: the flow factor of the valve
"""
struct Valve{T<:AbstractQuantity} <: Structure
    flow_rate::T
    flow_factor::T

    function Valve(; flow_rate::T, flow_factor::T) where {T}
        @assert dimension(flow_rate) == dimension(u"m^3/s") "flow_rate must have units of volume per time"
        @assert dimension(flow_factor) == dimension(u"m^3/s") "flow_factor must have units of volume per time"
        @assert ustrip(flow_rate) > 0 "flow_rate must be positive"
        @assert ustrip(flow_factor) > 0 "flow_factor must be positive"
        new{T}(flow_rate, flow_factor)
    end
end
