function [Xdot]=state_eq_new(t,X,t_vec,tau) 
%t_vec and tau are pre-defined!

tau_interp=[interp1(t_vec,tau(1,:),t);interp1(t_vec,tau(2,:),t)];


q=[X(1);X(3)];
dq=[X(2);X(4)];

H=double(dynamics_H_new(q));
C=double(dynamics_C_new(q,dq));
G=double(dynamics_G_new(q));

ddq=inv(H)*(-C*dq-G+tau_interp);

Xdot=[dq(1);ddq(1);dq(2);ddq(2)];
% Xdot=double(Xdot);
end