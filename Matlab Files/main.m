%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Controlling a Pick and Place Robot                      %
% Group 8                                                 %
% Group members: -Mostafa Ahmed Ismail Bayoumy Kashaf     %
%                -Kothalawala Hewage Randima Fernando     %
%                -Guegang Vanes Loic Gnoitik              %
%                -Naresh Chand                            %
%                -Raihaan Ahmed Rafeeq                    %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%cleaning up the working environment before starting
clc, clear, close all

% Initialization
myev3 = legoev3('USB');
motorBase = motor(myev3,'C');
motorArm = motor(myev3,'B');
motorGripper = motor(myev3,'A');
touchArm = touchSensor(myev3, 3); % Arm limit
touchBase = touchSensor(myev3, 1); % Base Limit

%Ultrasonic Sensor
mysonicsensor = sonicSensor(myev3);
distance = readDistance(mysonicsensor) % Reads distance from ultrasonic sensor

pressedArm = readTouch(touchArm);
pressedBase = readTouch(touchBase);

%%%%%%%%%%%%%%%%%%%%% SETUP %%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Uncomment bottom line, run file, then comment it again
% setup(motorBase, motorArm, motorGripper, touchArm, touchBase, pressedArm, pressedBase); 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Gripper values have to be adjusted first before operation, because each
% robot is different

% OpenGripper(motorGripper);
% CloseGripper(motorGripper);

% %%%%%%%%%%%%%% CONTROLLING THE ROBOT %%%%%%%%%%%%%%%%%%%%%%%
prompt = "From: ";            
Fstation = input(prompt,"s")  % User types the desired station to pick from
prompt2 = "To: ";
Tstation = input(prompt2,"s") % User types the desired station to place to

From(Fstation,motorBase,touchBase,motorArm,motorGripper,mysonicsensor,touchArm) % performing the operation of picking from a desired station
To(Tstation,motorBase,touchBase,motorArm,motorGripper,mysonicsensor,touchArm)   % performing the operation of placing to a desired station

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% to know the final reading of each encoder and the ultrasonic sensor
distance = readDistance(mysonicsensor)
rotationBase = readRotation(motorBase)
rotationArm = readRotation(motorArm)
rotationGripper = readRotation(motorGripper)

% to ensure that all motors are stopped by the end of the code
motorGripper.Speed = 0;
motorArm.Speed = 0;
motorBase.Speed = 0;
start(motorBase);
start(motorArm);
start(motorGripper)

