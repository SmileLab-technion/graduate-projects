function status = myOutPutFcnPD(t,y,flag)
global tau t_Build q_theoretic dq_theoretic ddq_theoretic
global kp kd kp1 kp2 kd1 kd2
persistent count

switch flag
    case 'init'
        % parameter of the controle law
        kp = [kp1 0; 0 kp2];
        kd = [kd1 0; 0 kd2];
        disp('Start...')
        count = 1;
       
    case ''
        q_d = interp1(t_Build,q_theoretic',t(end))';
        dqd = interp1(t_Build,dq_theoretic',t(end))';
        
        q=[y(1);y(3)];
        dq=[y(2);y(4)];
        
        % dynamics matrix
        H = double(dynamics_H_new(q));
        C = double(dynamics_C_new(q,dq));
        G = double(dynamics_G_new(q));
        qd = interp1(t_Build,q_theoretic',t(end))';
        dqd = interp1(t_Build,dq_theoretic',t(end))';
       ddqd =interp1(t_Build, ddq_theoretic',t(end))';
        % controle law
%        tau = C*dq+G+H*(ddqd-kp*(q-qd)-kd*(dq-dqd));
         tau = G-kp*(q-qd)-kd*(dq-dqd);
        count = count +1; 
        
    case 'done'
        disp('Number of Controller Counts:')
        disp(count)
        disp('done.')
end

status = 0;

end

