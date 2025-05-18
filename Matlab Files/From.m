function From(s,motorBase,touchBase,motorArm,motorGripper,mysonicsensor,touchArm)
    if (s == "A" || s == "a")
        PosANew(motorBase,touchBase,mysonicsensor);
        Pick(motorArm,motorGripper,mysonicsensor,touchArm)
    elseif (s == "B" || s == "b")
        HomingNew(motorBase,motorArm,touchBase,touchArm);
        Pick(motorArm,motorGripper,mysonicsensor,touchArm)
    elseif (s == "C" || s == "c")
        PosCNew(motorBase,touchBase,mysonicsensor);
        Pick(motorArm,motorGripper,mysonicsensor,touchArm)
    end
end