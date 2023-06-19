% constants
lf = 0.242; lt = 0.234; lpo = 0.031; lpa = 0.048; lb = 0.522;
piston_offset = 0.2057;

leg = ['f', 'b'];
sign = [+1, -1];
motor_offset = [0.736-pi, -0.730];
 
% loop for front and back leg
for i = 1:2
    sgn = sign(i); % there is only a sign change between the right and left legs
    % actuator to joint
    syms theta_m l_ps
%     theta_f = -theta_m + motor_offset(i);
    theta_f = theta_m;
    l_p = l_ps + piston_offset;
    % angle of knee
    theta_k = acos((l_p^2 - (lpo^2+lf^2) - lpa^2) / (-2*sqrt(lpo^2+lf^2)*lpa)) + atan(lpo/lf);
    
    % forward kinematics polar
    syms theta_b
    r = sqrt(lf^2 + lt^2 - 2*lf*lt*cos(theta_k));
    phi = theta_f + sgn*asin((lt*sin(theta_k))/r) + theta_b;
    
    % hip height in world frame
    syms x_body y_body dx_body dy_body dtheta_b
    x_hip = x_body + sgn*0.5*lb*cos(theta_b);
    y_hip = y_body + sgn*0.5*lb*sin(theta_b);
    dx_hip = dx_body - sgn*0.5*lb*sin(theta_b)*dtheta_b;
    dy_hip = dy_body + sgn*0.5*lb*cos(theta_b)*dtheta_b;
    matlabFunction(x_hip,dx_hip,y_hip,dy_hip,'File', sprintf('hip_pos_%s', leg(i)));
    
    % foot position in world frame
    x_foot = x_hip + r*cos(phi);
    y_foot = y_hip + r*sin(phi);
    % save function
    matlabFunction(x_foot,y_foot,'File', sprintf('foot_pos_%s', leg(i)));
    
    % polar jacobian
    syms phi_d dphi_d dl_ps dtheta_m
    J_polar = jacobian([r,phi], [theta_m,l_ps,theta_b]);
    A = J_polar*[dtheta_m; dl_ps; dtheta_b];
    dr = A(1);
    dphi = A(2);
    matlabFunction(r,dr,phi,dphi,'File', sprintf('virtural_leg_%s', leg(i)));
    
    % maintaining a virtural leg angle
    eqn = phi_d == phi;
    theta_m = solve(eqn, theta_m);
    
    A = J_polar*[dtheta_m; dl_ps; dtheta_b];
    eqn = dphi_d == A(2);
    dtheta_m = solve(eqn, dtheta_m);
    
    matlabFunction(theta_m, dtheta_m,'File', sprintf('phi_tracking_%s', leg(i)));
end
