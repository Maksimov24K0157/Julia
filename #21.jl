#21
using HorizonSideRobots
robot=Robot(animate=true)

function move_boarder!(robot, side)
    if !isborder(robot, side)
        move!(robot, side)
        movetocondition!(() -> !isborder(robot, left(side)), robot, side)
        return nothing
    end
    move!(robot, right(side))
    move_boarder!(robot, side)
    move!(robot, left(side))
end

left(side) = HorizonSide((Int(side) + 1) % 4)

right(side) = HorizonSide((Int(side) + 3) % 4)

function movetocondition!(stop_condition::Function, robot, side)
    while !stop_condition()
        move!(robot, side)
    end
end