% custom_objective_funcTest.m
classdef custom_objective_funcTest_renamed < matlab.unittest.TestCase % Renamed the test case
    methods (Test)
        function testCustomObjectiveFunc(testCase)
            % Test custom_objective_func function
            angles = [0, 0, 0];
            L1 = 5;
            L2 = 4;
            L3 = 3;
            x_des = L1 + L2 + L3;
            y_des = 0;
            z_des = 0;
            theta_eff = 0;
            error = custom_objective_func(angles, L1, L2, L3, x_des, y_des, z_des, theta_eff);
            
            % Check if the output is a 3x1 vector
            testCase.verifySize(error, [3, 1]);
            
            % Check if the output is [0; 0; 0] for these specific inputs
            expectedError = [0; 0; 0];
            testCase.verifyEqual(error, expectedError, 'AbsTol', 1e-6);
        end
    end
end
