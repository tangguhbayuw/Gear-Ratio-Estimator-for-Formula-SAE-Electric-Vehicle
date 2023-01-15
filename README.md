# Gear-Ratio-Estimator-for-Formula-SAE-Electric-Vehicle

## Description
Gear Ratio Estimator is a program that is made to estimate the gear ratio value that you need for your Formula SAE EV design. The gear ratio is needed to convert the speed and torque from the electric motor to the speed and torque that you need for your vehicle. The estimator is estimating the gear ratio using an acceleration test, where the vehicle needs to accelerate from 0 to certain speed in kph in 75 m. The estimator will simulate the acceleration test where the gear ratio value starts from 3 until 10. After that the estimator will find the fastest time when the vehicle finish the 75 m acceleration. The estimator will show you the fittest gear ratio value with its finish time, vehicle's velocity when finish the test, and the maximum velocity. This estimator is compatible for a single motor electric vehicle.
<br>
There are few parameters needed for this estimator, such as:
1. FrontArea = Front Area Cross Section (m<sup>2</sup>)
2. AirDensity = Air Density (kg/m<sup>3</sup>)
3. DragCoeff = Vehicle Drag Coefficient
4. WheelRadius = Vehicle Wheel Radius (m)
5. MechanicalEfficiency = Mechanical Efficiency
6. Mass = Vehicle Mass (kg)
7. Max RPM = Maximum RPM of the electric motor (rpm)
8. PeakTorque = Peak Torque of the electric motor (Nm)
<br>
Don't change any value from the variables except the paramaters that is already mentioned above!!
