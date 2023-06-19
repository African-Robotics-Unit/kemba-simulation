%% Inertia
% https://www.mathworks.com/help/physmod/sm/ug/specify-custom-inertia.html
% NB: by default solidworks gives inertia tensor in positive notation
Body.mass = 2886.23; % g
Body.CoM = [0 -0.72 -22.56]; % [x y z] mm
Body.MoI = [2700100.82  122084070.87  123624454.40]; % [Lxx Lyy Lzz] gmm^2
Body.PoI = -[35336.50 -30.11 230.99]; % [Lyz Lzx Lxy] gmm^2

Femur.Right.mass = 332.90; % g
Femur.Right.CoM = [95.03 4.24 19.71]; % [x y z] mm
Femur.Right.MoI = [119296.69 2970311.77 2981115.38]; % [Lxx Lyy Lzz] gmm^2
Femur.Right.PoI = -[3907.50 93117.38 -72966.52]; % [Lyz Lzx Lxy] gmm^2

Femur.Left.mass = 332.90; % g
Femur.Left.CoM = [95.03 -4.24 19.71]; % [x y z] mm
Femur.Left.MoI = [119296.69 2970311.77 2981115.38]; % [Lxx Lyy Lzz] gmm^2
Femur.Left.PoI = -[-3907.50 93117.38 72966.52]; % [Lyz Lzx Lxy] gmm^2

Tibia.mass = 159.24; % g
Tibia.CoM = [-109.44 -0.68 0.05]; % [x y z] mm
Tibia.MoI = [20796.07 1261060.35 1264673.14]; % [Lxx Lyy Lzz] gmm^2
Tibia.PoI = -[5.80 522.67 -6951.40]; % [Lyz Lzx Lxy] gmm^2

Piston.Body.mass = 229.70; % g
Piston.Body.CoM = [75.20 2.59 0.14]; % [x y z] mm
Piston.Body.MoI = [32528.09 763808.27 777104.29]; % [Lxx Lyy Lzz] gmm^2
Piston.Body.PoI = -[769.93 23.49 675.15]; % [Lyz Lzx Lxy] gmm^2

Piston.Rod.mass = 71.12; % g
Piston.Rod.CoM = [0 0 77.90]; % [x y z] mm
Piston.Rod.MoI = [225318.30 225248.46 1949.13]; % [Lxx Lyy Lzz] gmm^2
Piston.Rod.PoI = -[0 0 0]; % [Lyz Lzx Lxy] gmm^2

%% Visual
mesh_color = [1.0 1.0 1.0 0.75]; % RGBA
foot_color = [0.3 0.3 0.3 1.0]; % RGBA
ground_color = [0.5 0.5 0.5 0.25]; % RGBA
Body.color = mesh_color;

Boom.Base.color = [1.0 1.0 1.0 1.0]; % RGBA
Boom.Center.color = [1.0 1.0 1.0 1.0]; % RGBA
Boom.Pole.color = [0.4 0.4 0.4 1.0]; % RGBA
Boom.End.color = [1.0 1.0 1.0 1.0]; % RGBA

%% Joints
Piston.Limit.lower = 0; % mm
Piston.Limit.upper = 70; % mm
Piston.Limit.stiffness = 1e7; % N/m
Piston.Limit.damping = 1e7; % Ns/m
Piston.Limit.transition_region_width = 1e-3; % m

%% Contacts
Contact.stiffness = 1e4; % N/m
Contact.damping = 1e3; % Ns/m
Contact.transition_region_width = 1e-3; % m
Contact.mu_s = 1.0; % static friction
Contact.mu_d = 1.0; % dynamic friction
Contact.mu_vth = 1e-3; % m/s

%% Planarising Boom
Boom.pitchRadius = 2.493; % m
Boom.yawRadius = 2.575; % m
Boom.pitchHeightOffset = 0.101; % m

%% AK70-10 Gearbox
T = 8e-3; % m
N = 6; % gear ratio

% Ring Gear Parameters
Ring.RGB = [1.0 1.0 1.0];
Ring.R = 23.75e-3; % m
Ring.Width = 4e-3; % m

% Sun Gear Parameters
Sun.RGB = [1.0 1.0 1.0];
Sun.R = Ring.R / (N*(1-1/N));
Sun.MoI = [0 0 1]; % [Lxx Lyy Lzz] gmm^2

% Planet Gear Parameters
Planet.RGB = [1.0 1.0 1.0];
Planet.R = (Ring.R-Sun.R)/2;
Planet.MoI = [0 0 1]; % [Lxx Lyy Lzz] gmm^2 (Degenerate mass otherwise...)

% Gear Carrier Parameters
Carrier.L = Sun.R + Planet.R;

% Rotor Parameters
Rotor.color = [1.0 1.0 1.0 1.0]; % RGBA
Rotor.MoI = [0 0 120000]; % [Lxx Lyy Lzz] gmm^2

%% Initial Conditions
Body.x0 = 0; % m
Body.y0 = 0.18; % m 0.172
Body.r0 = 0; % rad

Boom.y0 = 0.18;
Boom.Yaw.q0 = 0; % rad
Boom.Pitch.q0 = asin((Boom.y0 - Boom.pitchHeightOffset)/Boom.pitchRadius); % rad
Boom.Roll.q0 = 0; % rad

Piston.Right.p0 = 0; % m
Piston.Right.v0 = 0; % m/s
Piston.Left.p0 = 0; % m
Piston.Left.v0 = 0; % m/s

Hip.Right.q0 = -pi+1.0*0.23*pi; % rad
Hip.Right.w0 = 0; % rad/s
Hip.Left.q0 = -1.0*0.23*pi; % rad
Hip.Left.w0 = 0; % rad/s
