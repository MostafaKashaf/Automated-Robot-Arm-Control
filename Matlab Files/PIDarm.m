function PIDarm(motorArm,touchArm,q2inv)
    % P Controller
    % KpA = 10;
    % KiA = 0;
    % KdB = 0;
    
    % PI Controller
    KpA = 5;
    KiA = 0.8;
    KdB = 0;

    refA = q2inv % reference angle is the angle required to reach the specific height

    ArmD = double(readRotation(motorArm))
    q2 = ArmD/5   % mapping the current value of the encoder
    errorA = refA - q2 % calculation of error (reference - current)
    PIDA_Ki = 0; % initial integral component
    StartT = tic; % starts the time to calculate the integral and derivative parts
    errorprev = 0; % initializing the prev error for the integral and derivative parts
    counterbreak = 1; % counter for breaking from loop when the speed doesn't change (based on error)
    q2array = zeros(1,1000); % for plot
    counterA = 1; % for plot
    q2array(counterA) = q2; % for plot
    while (abs(errorA) > 2.3)
        PIDA_Kp = KpA*errorA; % calculation of proportional part
        EndT = toc(StartT); % ending interval of the time
        PIDA_Ki = KiA*(PIDA_Ki + ((errorA + errorprev)/2)*EndT); % calculation of integral part
        PIDB_Kd = KdB*((errorB-errorprev)/EndT); % calculation of the derivative part
        StartT = tic; % starts the time again to calculate the integral and derivative parts
        PIDA = PIDA_Kp + PIDA_Ki + PIDB_Kd % calculation of controller to control the speed based on error
        if (PIDA > 30) % limiting the maximum speed
            motorArm.Speed = 30;
        elseif (PIDA < -30) % limiting the maximum speed in other direction
            motorArm.Speed = -30;
        else
            motorArm.Speed = PIDA;
        end
        start(motorArm);

        if (errorprev == errorA)
            counterbreak = counterbreak + 1;
        end

        if (counterbreak > 10) % once counter is over the limit, break from loop
            break;
        end

        ArmD = double(readRotation(motorArm))
        q2 = ArmD/5
        errorprev = errorA; % assigning current error to errorprev to calculate the integral
        errorA = refA - q2 % getting new error
        counterA = counterA + 1; % for plot
        q2array(counterA) = q2; % for plot

        if (refA == 0 && readTouch(touchArm) == 1) % stop and break, after pressing the button
            motorArm.Speed = 0;
            start(motorArm);
            break;
        end
    end

    motorArm.Speed = 0;
    start(motorArm);

    %%% Plot %%%
    figure
    plotA = linspace(0,counterA,counterA);
    q2ref(1:counterA) = refA;
    q2array = q2array(1:counterA);
    plot(plotA,q2ref(1:counterA))
    title('Arm Control')
    hold on
    plot(plotA,q2array)
    hold off
end