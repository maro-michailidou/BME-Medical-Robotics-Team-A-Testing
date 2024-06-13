classdef TestGUIInverseKinematics < matlab.unittest.TestCase
    methods (Test)
        function testValidInputs(testCase)
            lengths = [0.1, 0.1, 0.1];
            x = 0.05;
            y = 0.05;
            z = 0.05;
            angle = pi/4;
            
            [theta_MCP_aa_sol, theta_MCP_fe_sol, theta_PIP_sol, theta_DIP_sol, angles_info] = GUI_inverse_kinematics(lengths, x, y, z, angle);
            
            testCase.verifyEqual(theta_MCP_aa_sol, atan2(y, x), 'AbsTol', 1e-6);
            testCase.verifyEqual(theta_MCP_fe_sol, atan2(z - lengths(3)*sin(angle), sqrt(x^2 + y^2) - lengths(3)*cos(angle)), 'AbsTol', 1e-6);
            testCase.verifyEqual(theta_PIP_sol, acos((x^2 + y^2 + z^2 + lengths(3)^2 - 2*lengths(3)*(sqrt(x^2 + y^2)*cos(angle) + z*sin(angle)) - lengths(1)^2 - lengths(2)^2) / (2*lengths(1)*lengths(2))), 'AbsTol', 1e-6);
            testCase.verifyEqual(theta_DIP_sol, angle - theta_MCP_fe_sol - theta_PIP_sol, 'AbsTol', 1e-6);
            testCase.verifyEqual(angles_info.message, 'Valid angles');  % Expect 'Valid angles' for valid case
        end
        
        function testInvalidInputs(testCase)
            lengths = [0.1, 0.1, 0.1];
            x = 0.05;
            y = 0.05;
            z = 0.2;
            angle = pi/4;
            
            [theta_MCP_aa_sol, theta_MCP_fe_sol, theta_PIP_sol, theta_DIP_sol, angles_info] = GUI_inverse_kinematics(lengths, x, y, z, angle);
            
            testCase.verifyEqual(theta_MCP_aa_sol, atan2(y, x), 'AbsTol', 1e-6);
            testCase.verifyEqual(theta_MCP_fe_sol, NaN);
            testCase.verifyEqual(theta_PIP_sol, NaN);
            testCase.verifyEqual(theta_DIP_sol, NaN);
            testCase.verifyEqual(angles_info.message, 'Invalid angles');  % Expect 'Invalid angles' for invalid case
        end
    end
end
