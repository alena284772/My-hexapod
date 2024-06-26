function pos = my_pr(q1,q2,q3,q4,L1,L2,L3,L4)
%MY_PR Summary of this function goes here
%   Detailed explanation goes here


x = cos(q1)*(L1+L2*cos(q2)+L3*cos(q2+q3)+L4*cos(q2+q3+q4));
y = sin(q1)*(L1+L2*cos(q2)+L3*cos(q2+q3)+L4*cos(q2+q3+q4));
z = L2*sin(q2) + L3*sin(q2+q3) + L4*sin(q2+q3+q4);

pos = [x;y;z];

end

