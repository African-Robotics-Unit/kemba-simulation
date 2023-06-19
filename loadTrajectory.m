traj = readtable('traj.csv');

Traj.duration = traj.time(end);

Kp = 100;
Kd = 3;
t0 = 0.0;

% right motor
Traj.right_motor.q = timeseries(traj.qm_f, traj.time);
Traj.right_motor.w = timeseries(traj.wm_f, traj.time);
Traj.right_motor.Kp = append(timeseries(30, traj.time(traj.time<=t0)), timeseries(Kp, traj.time(traj.time>t0)));
Traj.right_motor.Kd = append(timeseries(3, traj.time(traj.time<=t0)), timeseries(Kd, traj.time(traj.time>t0)));
Traj.right_motor.tff = timeseries(traj.tm_f, traj.time);

% left motor
Traj.left_motor.q = timeseries(traj.qm_b, traj.time);
Traj.left_motor.w = timeseries(traj.wm_b, traj.time);
Traj.left_motor.Kp = append(timeseries(30, traj.time(traj.time<=t0)), timeseries(Kp, traj.time(traj.time>t0)));
Traj.left_motor.Kd = append(timeseries(3, traj.time(traj.time<=t0)), timeseries(Kd, traj.time(traj.time>t0)));
Traj.left_motor.tff = timeseries(traj.tm_b, traj.time);

% right piston
Traj.right_piston.ue = timeseries(traj.ue_f, traj.time);
Traj.right_piston.ur = timeseries(traj.ur_f, traj.time);
Traj.right_piston_state_des.p = timeseries(traj.xp_f, traj.time);
Traj.right_piston_state_des.v = timeseries(traj.vp_f, traj.time);

% left piston
Traj.left_piston.ue = timeseries(traj.ue_b, traj.time);
Traj.left_piston.ur = timeseries(traj.ur_b, traj.time);
Traj.left_piston_state_des.p = timeseries(traj.xp_b, traj.time);
Traj.left_piston_state_des.v = timeseries(traj.vp_b, traj.time);

% body
Traj.body.x = timeseries(traj.x, traj.time);
Traj.body.y = timeseries(traj.y, traj.time);
Traj.body.r = timeseries(traj.r, traj.time);
Traj.body.dx = timeseries(traj.dx, traj.time);
Traj.body.dy = timeseries(traj.dy, traj.time);
Traj.body.dr = timeseries(traj.dr, traj.time);
Traj.body.ddx = timeseries(traj.ddx, traj.time);
Traj.body.ddy = timeseries(traj.ddy, traj.time);

