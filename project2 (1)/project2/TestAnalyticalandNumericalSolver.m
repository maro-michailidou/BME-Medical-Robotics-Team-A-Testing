% Define input parameters
lengths = [10, 10, 10]; % Lengths of the finger segments (e.g., in cm)
jointAngles = [0.1, 0.2, 0.3, 0.4]; % Initial joint angles (in radians)
targetPosition = [15, 5, 10]; % Target end-effector position (e.g., in cm)

% Run analytical solver
[theta1_analytical, theta2_analytical, theta3_analytical, theta4_analytical, angles_info_analytical] = ...
    GUI_inverse_kinematics(lengths, targetPosition(1), targetPosition(2), targetPosition(3), 1.7174);

% Run numerical solver
model = RST_4DOF_finger_model(lengths(1)/100, lengths(2)/100, lengths(3)/100, 15);
model.setupFKSolver(50);
model.moveFingerToPosition(targetPosition / 100, false);
numericalPosition = model.getFingerEEPosition() * 100;
numericalAngles = deg2rad(model.getFingerAngles());

% Display results
fprintf('Analytical Solver Results:\n');
fprintf('Theta1: %.4f rad\n', theta1_analytical);
fprintf('Theta2: %.4f rad\n', theta2_analytical);
fprintf('Theta3: %.4f rad\n', theta3_analytical);
fprintf('Theta4: %.4f rad\n', theta4_analytical);

fprintf('\nNumerical Solver Results:\n');
fprintf('Theta1: %.4f rad\n', numericalAngles(1));
fprintf('Theta2: %.4f rad\n', numericalAngles(2));
fprintf('Theta3: %.4f rad\n', numericalAngles(3));
fprintf('Theta4: %.4f rad\n', numericalAngles(4));

% Compare positions
[~, ~, ~, analyticalPosition] = GUI_get_all_positions(lengths, [theta1_analytical, theta2_analytical, theta3_analytical, theta4_analytical]);
fprintf('\nEnd-Effector Position from Analytical Solver: [%.4f, %.4f, %.4f]\n', analyticalPosition(1), analyticalPosition(2), analyticalPosition(3));
fprintf('End-Effector Position from Numerical Solver: [%.4f, %.4f, %.4f]\n', numericalPosition(1), numericalPosition(2), numericalPosition(3));
