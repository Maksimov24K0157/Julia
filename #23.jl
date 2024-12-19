#23

using HorizonSideRobots

robot = Robot(animate=true)

function move_symmetry!(robot, side)
    if isborder(robot, side)
        move_border!(robot, side)
        return nothing
    else
        move!(robot, side)
        move_symmetry!(robot, side)
        move!(robot, side)
    end
end

function move_border!(robot, side)
    if !isborder(robot, side)
        move!(robot, side)
        movetoend!(() -> !isborder(robot, left(side)), robot, side)
        return nothing
    end
    move!(robot, right(side))
    move_border!(robot, side)
    move!(robot, left(side))
end

left(side) = HorizonSide((Int(side) + 1) % 4)

right(side) = HorizonSide((Int(side) + 3) % 4)

function movetoend!(stop_condition::Function, robot, side)
    while !stop_condition()
        move!(robot, side)
    end
end