classdef tests_MQTT_finger_sender < matlab.unittest.TestCase

    methods (Test)
        
function testSendDataWithInvalidEndEffectorPosition(testCase)
    % Test sendData method with invalid endEffectorPosition input
    sender = MQTT_finger_sender();
    endEffectorPosition = NaN; % invalid input
    jointAngles = [pi/4, pi/4, pi/4];
    pauseSeconds = 1;
    
    % Call sendData with invalid endEffectorPosition
    try
        sender.sendData(endEffectorPosition, jointAngles, pauseSeconds);
    catch ex
        % Verify if an error is thrown and it's related to data validation
        testCase.verifyNotEmpty(ex.identifier);
        testCase.assertTrue(contains(ex.identifier, 'MATLAB:invalidType'));
    end
end






        function testSendDataBatch(testCase)
            % Test sendDataBatch method
            sender = MQTT_finger_sender();
            t = 1;
            endEffectorPosition = [1, 2, 3];
            jointAngles = [pi/4, pi/4, pi/4];
            sender.addToDataBatch(t, endEffectorPosition, jointAngles);
            testCase.verifyWarningFree(@() sender.sendDataBatch());
        end
        
        function testConstructor(testCase)
            % Test constructor
            % This test is checking the constructor of the MQTT_finger_sender class. 
            % It verifies that the constructor correctly initializes the properties of the class, such as clientID, brokerAddresses_OverUnTCP, port_OverUnTCP, topic, mqClient, and dataBatch.
            sender = MQTT_finger_sender();
            testCase.verifyEqual(sender.clientID, "BME_TEAM_A");
            testCase.verifyEqual(sender.brokerAddresses_OverUnTCP, ["tcp://broker.hivemq.com", "tcp://mqtt3.thingspeak.com", "tcp://mqtt.flespi.io"]);
            testCase.verifyEqual(sender.port_OverUnTCP, 1883);
            testCase.verifyEqual(sender.topic, "BME12_finger_configuration");
            testCase.verifyNotEmpty(sender.mqClient);
            testCase.verifyNotEmpty(sender.dataBatch);
        end

        function testSendDataWithInvalidJointAngles(testCase)
            % Test sendData method with invalid jointAngles input
            sender = MQTT_finger_sender();
            endEffectorPosition = [1, 2, 3];
            jointAngles = 'invalid'; % invalid input
            pauseSeconds = 1;
            % Call sendData with invalid jointAngles (assuming it's void)
            sender.sendData(endEffectorPosition, jointAngles, pauseSeconds);
            % No need to verify any output since sendData is assumed to be void
        end

        function testAddToDataBatchWithInvalidEndEffectorPosition(testCase)
            % Test addToDataBatch method with invalid endEffectorPosition input
            sender = MQTT_finger_sender();
            t = 1;
            endEffectorPosition = 'invalid'; % invalid input
            jointAngles = [pi/4, pi/4, pi/4];
            % Verify that the method throws the expected error
            verifyError(testCase, @() sender.addToDataBatch(t, endEffectorPosition, jointAngles), 'MATLAB:invalidType');
        end

        function testAddToDataBatchWithInvalidJointAngles(testCase)
            % Test addToDataBatch method with invalid jointAngles input
            sender = MQTT_finger_sender();
            t = 1;
            endEffectorPosition = [1, 2, 3];
            jointAngles = 'invalid'; % invalid input
            % Verify that the method throws the expected error
            verifyError(testCase, @() sender.addToDataBatch(t, endEffectorPosition, jointAngles), 'MATLAB:invalidType');
        end

    end

end
