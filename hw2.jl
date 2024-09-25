using HorizonSideRobots
function circle!(robot)
    num_steps_West = do_predela!(robot, West)
    num_steps_Sud = do_predela!(robot, Sud)
    for side in (Nord, Ost, Sud, West)
        mark_direct!(robot, side)
    end
    move!(robot, inverse!(Sud), num_steps_Sud)
    move!(robot, inverse!(West), num_steps_West)
end

function do_predela!(robot, side)
    n = 0
    while !isborder(robot, side)
        move!(robot, side)
        n += 1
    end
    return n
end

function HorizonSideRobots.move!(robot, side, num_steps::Integer)
    for _ in 1:num_steps
        move!(robot, side)
    end
end

function mark_direct!(robot, side)#::Int
    n = 0
    while !isborder(robot, side)
        move!(robot, side)
        putmarker!(robot)
        n += 1
    end
    return n
end

inverse(side::HorizonSide) = HorizonSide((Int(side) + 2) % 4)