#19
using HorizonSideRobots
robot=Robot(animate=true)

function movetoend!(robot, side)
    isborder(robot, side) && return nothing
    move!(robot, side)
    movetoend!(robot, side)
end