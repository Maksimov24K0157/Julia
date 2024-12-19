#29a

using HorizonSideRobots

robot = Robot(animate=true)

function labirint!(robot)
    imarker(robot) && return nothing
    putmarker!(robot)
    for s in (Nord, West, Sud, Ost)
        move!(robot, s)
        labirint!(robot)
        move!(robot, inverse(s))
    end
end

inverse(side) = HorizonSide((Int(side) + 2) % 4)


#29b-то же самое что и #26