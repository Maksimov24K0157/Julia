using HorizonSideRobots
function cross!(robot)#1.робот идет до края и ставит кресты. запоминает шаги 2. робот разворачивается и идет в обратное направление на записанное число шагов
    for side in (Nord, Ost, Sud, West)
        num_steps = mark_direct!(robot, side)#идет до края, ставит точки, запоминает шаги
        side = inverse(side)#разворот
        poo!(robot, side, num_steps)#модификация изначальной функции, чтобы шел на фиксированное колличество шагов
    end
end

function poo!(robot, side, num_steps::Integer)
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

