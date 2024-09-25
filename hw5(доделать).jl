#ДАНО: На ограниченном внешней прямоугольной рамкой поле имеется
#ровно одна внутренняя перегородка в форме прямоугольника. Робот - в
#произвольной клетке поля между внешней и внутренней перегородками.
#РЕЗУЛЬТАТ: Робот - в исходном положении и по всему периметру
#внутренней, как внутренней, так и внешней, перегородки поставлены маркеры.
using HorizonSideRobots
function perimetr!(robot)
    num_steps_West = do_predela!(robot, West)
    num_steps_Nord = do_predela!(robot, Nord)
    circle!(robot, Nord)#обход
    checking!(robot, Ost)
    circle!(robot, Nord)
    do_predela!(robot, West)
    do_predela!(robot, Nord)
    move!(robot, Sud, num_steps_Nord)
    move!(robot, Ost, num_steps_West)
end

function do_predela!(robot, side)
    n = 0
    while !isborder(robot, side)
        move!(robot, side)
        n += 1
    end
    return n
end

function circle!(robot, side)
    s = side
    for i in 1::4
        s = HorizonSide((Int(s) + 1)%4)
        mark_direct!(robot, s)
    end
end

function mark_direct!(robot, side)#::Int
    n = 0
    s = side
    s_wall_1 = HorizonSide((Int(s) + 1)%4)
    s_wall_2 = HorizonSide((Int(s) + 3)%4)
    while !isborder(robot, s) && (isborder(robot, s_wall_1) || isborder(robot, s_wall_2))
        move!(robot, s)
        putmarker!(robot)
        n += 1
    end
    return n
end

function checking!(robot, side)
    s = side
    while True
        if check_line!(robot, s)
            break
        end
        s = inverse!(s)
        move!(robot, Sud)
    end
    while isborder(robot, Sud)
        move!(robot, West)
    end
    move!(robot, Ost)
end

inverse(side::HorizonSide) = HorizonSide((Int(side) + 2) % 4)

function check_line!(robot, side)
    while !isborder(robot, side)
        if isborder(robot, Sud)
            return True
        end
        move!(robot, side)
    end
    return False
end

function HorizonSideRobots.move!(robot, side, num_steps)
    for _ in 1:num_steps
        move!(robot, side)
    end
end