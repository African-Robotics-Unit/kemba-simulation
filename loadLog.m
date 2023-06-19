[file,path] = uigetfile('*.mat', 'Select a Log File');
logFile = load(fullfile(path,file)).logsOut;

Log.duration = getElement(logFile,'body').Values.x.Time(end);

Log.MotorState.R.q = getElement(logFile,'motor state (R)').Values.q;
Log.MotorState.R.w = getElement(logFile,'motor state (R)').Values.w;

Log.MotorState.L.q = getElement(logFile,'motor state (L)').Values.q;
Log.MotorState.L.w = getElement(logFile,'motor state (L)').Values.w;

Log.PistonState.R.p = getElement(logFile,'piston state (R)').Values.p;
Log.PistonState.R.v = getElement(logFile,'piston state (R)').Values.v;
Log.PistonCommand.R.ue = getElement(logFile,'piston command (R)').Values.ue;
Log.PistonCommand.R.ur = getElement(logFile,'piston command (R)').Values.ur;

Log.PistonState.L.p = getElement(logFile,'piston state (L)').Values.p;
Log.PistonState.L.v = getElement(logFile,'piston state (L)').Values.v;
Log.PistonCommand.L.ue = getElement(logFile,'piston command (L)').Values.ue;
Log.PistonCommand.L.ur = getElement(logFile,'piston command (L)').Values.ur;

Log.Body.x = getElement(logFile,'body').Values.x;
Log.Body.dx = getElement(logFile,'body').Values.dx;
Log.Body.ddx = getElement(logFile,'body').Values.ddx;
Log.Body.y = getElement(logFile,'body').Values.y;
Log.Body.dy = getElement(logFile,'body').Values.dy;
Log.Body.ddy = getElement(logFile,'body').Values.ddy;
Log.Body.r = getElement(logFile,'body').Values.r;
Log.Body.dr = getElement(logFile,'body').Values.dr;

Log.Commands.body_height = getElement(logFile,'commands').Values.height;
Log.Commands.speed = getElement(logFile,'commands').Values.speed;
Log.Commands.start = getElement(logFile,'commands').Values.start;
Log.Commands.stop = getElement(logFile,'commands').Values.stop;
Log.Commands.feedforward = timeseries(0);
