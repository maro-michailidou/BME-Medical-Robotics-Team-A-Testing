classdef TestForwardKinematics < matlab.unittest.TestCase
    methods (Test)
 function testGetForwardTransformationMatrixWithDifferentAngles(testCase)
        % Test get_forward_transformation_matrix function with different angles
        T_simplify = get_forward_transformation_matrix();

        % Check if the output is a 4x4 matrix
        testCase.verifySize(T_simplify, [4, 4]);

        % Check if the last row is [0, 0, 0, 1]
        testCase.verifyEqual(T_simplify(4, :), sym([0, 0, 0, 1]));
    end

    function testForwardKinematicsFuncWithZeroAngles(testCase)
        % Test forward_kinematics_func function with zero angles
        angles = [0, 0, 0];
        L1 = 5;
        L2 = 4;
        L3 = 3;
        theta_eff = 0;
        position = forward_kinematics_func(angles, L1, L2, L3, theta_eff);
        
        % Check if the output is a 3x1 vector
        testCase.verifySize(position, [3, 1]);
        
        % Check if the output is [L1+L2+L3; 0; 0] for these specific inputs
        expectedPosition = [L1 + L2 + L3; 0; 0];
        testCase.verifyEqual(position, expectedPosition, 'AbsTol', 1e-6);
    end
        function testForwardKinematicsFuncWithNonZeroAngles(testCase)
        % Test forward_kinematics_func function with non-zero angles
        angles = [pi/4, pi/4, pi/4];
        L1 = 5;
        L2 = 4;
        L3 = 3;
        theta_eff = pi/2;
        position = forward_kinematics_func(angles, L1, L2, L3, theta_eff);

        % Check if the output is a 3x1 vector
        testCase.verifySize(position, [3, 1]);

        % Check if the output is correct for these specific inputs
        % The expected position is calculated based on the forward kinematics of a 3-link manipulator
        expectedPosition = [L1*cos(angles(2)) + L2*cos(angles(2) + angles(3)) + L3*cos(theta_eff); 
                            L1*sin(angles(2)) + L2*sin(angles(2) + angles(3)) + L3*sin(theta_eff); 
                            0];
        testCase.verifyEqual(position, expectedPosition, 'AbsTol', 1e-6);
    end
    end
end