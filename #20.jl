#20
using HorizonSideRobots
robot=Robot(animate=true)

function movetoendplusmarker!(robot, side)
    if isborder(robot, side)
        putmarker!(robot, side)
        return nothing
    end
    move!(robot, side)
    movetoendplusmarker!(robot, side)
    move!(robot, HorizonSide((Int(side) + 2) % 4))
end