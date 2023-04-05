export Structure, Tube, Coil, Valve

"""
    Structure

A structure is an element through which a fluid flows.
"""
abstract type Structure end

"""
    Tube

A tube with a diameter and length through which a fluid flows.

# Fields
- `diameter::Unitful.Length`: the diameter of the tube
- `length::Unitful.Length`: the length of the tube
"""
struct Tube{T1<:Unitful.Length,T2<:Unitful.Length} <: Structure
    diameter::T1
    length::T2
end

"""
    Tube(; diameter::Unitful.Length, length::Unitful.Length)

Returns a Tube with the given tube diameter and length.

# Keywords
- `diameter::Unitful.Length`: the diameter of the tube
- `length::Unitful.Length`: the length of the tube

# Returns
- `Tube`: the tube with the given diameter and length
"""
Tube(; diameter::Unitful.Length, length::Unitful.Length) = Tube(diameter, length)

"""
    Coil

A tube in the shape of a coil with a diameter and pitch.

# Fields
- `tube::Tube`: the tube that is coiled
- `diameter::Unitful.Length`: the diameter of the coil
- `pitch::Unitful.Length`: the pitch of the coil
"""
struct Coil{T<:Tube,T1<:Unitful.Length,T2<:Unitful.Length} <: Structure
    tube::T
    diameter::T1
    pitch::T2
end

"""
    Coil(t::Tube; diameter::Unitful.Length, pitch::Unitful.Length)

Returns a Coil with the given tube, diameter, and pitch.

# Arguments
- `t::Tube`: the tube that is coiled

# Keywords
- `diameter::Unitful.Length`: the diameter of the coil
- `pitch::Unitful.Length`: the pitch of the coil

# Returns
- `Coil`: the coil with the given tube, diameter, and pitch
"""
Coil(t::Tube; diameter::Unitful.Length, pitch::Unitful.Length) = Coil(t, diameter, pitch)

"""
    Valve

A valve parametrized by a flow rate and flow factor.

# Fields
- `flow_rate::VolumeFlow`: the flow rate of the valve
- `flow_factor::VolumeFlow`: the flow factor of the valve
"""
struct Valve{T1<:VolumeFlow,T2<:VolumeFlow} <: Structure
    flow_rate::T1
    flow_factor::T2
end

"""
    Valve(; flow_rate::VolumeFlow, flow_factor::VolumeFlow)

Returns a Valve with the given flow rate and flow factor.

# Keywords
- `flow_rate::VolumeFlow`: the flow rate of the valve
- `flow_factor::VolumeFlow`: the flow factor of the valve

# Returns
- `Valve`: the valve with the given flow rate and flow factor
"""
Valve(; flow_rate::VolumeFlow, flow_factor::VolumeFlow) = Valve(flow_rate, flow_factor)