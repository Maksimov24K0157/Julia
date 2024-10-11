#ДАНО: Робот - в произвольной клетке ограниченного прямоугольного
#поля, на котором могут находиться также внутренние прямоугольные
#перегородки (все перегородки изолированы друг от друга, прямоугольники
#могут вырождаться в отрезки)
#РЕЗУЛЬТАТ: Робот - в исходном положении и
#a) по всему периметру внешней рамки стоят маркеры;
#б) маркеры не во всех клетках периметра, а только в 4-х позициях -
#напротив исходного положения робота.

#Задание ааа
using HorizonSideRobots
function circle_pereg!(robot)
    W_list = []
    N_list = []
    n = 0
    while !isborder(robot, West) || !isborder(robot, Nord)
        push!(W_list, do_predela!(robot, West))
        push!(N_list, do_predela!(robot, Nord))
        n += 1
    end
    circle!(robot)
    for i in n:-1:1
        move!(robot, Sud, N_list[i])
        move!(robot, Ost, W_list[i])
    end
end

function circle!(robot)
    for side in (Ost, Sud, West, Nord)
        mark_direct!(robot, side)
    end
end

function do_predela!(robot, side)
    n = 0
    while !isborder(robot, side)
        move!(robot, side)
        n += 1
    end
    return n
end

function HorizonSideRobots.move!(robot, side, num_steps)
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