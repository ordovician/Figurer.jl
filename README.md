# Figurer
Figurer (Norwegian for shapes) is a package for implementing a type hiearchy of geometric shapes. The motivation is to demonstrate how one can simulate an object oriented style class hierarchy in a language such as Julia, which does not offer implementation inheritance.

For instance a `Square` is a `Rectangle` which is a `Quadrilateral`. We can create this as a type hierarchy of abstract types, but if we want to actually create instances of Squares and Rectangles we get a problem. If a `Rectangle` has fields such as width and height, then rectangle cannot inherit it.

Furthermore you **don't** actually want to inherit, because a Square only needs to store a side and not both a width and height.

The solution to this problem is to create a hierarchy, where all internal nodes of the type tree are abstract and the leaf nodes are concrete types suffixed with `Data` which are not exposed to the User.

E.g. `Rectangle` is defined as an abstract type:

    abstract type Rectangle <: Parallelogram end    
    abstract type Square <: Rectangle end 

This is the one we make available to user of the package with
    
    export Rectangle

To hold the width and the height we create a concrete type, inheriting the abstract `Rectangle`

    struct RectangleData{T <: Number} <: Rectangle
        width::T
        height::T
    end

But here is the trick. We create a constructor with the same name as the abstract class for making this concrete type.

    Rectangle(width, height) = RectangleData(width, height)

Thus to the user of the package, it looks as if one can instantiate `Rectangle` types even though they are abstract.

This allows us to create functions which operate e.g. on only rectangle objects. Here is an example.

     isrectangle(::Any)  = false
     isrectangle(::Rectangle) = true
     
We have defined the function to only return true if it gets a geometric shape which is a rectangle as argument. That includes both rectangles and squares. Here is an example of usage:

    julia> rec = Rectangle(3, 4)
    Figurer.RectangleData{Int64}(3, 4)

    julia> sqr = Square(4)
    Figurer.SquareData{Int64}(4)

    julia> par = Parallelogram(Vector2D(3, 0), Vector2D(0, 4))
    Figurer.ParallelogramData{Int64}(Vector2D{Int64}(3, 0), Vector2D{Int64}(0, 4))

    julia> isrectangle(par)
    false

    julia> isrectangle(sqr)
    true

    julia> isrectangle(rec)
    true


## Status
Minimal testing done. Has mainly been to experiment with inheritance. The geometry calculations may be wrong.

       
## Installation
Upgraded to work with the Julia 1.0 package manager. Get into package mode on the Julia command line using the ']' key.

    pkg> add https://github.com/ordovician/Figurer.jl