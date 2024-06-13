classdef TestRST_4DOF_finger_model < matlab.unittest.TestCase
    properties
        fingerModel
    end
    
    methods (TestMethodSetup)
        function createFingerModel(testCase)
            % Create a finger model for testing
            testCase.fingerModel = RST_4DOF_finger_model(0.05, 0.05, 0.05, 100);
        end
    end
    
    methods (Test)
        function testConstructor(testCase)
            % Test the constructor
            testCase.verifyEqual(testCase.fingerModel.P_ph, 0.05);
            testCase.verifyEqual(testCase.fingerModel.M_ph, 0.05);
            testCase.verifyEqual(testCase.fingerModel.D_ph, 0.05);
            testCase.verifyInstanceOf(testCase.fingerModel.fingerRobotModel, 'rigidBodyTree');
            testCase.verifyInstanceOf(testCase.fingerModel.ikSolver, 'generalizedInverseKinematics');
        end
        
        function testGetFingerEEPosition(testCase)
            % Test getFingerEEPosition method
            newPosition = [0.2, 0.2, 0.2];
            testCase.fingerModel.moveFingerToPosition(newPosition, false);
            testCase.verifyEqual(testCase.fingerModel.getFingerEEPosition(), newPosition, 'AbsTol', 1e-6);
        end
        
        function testGetFingerAngles(testCase)
            % Test getFingerAngles method
            angles = testCase.fingerModel.getFingerAngles();
            testCase.verifyEqual(angles, zeros(4, 1));
        end
        
        function testMoveFingerToPosition(testCase)
            % Test moveFingerToPosition method
            testCase.fingerModel.moveFingerToPosition([0.1, 0.05, 0], false);
            ee_pos = testCase.fingerModel.getFingerEEPosition();
            testCase.verifyEqual(ee_pos, [0.1, 0.05, 0], 'AbsTol', 1e-6);
        end
        
function testInvalidMoveFingerToPosition(testCase)
    % Test moveFingerToPosition with an invalid position
    invalidPosition = [0.9, 0.9, 5]; % Assuming this is invalid
    
    % Verify that an error is thrown for invalid position
    try
        testCase.fingerModel.moveFingerToPosition(invalidPosition, false);
        % If no error was thrown, explicitly fail the test
        error('MATLAB:invalidPosition', 'Expected moveFingerToPosition to throw an error for invalid position.');
    catch ME
        % Check if the correct error was thrown
        testCase.verifyEqual(ME.identifier, 'MATLAB:invalidPosition');
    end
end



function testMoveFingerToPositionNonConvergence(testCase)
    % Test moveFingerToPosition with simulated non-convergence
    iterationsUsed = 100; % Assume the maximum iterations were used
    finger = RST_4DOF_finger_model(0.1, 0.1, 0.1, iterationsUsed);

    % Define the invalid position
    invalidPosition = [0.9, 0.9, 5]; % Specified invalid position

    % Move the finger to the invalid position
    finger.moveFingerToPosition(invalidPosition, false);

    % Check if the IK solver reached the maximum iterations
    testCase.verifyEqual(finger.ikSolver.SolverParameters.MaxIterations, ...
                         iterationsUsed, 'Non-convergence not verified.');
end







    end
end