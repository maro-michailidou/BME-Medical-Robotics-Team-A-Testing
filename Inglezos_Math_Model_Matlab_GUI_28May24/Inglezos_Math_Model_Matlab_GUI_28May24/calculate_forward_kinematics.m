% Used during inverse kinematics, given both the end position and the
% specified rotation (total angle theta_eff) of the fingertip (end effector) 
% relative to global/base reference frame on the x-y plane.
% theta_eff is equal to the sum theta_MCP_fe + theta_PIP + theta_DIP
function position = forward_kinematics_func(angles, L1, L2, L3, theta_eff)
    % Define the forward kinematics function with fixed theta_eff
    % Set the display format to long
    format long;

    % Extract angles
    theta_MCP_aa = angles(1);
    theta_MCP_fe = angles(2);
    theta_PIP = angles(3);
    theta_DIP = theta_eff - theta_MCP_fe - theta_PIP;

    % Use sym to create symbolic variables
    alpha = sym('alpha');
    r = sym('r');
    theta = sym('theta');
    d = sym('d');
    
    % MDH parameters
    mdh_table = [0, 0, theta_MCP_aa, 0; pi/2, 0, theta_MCP_fe, 0; 0, L1, theta_PIP, 0; 0, L2, theta_DIP, 0];

    % Define transformation matrix components
    T_cur_prev = [cos(theta), -sin(theta), 0, r; ...
                  sin(theta)*cos(alpha), cos(theta)*cos(alpha), -sin(alpha), -d*sin(alpha); ...
                  sin(theta)*sin(alpha), cos(theta)*sin(alpha), cos(alpha), d*cos(alpha); ...
                  0, 0, 0, 1];

    % Calculate transformation matrices for each joint
    T_1_0 = subs(T_cur_prev, [alpha, r, theta, d], mdh_table(1, :));
    T_2_1 = subs(T_cur_prev, [alpha, r, theta, d], mdh_table(2, :));
    T_3_2 = subs(T_cur_prev, [alpha, r, theta, d], mdh_table(3, :));
    T_4_3 = subs(T_cur_prev, [alpha, r, theta, d], mdh_table(4, :));

    % Define the transformation matrix for the end-effector
    T_eff_4 = [1, 0, 0, L3; 0, 1, 0, 0; 0, 0, 1, 0; 0, 0, 0, 1];

    % Calculate the total transformation matrix
    T_total = T_1_0 * T_2_1 * T_3_2 * T_4_3 * T_eff_4;

    % Extract position components (x, y, z)
    position = double(T_total(1:3, 4));
end