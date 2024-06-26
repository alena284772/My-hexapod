function th = my_inv(x,y,z,l1,l2,l3,l4)

% Решение обратной задачи кинематики

z=z+l4;
if x>0
    theta_1=atan(y/x);
elseif x==0
        theta_1 = pi/2;
elseif x<0
        theta_1 = pi-atan(y/-x);
end

d = sqrt((sqrt(x^2+y^2)-l1)^2+(z)^2);
cos_b = (d^2+l2^2-l3^2)/(2*l2*d);
cos_gamma = (l2^2+l3^2-d^2)/(2*l2*l3);
sin_a = -z/d;


theta_2 = acos(cos_b) - asin(sin_a);
theta_3 = pi - acos(cos_gamma);
theta_4 = 2*pi-(pi-(pi/2-theta_2)-(2*pi-(2*pi-theta_3)));


th = [theta_1; theta_2; theta_3; theta_4];

end

