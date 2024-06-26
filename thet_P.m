function theta_P = thet_P(T_f,isFirst)
%THETA_P Summary of this function goes here
%   Detailed explanation goes here
th = [0;0.25;-0.2;0];

T = [T_f^4 T_f^3 T_f^2 T_f 1;
    (3/2*T_f)^4 (3/2*T_f)^3 (3/2*T_f)^2 (3/2*T_f) 1;
    (2*T_f)^4 (2*T_f)^3 (2*T_f)^2 (2*T_f) 1;
    4*T_f^3 3*T_f^2 2*T_f 1 0;
    4*(2*T_f)^3 3*(2*T_f)^2 2*(2*T_f) 1 0];

thetas = struct('theta',[],'timeVec',[]);

for idx = 1:1:4
    delta_theta=th(idx,1);
    D_theta = [0;delta_theta;0;0;0];
    a = transpose(inv(T)*D_theta);
    thetas.theta = [thetas.theta; a];

end    
sim_P = struct('footPos',[],'timeVec',[]);
if  isFirst == true

    for time = T_f:0.005:2*T_f

        F_1 = thetas.theta(1,:)*[time^4; time^3; time^2; time; 1];
        F_2 = thetas.theta(2,:)*[time^4; time^3; time^2; time; 1];
        F_3 = thetas.theta(3,:)*[time^4; time^3; time^2; time; 1];
        F_4 = thetas.theta(4,:)*[time^4; time^3; time^2; time; 1];
        F = [F_1; F_2; F_3; F_4];

        sim_P.footPos = [sim_P.footPos F];
        sim_P.timeVec = [sim_P.timeVec time]; 
    end
else
    for time = (T_f+0.005):0.005:(2*T_f)

        F_1 = thetas.theta(1,:)*[time^4; time^3; time^2; time; 1];
        F_2 = thetas.theta(2,:)*[time^4; time^3; time^2; time; 1];
        F_3 = thetas.theta(3,:)*[time^4; time^3; time^2; time; 1];
        F_4 = thetas.theta(4,:)*[time^4; time^3; time^2; time; 1];
        F = [F_1; F_2; F_3; F_4];

        sim_P.footPos = [sim_P.footPos F];
        sim_P.timeVec = [sim_P.timeVec time]; 
    end 
end

s = size(sim_P.footPos,2);
theta_P=zeros(s,5);

for idx = 1:s

    theta_P(idx,1)=real(sim_P.timeVec(1,idx));
    theta_P(idx,2)=real(sim_P.footPos(1,idx));
    theta_P(idx,3)=real(sim_P.footPos(2,idx));
    theta_P(idx,4)=real(sim_P.footPos(3,idx));
    theta_P(idx,5)=real(sim_P.footPos(4,idx));
end

end

