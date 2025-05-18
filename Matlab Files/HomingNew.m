function HomingNew(motorBase,motorArm,touchBase,touchArm)
    x = 45;
    y = 0;
    z = 230;

    q = geoinv(x,y,z);
    q1inv = q(1);
    q2inv = q(2);

    %%%%%%%%%%%%%% Base %%%%%%%%%%%%%%%%%
    PIDbase(motorBase,touchBase,q1inv)

    %%%%%%%%%%%%%% Arm %%%%%%%%%%%%%%%%%%
    PIDarm(motorArm,touchArm,q2inv)
end