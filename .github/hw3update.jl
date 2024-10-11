#ДАНО: Робот - в произвольной клетке ограниченного прямоугольного
#поля
#РЕЗУЛЬТАТ: Робот - в исходном положении, и все клетки поля
#промаркированы
using HorizonSideRobots
function full_field!(robot)
    num_steps_West = do_predela!(robot, West)
    num_steps_Nord = do_predela!(robot, Nord)
    full!(robot)
    do_predela!(robot, West)
    do_predela!(robot, Nord)
    move!(robot, inverse!(Nord), num_steps_Nord)
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

function inverse!(side::HorizonSide)
    return HorizonSide((Int(side) + 2) % 4)
end

function mark_direct!(robot, side)
    n = 0
    while !isborder(robot, side)
        move!(robot, side)
        n += 1
        putmarker!(robot)
    end
end

function full!(robot)
    move_side = inverse!(West)
    while !isborder(robot, Sud)
        putmarker!(robot)
        mark_direct!(robot, move_side)
        move!(robot, Sud)
        move_side = inverse!(move_side)
    end
    putmarker!(robot)
    mark_direct!(robot, move_side)
end
