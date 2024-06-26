function angles = thet_S(T_f, T_b, C_x, C_y, C_z,isFirst)


l1 = 0.24; % m length of the first link
l2 = 1.5; % m length of the second link
l3 = 1.2; % m length of the third link
l4 = 0.56; % m length of the fourth link

simStates = struct('bodyPos',[],'footPos',[],'timeVec',[]);
if isFirst==true
    for time = 0:0.005:T_f
        if (time>=0)&&(time <=T_b)
            F(1,1) = [time^2 time 1 0 0 0 0 0]*C_x;
            F(2,1) = [time^2 time 1 0 0 0 0 0]*C_y;
            F(3,1) = [time^2 time 1 0 0 0 0 0]*C_z;
            simStates.footPos = [simStates.footPos F]; 
            simStates.timeVec = [simStates.timeVec time]; 
        end

        if (time>T_b)&&(time <=T_f - T_b)
            F(1,1) = [0 0 0 time 1 0 0 0]*C_x;
            F(2,1) = [0 0 0 time 1 0 0 0]*C_y;
            F(3,1) = [0 0 0 time 1 0 0 0]*C_z;  
            simStates.footPos = [simStates.footPos F]; 
            simStates.timeVec = [simStates.timeVec time]; 
        end

        if (time>T_f - T_b)&&(time <=T_f)
            F(1,1) = [0 0 0 0 0 time^2 time 1]*C_x;
            F(2,1) = [0 0 0 0 0 time^2 time 1]*C_y;
            F(3,1) = [0 0 0 0 0 time^2 time 1]*C_z;
            simStates.footPos = [simStates.footPos F];
            simStates.timeVec = [simStates.timeVec time]; 
        end

    end
else
    for time = 0.005:0.005:T_f
        if (time>=0)&&(time <=T_b)
            F(1,1) = [time^2 time 1 0 0 0 0 0]*C_x;
            F(2,1) = [time^2 time 1 0 0 0 0 0]*C_y;
            F(3,1) = [time^2 time 1 0 0 0 0 0]*C_z;
            simStates.footPos = [simStates.footPos F]; 
            simStates.timeVec = [simStates.timeVec time+T_f]; 
        end

        if (time>T_b)&&(time <=T_f - T_b)
            F(1,1) = [0 0 0 time 1 0 0 0]*C_x;
            F(2,1) = [0 0 0 time 1 0 0 0]*C_y;
            F(3,1) = [0 0 0 time 1 0 0 0]*C_z;  
            simStates.footPos = [simStates.footPos F]; 
            simStates.timeVec = [simStates.timeVec time+T_f]; 
        end

        if (time>T_f - T_b)&&(time <=T_f)
            F(1,1) = [0 0 0 0 0 time^2 time 1]*C_x;
            F(2,1) = [0 0 0 0 0 time^2 time 1]*C_y;
            F(3,1) = [0 0 0 0 0 time^2 time 1]*C_z;
            simStates.footPos = [simStates.footPos F];
            simStates.timeVec = [simStates.timeVec time+T_f]; 
        end

    end

end
% a = my_inv(2,2,1,0.24,1.5,1.2,0.56)
s = size(simStates.footPos,2);
angles=zeros(s,5);
for idx = 1:s

    th = my_inv(simStates.footPos(1,idx),simStates.footPos(2,idx),simStates.footPos(3,idx),l1,l2,l3,l4);
    angles(idx,1)=real(simStates.timeVec(1,idx));
    angles(idx,2)=real(th(1,1));
    angles(idx,3)=real(th(2,1));
    angles(idx,4)=real(th(3,1));
    angles(idx,5)=real(th(4,1));
end
end

