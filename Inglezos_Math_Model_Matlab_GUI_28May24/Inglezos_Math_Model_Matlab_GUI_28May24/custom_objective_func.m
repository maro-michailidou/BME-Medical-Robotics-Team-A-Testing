function error = custom_objective_func(angles, L1, L2, L3, x_des, y_des, z_des, theta_eff)   
    % Calculate end-effector position using forward kinematics
    position = forward_kinematics_func(angles, L1, L2, L3, theta_eff);
    % Calculate the position error
    error = position - [x_des; y_des; z_des];
end