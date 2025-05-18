function To(s,motorBase,touchBase,motorArm,motorGripper,mysonicsensor,touchArm)
    if (s == "A" || s == "a")
        PosANew(motorBase,touchBase,mysonicsensor);
        Place(motorArm,motorGripper,mysonicsensor,touchArm);
        HomingNew(motorBase,motorArm,touchBase,touchArm);
    elseif (s == "B" || s == "b")
        HomingNew(motorBase,motorArm,touchBase,touchArm);
        Place(motorArm,motorGripper,mysonicsensor,touchArm);
    elseif (s == "C" || s == "c")
        PosCNew(motorBase,touchBase,mysonicsensor);
        Place(motorArm,motorGripper,mysonicsensor,touchArm);
        HomingNew(motorBase,motorArm,touchBase,touchArm);
    end
end