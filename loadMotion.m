[file,path] = uigetfile('*.csv', 'Select Trajectory');
traj = readtable(fullfile(path,file));

% make sure time starts at 0
traj.time = traj.time - traj.time(1);

Log.duration = traj.time(end);

Log.MotorState.R.q = timeseries(traj.qm_f, traj.time);
Log.MotorState.R.w = timeseries(traj.wm_f, traj.time);

Log.MotorState.L.q = timeseries(traj.qm_b, traj.time);
Log.MotorState.L.w = timeseries(traj.wm_b, traj.time);

Log.PistonState.R.p = timeseries(traj.xp_f, traj.time);
Log.PistonState.R.v = timeseries(traj.vp_f, traj.time);
Log.PistonCommand.R.ue = timeseries(traj.ue_f, traj.time);
Log.PistonCommand.R.ur = timeseries(traj.ur_f, traj.time);

Log.PistonState.L.p = timeseries(traj.xp_b, traj.time);
Log.PistonState.L.v = timeseries(traj.vp_b, traj.time);
Log.PistonCommand.L.ue = timeseries(traj.ue_b, traj.time);
Log.PistonCommand.L.ur = timeseries(traj.ur_b, traj.time);

Log.Body.x = timeseries(traj.x, traj.time);
Log.Body.dx = timeseries(traj.dx, traj.time);
Log.Body.ddx = timeseries(traj.ddx, traj.time);
Log.Body.y = timeseries(traj.y, traj.time);
Log.Body.dy = timeseries(traj.dy, traj.time);
Log.Body.ddy = timeseries(traj.ddy, traj.time);
Log.Body.r = timeseries(traj.r, traj.time);
Log.Body.dr = timeseries(traj.dr, traj.time);
