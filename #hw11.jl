#hw11
#hw11
using HorizonSideRobots

robot = Robot(animate=true)

mutable struct CheckRobot
    robot::Robot
    f::Bool
end

cr = CheckRobot(robot, false)

function countboarders!(robot)
    num_steps_West = movetoend!(robot.robot, West)
    num_steps_Sud = movetoend!(robot.robot, Sud)
    n = count!(robot)
    movetoend!(robot, West)
    movetoend!(robot, Sud)
    move!(robot, Nord, num_steps_Sud)
    move!(robot, Ost, num_steps_West)
    return n
end

function HorizonSideRobots.move!(robot, side, num_steps)
    for _ in 1:num_steps
        move!(robot.robot, side)
    end
end

function HorizonSideRobots.move!(robot::CheckRobot, side)
    move!(robot.robot, side)
    if !isborder(robot.robot, Nord)
        robot.f || return 0
        robot.f = false
        return 1
    end
    robot.f = true
    return 0
end

function movetoend!(robot, side)
    n = 0
    while !isborder(robot.robot, side)
        n += move!(robot, side)
    end
    return n
end

function movetoend!(robot::Robot, side)
    n = 0
    while !isborder(robot, side)
        move!(robot, side)
        n+=1
    end
    return n
end

inverse(side) = HorizonSide((Int(side) + 2) % 4)

function count!(robot)
    s = Ost
    n = 0
    while !(isborder(robot.robot, Nord) && (isborder(robot.robot, Ost) || isborder(robot.robot, West)))
        n += movetoend!(robot, s)
        move!(robot.robot, Nord)
        s = inverse(s)
    end
    n += movetoend!(robot, s)
    return n
end

