export Tube, Coil

"""
    Tube

A tube (or pipe) with a diameter and length through which a fluid flows.
"""
struct Tube{T1<:Unitful.Length,T2<:Unitful.Length}
    diameter::T1
    length::T2
end

Tube(; diameter::Unitful.Length, length::Unitful.Length) = Tube(diameter, length)

"""
    Coil

A tube (or pipe) in the shape of a coil with a diameter and pitch.
"""
struct Coil{T<:Tube,T1<:Unitful.Length,T2<:Unitful.Length}
    tube::T
    diameter::T1
    pitch::T2
end

Coil(t::Tube; diameter::Unitful.Length, pitch::Unitful.Length) =
    Coil(t, diameter, pitch)

