using HorizonSideRobots

robot = Robot(animate=true)

mutable struct R
    robot::Robot
    flag::Bool
end

RR = R(robot, true)

function Chess!(robot)
    num_steps_West = movetoend!(robot, West)
    num_steps_Sud = movetoend!(robot, Sud)
    snake!(s -> isborder(robot.robot, s) && isborder(robot.robot, Nord), robot, (Ost, Nord))
    movetoend!(robot, Ost)
    movetoend!(robot, West)
    movetoend!(robot, Sud)
    move!(robot, Nord, num_steps_Sud)
    move!(robot, Ost, num_steps_West)
end

function HorizonSideRobots.move!(robot, side, num_steps)
    for _ in 1:num_steps
        move!(robot, side)
    end
end

function HorizonSideRobots.move!(robot::R, side)
    if !isborder(robot.robot, side)
        move!(robot.robot, side)
        robot.flag = !robot.flag
        robot.flag && putmarker!(robot.robot)
    end
end

function movetoend!(robot, side)
    n = 0
    robot.flag && putmarker!(robot.robot)
    while !isborder(robot.robot, side)
        move!(robot, side, 1)
        n += 1
    end
    return n
end

function snake!(stop_condition::Function, robot, sides::NTuple{2,HorizonSide})
    s = sides[1]
    while !stop_condition(s)
        movetoend!(robot, s)
        stop_condition(s) && break
        s = inverse(s)
        move!(robot, sides[2])
    end
end

inverse(side) = HorizonSide((Int(side) + 2) % 4)
