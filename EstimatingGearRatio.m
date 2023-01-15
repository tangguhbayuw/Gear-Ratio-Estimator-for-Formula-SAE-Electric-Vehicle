clear all
clc
%% Estimating Optimum Gear Ratio
j = 1;
GRDelta = 0.01; 
GR = 3; %start of gear ratio estimating

while (GR <= 10)
    %% Set parameters
    FrontArea = 1.38; %sq meters
    AirDensity = 1.2250; %kg/cubic meters
    DragCoeff = 0.655;
    WheelRadius = 0.26; %meters (10 inches)
    MechanicalEfficiency = 0.98;
    Mass = 320; %kg
    Distance = 75; %meters
    TimeDelta = 0.01; %second
    EndTime = 100; %10 seconds
    Acceleration = 0; %M/s/s
    Velocity = 0; %M/s
    Position = 0; % M
    Pi = 35; %PSI (Agus riset dulu)
    angle=0; %degree
    
    % Set Maximum RPM and Peak Torque on Motor
    MaxRpm = 6000; %RPM
    PeakTorque = 80; %Nm
    
    % Max Speed
    MaxSpeed = ((MaxRpm/GR/60) * (WheelRadius*2*pi)); %m/s
    
    %% Acceleration Power Simulation
    i = 1;
    while (i <= 100/.01)
        ForceDrag = (0.5)*AirDensity*DragCoeff*FrontArea*(Velocity.^2); % Aerodynamic Drag
        ForceAtWheels = PeakTorque/WheelRadius * GR * MechanicalEfficiency;
        
        if (Velocity >= MaxSpeed)
            ForceAtWheels = ForceDrag;
            Velocity = MaxSpeed;
            Acceleration = 0;
        else
            Acceleration = (ForceAtWheels - ForceDrag)/Mass;
            Velocity = Velocity + (Acceleration * TimeDelta);
        end
        
        Accel(j,i) = Acceleration;
        Position = Position + (Velocity * TimeDelta);
        Power(j,i) = ((ForceAtWheels * Velocity) / 0.95) / MechanicalEfficiency; %taking into account motor efficiency and drivetrain losses
        
        % Finish 75m Acceleration
        if(Position > Distance)
            FinishTime(j) = i / 100; %Finish time (s)
            FinishVelocity(j) = Velocity * 3.6; % Finish Velocity (m/s)
            CurrentMaxSpeed(j) = MaxSpeed * 3.6; %Max Speed with current gear ratio (m/s)
            break;
        end
            
        i = i + 1;
        Times(i) = i*TimeDelta;
    end
    
    GearRatio(j) = GR;
    GR = GR + GRDelta;
    j = j + 1;
end

%% Results
Fastest = find(FinishTime == min(FinishTime(:)));
fprintf('GR : %f\n', GearRatio(Fastest(1)));
fprintf('Finish on %f seconds at %f km/h (Max = %f km/h)\n', FinishTime(Fastest(1)), FinishVelocity(Fastest(1)), CurrentMaxSpeed(Fastest(1)));
%% Graph
subplot(3,1,1), plot(Times, Power(Fastest(1),:))
title('Power Consumption on Acceleration (75m)')
xlabel('Time (s)')
ylabel('Power (W)')
axis([0 6 0 75000])
grid on
subplot(3,1,2), plot(Times, Accel(Fastest(1),:))
axis([0 6 0 6])
title('Acceleration vs Time')
xlabel('Time (s)')
ylabel('Acceleration (m/s^2)')
grid on
subplot(3,1,3), plot(GearRatio, FinishTime)
axis([0 10 0 10])
title('Gear Ratio vs Finish Time')
xlabel('Gear Ratio')
ylabel('Finish Time (s)')
grid on