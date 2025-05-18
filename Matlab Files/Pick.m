function Pick(motorArm,motorGripper,mysonicsensor,touchArm)
    distance = readDistance(mysonicsensor)*1000
    counter = 1; % 2 operations happen here, picking and returning back to prev position
    if (counter == 1) % open gripper before starting operation to not hit the ball
        OpenGripper(motorGripper);
    end
    maxh = 230; % Max height (sensor reading)
    station = maxh - distance; % Station height (max height - current sensor reading)
    while (counter < 3)
        if (counter == 1)
            z = station; % for the arm to do the picking operation
        elseif (counter == 2)
            z = maxh; % for the arm to return back to its previous position
        end

        ArmD = double(readRotation(motorArm))
        distance = readDistance(mysonicsensor)*1000
        
        q = geoinv(0,0,z); % only z is needed here (x and y are irrelevant for the arm)
        q2inv = q(2)
    
        %%%%%%%%%%%%%% Arm %%%%%%%%%%%%%%%%%%
        PIDarm(motorArm,touchArm,q2inv) % control the arm to go to desired locations

        if (counter == 1) % when picking operation is done, close gripper to hold the ball
            CloseGripper(motorGripper);
        end
        counter = counter + 1;
    end
end