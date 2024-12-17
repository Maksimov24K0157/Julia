#16

using HorizonSideRobots
robot=Robot(animate=true)

function shuttle!(stop_condition::Function, robot, start_side)
    s = start_side
    n=0
    while !stop_condition()
        move!(robot, s, n)
        s = inverse(s)
        n += 1
    end
end

function find_hole(robot)
    shuttle!(()->!isborder(robot, Nord), robot, West)
end

inverse(side) = HorizonSide((Int(side)+2)%4)