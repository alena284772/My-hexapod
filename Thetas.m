function shagi_thetas = Thetas(isLeft,vverh_0, num, T_f, T_b)


% Предварительные рассчеты для thet_S и thet_B
A = [0 0 1 0 0 0 0 0;
        0 0 0 0 0 T_f^2 T_f 1;
        T_b^2 T_b 1 -T_b -1 0 0 0;
        1/2*T_b 1 0 -1 0 0 0 0;
        0 0 0 -(T_f-T_b) -1 (T_f-T_b)^2 (T_f-T_b) 1;
        0 0 0 -1 0 1/2*(T_f-T_b) 1 0;
        0 1 0 0 0 0 0 0;
        0 0 0 0 0 1/2*T_f 1 0];
B_x = [1.5;1.5;0;0;0;0;0;0];
if isLeft==true
    B_y = [-0.5;0.5;0;0;0;0;0;0];
else
    B_y = [0.5;-0.5;0;0;0;0;0;0];
end

B_z = [-0.56;-0.56;0;0;0;0;0;0];

C_x = lsqr(A,B_x);
C_y = lsqr(A,B_y);
C_z = lsqr(A,B_z);


if vverh_0==true

    angles = thet_S(T_f, T_b, C_x, C_y, C_z,false);

    theta_B = thet_B(T_f, T_b, C_x, C_y, C_z,true);

    theta_P = thet_P(T_f,true);
else
    angles = thet_S(T_f, T_b, C_x, C_y, C_z,true);

    theta_B = thet_B(T_f, T_b, C_x, C_y, C_z,false);

    theta_P = thet_P(T_f,false);
end


% Рассчёт фазы перемещения
s = size(theta_B,1);
theta_T=zeros(s,5);

for idx = 1:s

    theta_T(idx,1)=theta_B(idx,1);

    theta_T(idx,2)=theta_P(idx,2) + theta_B(idx,2);
    theta_T(idx,3)=theta_P(idx,3) + theta_B(idx,3);
    theta_T(idx,4)=theta_P(idx,4) + theta_B(idx,4);
    theta_T(idx,5)=theta_P(idx,5) + theta_B(idx,5);
end

% Рассчёт одного шага
s = size(theta_T,1) + size(angles,1);

theta_shag = zeros(s,5);

for idx = 1:s
    if vverh_0 == true
        if idx <= size(theta_T,1)


            theta_shag(idx,1)=theta_T(idx,1);

            theta_shag(idx,2)=theta_T(idx,2);
            theta_shag(idx,3)=theta_T(idx,3);
            theta_shag(idx,4)=theta_T(idx,4);
            theta_shag(idx,5)=theta_T(idx,5);
        else

            theta_shag(idx)=angles(idx - size(theta_T,1),1);

            theta_shag(idx,2)=angles(idx - size(theta_T,1),2);
            theta_shag(idx,3)=angles(idx - size(theta_T,1),3);
            theta_shag(idx,4)=angles(idx - size(theta_T,1),4);
            theta_shag(idx,5)=angles(idx - size(theta_T,1),5);

        end
        
    else
        if idx <= size(angles,1)


            theta_shag(idx,1)=angles(idx,1);

            theta_shag(idx,2)=angles(idx,2);
            theta_shag(idx,3)=angles(idx,3);
            theta_shag(idx,4)=angles(idx,4);
            theta_shag(idx,5)=angles(idx,5);
        else


            theta_shag(idx,1)=theta_T(idx - size(angles,1),1);

            theta_shag(idx,2)=theta_T(idx - size(angles,1),2);
            theta_shag(idx,3)=theta_T(idx - size(angles,1),3);
            theta_shag(idx,4)=theta_T(idx - size(angles,1),4);
            theta_shag(idx,5)=theta_T(idx - size(angles,1),5);

        end
       

    end

end
    


% Рассчёт num шагов

s = size(theta_shag,1);
shagi_thetas = zeros(num*s,5);

for iter = 1:1:num
    for idx = 1:1:s
        
        shagi_thetas(s*(iter-1)+idx,1)=(2*T_f+0.005)*(iter-1)+theta_shag(idx,1);

        shagi_thetas(s*(iter-1)+idx,2)=theta_shag(idx,2);
        shagi_thetas(s*(iter-1)+idx,3)=theta_shag(idx,3);
        shagi_thetas(s*(iter-1)+idx,4)=theta_shag(idx,4);
        shagi_thetas(s*(iter-1)+idx,5)=theta_shag(idx,5);

    end

end

end

