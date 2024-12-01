#hw8
using HorizonSideRobots

function find_marker(robot)
    n = 0
    side = HorizonSide(n)
    while move!(robot, side, n)
        n += 1
        side = HorizonSide((n) % 4)
    end
end


function HorizonSideRobots.move!(robot, side, n)
    num_steps = div(n, 2) + 1
    ismarker(robot) && return false
    for _ in 1:num_steps
        move!(robot, side)
        ismarker(robot) && return false
    end
    return true
end