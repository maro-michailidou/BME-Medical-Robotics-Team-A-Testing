classdef GUI_get_all_positionsTest < matlab.unittest.TestCase
    methods (Test)
        function testGUI_get_all_positions(testCase)
            % Test GUI_get_all_positions function
            lengths = [1, 2, 3];
            angles = [pi/4, pi/4, pi/4, pi/4];
            [MCP_aa_fe_position, PIP_position, DIP_position, eff_position] = GUI_get_all_positions(lengths, angles);
            
            % Check if the output is a 3x1 vector and real
            testCase.verifySize(MCP_aa_fe_position, [3, 1]);
            testCase.verifyTrue(isreal(MCP_aa_fe_position));
            
            testCase.verifySize(PIP_position, [3, 1]);
            testCase.verifyTrue(isreal(PIP_position));
            
            testCase.verifySize(DIP_position, [3, 1]);
            testCase.verifyTrue(isreal(DIP_position));
            
            testCase.verifySize(eff_position, [3, 1]);
            testCase.verifyTrue(isreal(eff_position));
        end

        % This test checks the functionality of the GUI_get_all_positions function in MATLAB. 
% The testGUI_get_all_positions method does the following:
% It calls the GUI_get_all_positions function with specific input values for lengths and angles.
% It verifies that the function returns four outputs (MCP_aa_fe_position, PIP_position, DIP_position, eff_position), each of which should be a 3x1 vector. This is checked using the testCase.verifySize method.
% It checks that each of these output vectors is real (i.e., it does not contain any complex numbers). This is checked using the testCase.verifyTrue method in combination with the isreal function.
% If the GUI_get_all_positions function does not return 3x1 real vectors for the given inputs, the test will fail.


        function testInvalidLengthsInput(testCase)
            % Test GUI_get_all_positions function with invalid lengths input
            lengths = []; % empty array
            angles = [pi/4, pi/4, pi/4, pi/4];
            testCase.verifyError(@() GUI_get_all_positions(lengths, angles), 'MATLAB:badsubscript');
        end

        % This test checks the behavior of the GUI_get_all_positions function when it is given an empty array for the lengths input. 
        % The testCase.verifyError method is used to check that the function throws an error when given this invalid input. The expected error is 'MATLAB:badsubscript', which is the error MATLAB throws when you try to access an element at an index that does not exist in an array.

        function testInvalidAnglesInput(testCase)
            % Test GUI_get_all_positions function with invalid angles input
            lengths = [1, 2, 3];
            angles = [pi/4, pi/4]; % array of incorrect size
            testCase.verifyError(@() GUI_get_all_positions(lengths, angles), 'MATLAB:badsubscript');
        end
        % This test checks the behavior of the GUI_get_all_positions function when it is given an array of incorrect size for the angles input. Again, the testCase.verifyError method is used to check that the function throws an error. The expected error is the same as in the previous test.
        % In both tests, the @() syntax is used to create an anonymous function that calls GUI_get_all_positions with the specified inputs. This is necessary because verifyError expects a function handle as its first argument, and we want to call GUI_get_all_positions with specific arguments.
        %THIS TEST SHOULD FAIL SINCE WE ARE PASSING AN ARRAY OF INCORRECT
        %SIZE
    function testInvalidForwardKinematicsInput(testCase)
        % Test forward_kinematics_func function with invalid angles input
        angles = [0, 0]; % array of incorrect size
        L1 = 5;
        L2 = 4;
        L3 = 3;
        theta_eff = 0;
        testCase.verifyError(@() forward_kinematics_func(angles, L1, L2, L3, theta_eff), 'MATLAB:badsubscript');
    end
    end
end

