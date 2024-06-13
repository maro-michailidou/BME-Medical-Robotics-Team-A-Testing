classdef custom_objective_funcTest_renamed < matlab.unittest.TestCase
    methods (Test)
        function testCustomObjectiveFunc(testCase)
            % Test custom_objective_func function
            angles = [0, 0, 0];
            L1 = 5;
            L2 = 4;
            L3 = 3;
            
            % Test case 1: Zero desired position
            x_des = L1 + L2 + L3;
            y_des = 0;
            z_des = 0;
            theta_eff = 0;
            error = custom_objective_func(angles, L1, L2, L3, x_des, y_des, z_des, theta_eff);
            
            % Check output size and zero error
            testCase.verifySize(error, [3, 1]);
            expectedError = [0; 0; 0];
            testCase.verifyEqual(error, expectedError, 'AbsTol', 1e-6);
            disp('Test 1 passed: Zero error for zero desired position');
            
            % Test case 2: Non-zero desired position
            x_des = 2;
            y_des = 1;
            z_des = 0;
            theta_eff = 0;
            error = custom_objective_func(angles, L1, L2, L3, x_des, y_des, z_des, theta_eff);
            
            % Check for non-zero error
            testCase.verifyNotEqual(error, expectedError);
            disp('Test 2 passed: Non-zero error for non-zero desired position');
        end
    end
end
