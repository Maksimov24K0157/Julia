#25a

using HorizonSideRobots

robot = Robot(animate=true)

function chess_line!(robot, side)
    putmarker!(robot)
    isborder(robot, side) && return nothing
    move!(robot, side)
    chess_line_1!(robot, side)
end

function chess_line_1!(robot, side)
    isborder(robot, side) && return nothing
    move!(robot, side)
    chess_line!(robot, side)
end