#hw7
using HorizonSideRobots

function find_way(robot, side)
    s = HorizonSide((Int(side) + 1) % 4)
    num_steps = 1
    while isborder(robot, side)
        move!(robot, side, num_steps)
        s = inverse(s)
        num_steps += 1
    end
end

function inverse(side)
    return HorizonSide((Int(side) + 2) % 4)
end

function HorizonSideRobots.move!(robot, side, num_steps)
    for _ in 1:num_steps
        move!(robot, side)
    end
end