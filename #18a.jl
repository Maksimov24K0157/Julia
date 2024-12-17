#18a

using HorizonSideRobots
robot=Robot(animate=true)

struct FindRobot
    robot::Robot
end

R=FindRobot(robot)


function find_direct!(stop_condition::Function, robot, side, nmax_steps)
    n=0
    while !(stop_condition() || (n == nmax_steps))
        move!(robot, side)
        n+=1
    end
    return stop_condition()
end

function find!(robot)
    spiral!(()->ismarker(robot.robot), robot)
end

function spiral!(stop_condition::Function, robot)
    nmax_steps = 1
    s = Nord
    while !find_direct!(stop_condition, robot, s, nmax_steps)
        (s in (Nord, Sud)) && (nmax_steps += 1)
        s = left(s)
    end
end

function HorizonSideRobots.move!(robot::FindRobot, side)
    if isborder(robot.robot, side)
        move!(robot.robot, left(side))
        ismarker(robot.robot) && return ismarker(robot.robot)
        bool = move!(robot, side)
        bool && return bool
        move!(robot.robot, right(side))
        return ismarker(robot.robot)
    else
        move!(robot.robot, side)
        return ismarker(robot.robot)
    end
end


left(side) = HorizonSide((Int(side)+1)%4)
right(side) = HorizonSide((Int(side)+3)%4)