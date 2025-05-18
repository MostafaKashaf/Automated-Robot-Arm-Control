function PosCNew(motorBase,touchBase,mysonicsensor)
    x = 0;
    y = 45;
    z = readDistance(mysonicsensor)*1000; % will be returned for the pick and place in main method

    q = geoinv(x,y,z);
    q1inv = q(1);
    
    %%%%%%%%%%%%%% Base %%%%%%%%%%%%%%%%%
    PIDbase(motorBase,touchBase,q1inv)
end