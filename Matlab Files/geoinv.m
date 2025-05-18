function pos = geoinv(x,y,z)
    L0 = 8;
    L1 = 80;
    L2 = 95;
    L3 = 185;
    L4 = 110-50; % Removing the gripper length from the total length
    h = z - (L2*sind(45) + L0 +L1);
    q1 = atan2d(x,-y);
    if (q1 < 0)
        q1 = q1 + 360;
    end
    q2 = acosd((h + L4)/L3) - 43;
    pos = [q1;q2];
end