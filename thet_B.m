function theta_B = thet_B(T_f, T_b, C_x, C_y, C_z, isFirst)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

l1 = 0.24; % m length of the first link
l2 = 1.5; % m length of the second link
l3 = 1.2; % m length of the first link
l4 = 0.56; % m length of the second link

sim_B = struct('footPos',[],'timeVec',[]);

if isFirst==true
    for time = 0:0.005:T_f

        time_2 = T_f - time;

        if time_2 < 0
            time_2 = 0;
        end

        if (time_2>=0)&&(time_2 <=T_b)
            F(1,1) = [time_2^2 time_2 1 0 0 0 0 0]*C_x;
            F(2,1) = [time_2^2 time_2 1 0 0 0 0 0]*C_y;
            F(3,1) = [time_2^2 time_2 1 0 0 0 0 0]*C_z;
            sim_B.footPos = [sim_B.footPos F];
            sim_B.timeVec = [sim_B.timeVec time]; 
        end

        if (time_2>T_b)&&(time_2 <=T_f - T_b)
            F(1,1) = [0 0 0 time_2 1 0 0 0]*C_x;
            F(2,1) = [0 0 0 time_2 1 0 0 0]*C_y;
            F(3,1) = [0 0 0 time_2 1 0 0 0]*C_z;  
            sim_B.footPos = [sim_B.footPos F];
            sim_B.timeVec = [sim_B.timeVec time]; 
        end

        if (time_2>T_f - T_b)&&(time_2 <=T_f)
            F(1,1) = [0 0 0 0 0 time_2^2 time_2 1]*C_x;
            F(2,1) = [0 0 0 0 0 time_2^2 time_2 1]*C_y;
            F(3,1) = [0 0 0 0 0 time_2^2 time_2 1]*C_z;
            sim_B.footPos = [sim_B.footPos F];
            sim_B.timeVec = [sim_B.timeVec time];
        end

    end
else
    for time = 0.005:0.005:T_f

        time_2 = T_f - time;

        if time_2 < 0
            time_2 = 0;
        end

        if (time_2>=0)&&(time_2 <=T_b)
            F(1,1) = [time_2^2 time_2 1 0 0 0 0 0]*C_x;
            F(2,1) = [time_2^2 time_2 1 0 0 0 0 0]*C_y;
            F(3,1) = [time_2^2 time_2 1 0 0 0 0 0]*C_z;
            sim_B.footPos = [sim_B.footPos F];
            sim_B.timeVec = [sim_B.timeVec T_f+time]; 
        end

        if (time_2>T_b)&&(time_2 <=T_f - T_b)
            F(1,1) = [0 0 0 time_2 1 0 0 0]*C_x;
            F(2,1) = [0 0 0 time_2 1 0 0 0]*C_y;
            F(3,1) = [0 0 0 time_2 1 0 0 0]*C_z;  
            sim_B.footPos = [sim_B.footPos F];
            sim_B.timeVec = [sim_B.timeVec T_f+time]; 
        end

        if (time_2>T_f - T_b)&&(time_2 <=T_f)
            F(1,1) = [0 0 0 0 0 time_2^2 time_2 1]*C_x;
            F(2,1) = [0 0 0 0 0 time_2^2 time_2 1]*C_y;
            F(3,1) = [0 0 0 0 0 time_2^2 time_2 1]*C_z;
            sim_B.footPos = [sim_B.footPos F];
            sim_B.timeVec = [sim_B.timeVec T_f+time];
        end

    end
end

s = size(sim_B.footPos,2);
theta_B=zeros(s,5);

for idx = 1:s

    th = my_inv(sim_B.footPos(1,idx),sim_B.footPos(2,idx),sim_B.footPos(3,idx),l1,l2,l3,l4);
    theta_B(idx,1)=real(sim_B.timeVec(1,idx));
    theta_B(idx,2)=real(th(1,1));
    theta_B(idx,3)=real(th(2,1));
    theta_B(idx,4)=real(th(3,1));
    theta_B(idx,5)=real(th(4,1));
end
end

