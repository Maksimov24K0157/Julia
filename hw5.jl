#ДАНО: На ограниченном внешней прямоугольной рамкой поле имеется
#ровно одна внутренняя перегородка в форме прямоугольника. Робот - в
#произвольной клетке поля между внешней и внутренней перегородками.
#РЕЗУЛЬТАТ: Робот - в исходном положении и по всему периметру
#внутренней, как внутренней, так и внешней, перегородки поставлены маркеры.

using HorizonSideRobots
robot=Robot(animate=true)
using HorizonSideRobots
function perimetr!(robot)
    a, b, c = movetoend!(robot, Nord), movetoend!(robot, West), movetoend!(robot, Nord)
    snake!((s)->isborder(robot, Sud)&&(isborder(robot, s)), robot, (Ost, Sud))
    movetoend!(robot, West)
    snake!((s)->isborder(robot, Ost)&&(isborder(robot, s)), robot, (Nord, Ost))
    movetoend!(robot, Nord)
    movetoend!(robot, West)
    move!(robot, Sud, c)
    move!(robot, Ost, b)
    move!(robot, Sud, a)
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

function movetoend!(robot, side)
    n = 0
    while !isborder(robot, side)
        (isborder(robot, Sud)||isborder(robot, Ost)||isborder(robot, Nord)||isborder(robot, West))&&putmarker!(robot)
        move!(robot, side)
        n += 1
    end
    (isborder(robot, Sud)||isborder(robot, Ost)||isborder(robot, Nord)||isborder(robot, West))&&putmarker!(robot)
    return n
end

inverse(side::HorizonSide) = HorizonSide((Int(side) + 2) % 4)
