export Structure, Tube, Coil, Valve

abstract type Structure end

"""
    Tube

A tube (or pipe) with a diameter and length through which a fluid flows.
"""
struct Tube{T1<:Unitful.Length,T2<:Unitful.Length} <: Structure
    diameter::T1
    length::T2
end

Tube(; diameter::Unitful.Length, length::Unitful.Length) = Tube(diameter, length)

"""
    Coil

A tube (or pipe) in the shape of a coil with a diameter and pitch.
"""
struct Coil{T<:Tube,T1<:Unitful.Length,T2<:Unitful.Length} <: Structure
    tube::T
    diameter::T1
    pitch::T2
end

Coil(t::Tube; diameter::Unitful.Length, pitch::Unitful.Length) = Coil(t, diameter, pitch)

"""
    Valve

A valve with a flow rate and flow factor.
"""
struct Valve{T1<:VolumeFlow,T2<:VolumeFlow} <: Structure
    flow_rate::T1
    flow_factor::T2
end

Valve(; flow_rate::VolumeFlow, flow_factor::VolumeFlow) = Valve(flow_rate, flow_factor)