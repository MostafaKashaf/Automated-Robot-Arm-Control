function CloseGripper(motorGripper)
    while (readRotation(motorGripper) > -40) % It needs to be adjusted before working on the robot
        motorGripper.Speed = -20;
        start(motorGripper);
        readRotation(motorGripper)
    end
    motorGripper.Speed = 0;
    start(motorGripper);
end