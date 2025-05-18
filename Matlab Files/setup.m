function setup(motorBase, motorArm, motorGripper, touchArm, touchBase, pressedArm, pressedBase)
    while (pressedArm == 0 || pressedBase == 0)
        pressedArm = readTouch(touchArm); % reads the current value of the button
        pressedBase = readTouch(touchBase); % reads the current value of the button
        if (pressedBase == 1)
            motorBase.Speed = 0;
            start(motorBase);
            resetRotation(motorBase)
        else
            motorBase.Speed = 20;
            start(motorBase);
        end
    
        if (pressedArm == 1)
            motorArm.Speed = 0;
            start(motorArm);
            resetRotation(motorArm)
        else
            motorArm.Speed = -45;
            start(motorArm);
        end
        readRotation(motorArm)
        readRotation(motorBase)
    end
    % 
    flag = 0;
    rotationGripper = readRotation(motorGripper);
    rotprev = rotationGripper;
    while ((readRotation(motorGripper) < 500) && flag == 0)
        motorGripper.Speed = 20;
        start(motorGripper);
        if (rotprev == rotationGripper)
            flag = 1;
        end
        rotprev = rotationGripper;
    end
    
    motorGripper.Speed = 0;
    start(motorGripper);
    rotationGripper = readRotation(motorGripper)
    resetRotation(motorGripper);
end