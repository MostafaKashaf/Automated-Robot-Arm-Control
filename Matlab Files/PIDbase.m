function PIDbase(motorBase,touchBase,q1inv)
    % P Controller
    % KpB = 6;
    % KiB = 0;
    % KdB = 0;

    % PI Controller
    KpB = 3;
    KiB = 0.9;
    KdB = 0;

    % getting the reference angle from the inverse kinematics
    refB = q1inv;

    BaseD = double(readRotation(motorBase))
    q1 = BaseD/-3 % mapping the current value of the encoder
    errorB = refB - q1 % calculation of error (reference - current)
    PIDB_Ki = 0; % initial integral component
    StartT = tic; % starts the time to calculate the integral and derivative parts
    errorprev = 0; % initializing the prev error for the integral and derivative parts
    counterbreak = 1; % counter for breaking from loop when the speed doesn't change (based on error)
    q1array = zeros(1,1000); % for plot
    counterB = 1; % for plot
    q1array(counterB) = q1; % for plot
    while ((abs(errorB) > 0.4))
        PIDB_Kp = KpB*errorB; % calculation of proportional part
        EndT = toc(StartT); % ending interval of the time
        PIDB_Ki = KiB*(PIDB_Ki + ((errorB + errorprev)/2)*EndT); % calculation of integral part
        PIDB_Kd = KdB*((errorB-errorprev)/EndT); % calculation of the derivative part
        StartT = tic; % starts the time again to calculate the integral and derivative parts
        PIDB = PIDB_Kp + PIDB_Ki + PIDB_Kd % calculation of controller to control the speed based on error
        if (PIDB > 25) % limiting the maximum speed
            motorBase.Speed = -25;
        elseif (PIDB < -25) % limiting the maximum speed in other direction
            motorBase.Speed = 25;
        else
            motorBase.Speed = -PIDB;
        end
        start(motorBase);

        if (errorprev == errorB)
            counterbreak = counterbreak + 1;
        end

        if (counterbreak > 500) % once counter is over the limit, break from loop
            break;
        end

        BaseD = double(readRotation(motorBase))
        q1 = BaseD/-3
        errorprev = errorB; % assigning current error to errorprev to calculate the integral
        errorB = refB - q1 % getting new error
        
        counterB = counterB + 1; % for plot
        q1array(counterB) = q1; % for plot

        if (readTouch(touchBase) == 1 && refB == 0) % stop after pressing the button
            motorBase.Speed = 0;
            start(motorBase);
        end
    end
    motorBase.Speed = 0;
    start(motorBase);

    %%% Plot %%%
    figure
    plotB = linspace(0,counterB,counterB);
    q1ref(1:counterB) = refB;
    q1array = q1array(1:counterB);
    plot(plotB,q1ref(1:counterB))
    title('Base Control')
    hold on
    plot(plotB,q1array)
    hold off
end