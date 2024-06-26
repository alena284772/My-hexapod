# My-hexapod
Building a robot trajectory

* `Leg.slx` -- Model of one leg in Simulink
* `My_hexapod.slx` -- Model of a walking robot in Simulink
* `Project.mlx` -- Setting model parameters, constructing a trajectory, outputting simulation results
* `Thetas.m` -- Auxiliary function for constructing the trajectory of the robot's leg

* `my_inv.m` -- Solution of the inverse kinematics problem (used when constructing a trajectory)
* `my_pr.m` -- Solution of the direct kinematics problem

* `thet_B.m` -- Constructing a trajectory in the movement phase (mirror trajectory thet_S)
* `thet_P.m` -- Constructing a trajectory in the movement phase (responsible for raising the leg)
* `thet_S.m` -- Building a trajectory in the support phase
