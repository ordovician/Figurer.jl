module Figurer

export  Quadrilateral, Kite, Trapezoid, IsoscelesTrapezoid, Parallelogram, Rectangle, Square,
        area, width, height, angle

include("primitives.jl")
include("point.jl")
include("vector2d.jl")
include("direction.jl")

abstract type Quadrilateral end
abstract type Kite <: Quadrilateral end

abstract type Trapezoid <: Quadrilateral end
abstract type IsoscelesTrapezoid <: Trapezoid end

abstract type Parallelogram <: Quadrilateral end
abstract type Rectangle <: Parallelogram end
abstract type Square <: Rectangle end


struct TrapezoidData{T <: Number} <: Trapezoid
    u::Vector2D{T}
    v::Vector2D{T}
    b::T
end

Trapezoid(u, v, b) = TrapezoidData(u, v, b)

height(t::TrapezoidData) = dot(t.u, t.v)
width(t::TrapezoidData)  = norm(t.v)

function area(t::TrapezoidData)
    h = height(t)
    a = width(t)
    h*(a + b)/2
end

struct RectangleData{T <: Number} <: Rectangle
    width::T
    height::T
end

Rectangle(width, height) = RectangleData(width, height)
area(r::RectangleData)   = r.width * r.height
width(r::RectangleData)  = r.width 
height(r::RectangleData) = r.height 

struct SquareData{T <: Number} <: Square
    side::T
end

Square(side) = SquareData(side)
area(square::SquareData)    = square.side^2
width(square::SquareData)   = square.side 
height(square::SquareData)  = square.side

struct ParallelogramData{T <: Number} <: Parallelogram
   u::Vector2D{T}
   v::Vector2D{T}
end

Parallelogram(u, v) = ParallelogramData(u, v)
area(par::ParallelogramData)  = cross(par.u, par.v)
width(par::ParallelogramData) = norm(par.v)
heigh(par::ParallelogramData) = dot(par.u, par.v)

function angle(a::Vector2D, b::Vector2D)
    cosα = dot(a, b) / (norm(a) * norm(b))
    acos(cosα)
end

function angle(par::ParallelogramData, corner::Integer)
    @assert 1 <= corner <= 4
    if corner % 2 == 1
        rad2deg(angle(par.u, par.v))    
    else
        rad2deg(angle(par.v, par.u)) 
    end
end

function angle(r::Rectangle, corner::Integer)
    @assert 1 <= corner <= 4
    90
end

end # module
