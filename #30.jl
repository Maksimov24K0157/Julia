#30

robot = Robot(animate=true)

struct Coordinates
    x::Int
    y::Int
end

mutable struct Coord_Robot
    robot::Robot
    coord::Coordinates
end

function move(coord::Coordinates, side)
    x = coord.x
    y = coord.y
    side == Nord && y += 1
    side == Sud && y -= 1
    side == Ost && x += 1
    side == West && x -= 1
    return Coordinates(x, y)
end

function HorizonSideRobots.move!(robot::Coord_Robot, side)
    isborder(robot.robot, side) && return false
    move!(robot.robot, side)
    robot.coord = move(robot.coord, side)
    return true
end

struct LRobot
    c_robot::Coord_Robot
    passed_c::Set{Coordinates}
    LRobot(robot::Robot) = new(Coord_Robot(robot, Coordinates(0, 0)), Set{Coordinates})
end

R = LRobot(robot)

function labirint!(action::Function, robot::LRobot)
    ((robot.c_robot.coord in robot.passed_c) || ismarker(robot.c_robot.robot)) && return nothing
    push!(robot.passed_c, robot.c_robot.coord)
    action()
    for side in (Nord, West, Sud, Ost)
        move!(robot.c_robot, side) && begin
            labirint!(action, robot)
            move!(robot.c_robot, inverse(side))
        end
    end
end

inverse(side) = HorizonSide((Int(side) + 2) % 4)

function chess!(robot::LRobot)
    x = robot.c_robot.coord.x
    y = robot.c_robot.coord.y
    (((x + y) % 2) == 0) && putmarker!(robot.c_robot.robot)
end

task30!(robot::LRobot) = labirint!(() -> chess!(robot), robot)