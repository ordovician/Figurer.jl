import Base: length, abs, +, -, *, /, ==, !=, size, ndims, eltype, similar

export 	Point, ismin, ismax,
		Vector2D, dot, cross, ⋅, ×,
		Segment,
 		Circle,
		Rect,
		Polygon,
		Matrix3x3,
		sqrnorm, 
		unit, 
		normal, 
		angle
        

struct Point{T <: Number}
	x::Number
	y::Number
end

Point(x::T, y::T) where T <: Number = Point{T}(x, y)

struct Vector2D{T <: Number}
	x::Number
	y::Number
end

Vector2D(x::T, y::T) where T <: Number = Vector2D{T}(x, y)

struct Direction{T <: Number}
	x::Number
	y::Number
end

Direction(x::T, y::T) where T <: Number = Direction{T}(x, y)


VecOrDir      = Union{Vector2D, Direction}
PointVecOrDir = Union{Vector2D, Direction, Point}
PointOrVec    = Union{Vector2D, Point}