classdef MQTT_finger_sender < handle

    properties
        clientID = "BME_TEAM_A";
        brokerAddresses_OverUnTCP = ["tcp://broker.hivemq.com", "tcp://mqtt3.thingspeak.com", "tcp://mqtt.flespi.io"];
        port_OverUnTCP = 1883;
        topic = "BME12_finger_configuration";
        mqClient
        dataBatch
    end
    
    methods
        function obj = MQTT_finger_sender()
            % Constructor: Initialize MQTT client
            obj.mqClient = mqttclient(obj.brokerAddresses_OverUnTCP(1), 'Port', obj.port_OverUnTCP, 'ClientID', obj.clientID);
            obj.dataBatchInit()

            if obj.mqClient.Connected ~= 1
                disp("Error connecting to MQTT broker. Try again.");
            end
        end

        function dataBatchInit(obj)
            obj.dataBatch.fingerConfigArray = struct('t', 0, 'EndEffectorPosition', 0, 'JointAngles', 0);
        end
        
        function sendData(obj, endEffectorPosition, jointAngles, pauseSeconds)
            % Send data to the MQTT broker

            % Prepare data for JSON encoding
            fingerConfigStruct = struct('EndEffectorPosition', endEffectorPosition, 'JointAngles', jointAngles);

            % Convert data to JSON for easy parsing
            fingerConfigJSON = jsonencode(fingerConfigStruct);

            %disp(fingerConfigJSON); % Display JSON string
            
            % Write data iteratively one entry at a time
            write(obj.mqClient, obj.topic, fingerConfigJSON, 'Retain', false, 'QualityOfService', 2);
            pause(pauseSeconds)
        end

        function addToDataBatch(obj, t, endEffectorPosition, jointAngles)

            fingerConfigStruct = struct('t', t, 'EndEffectorPosition', endEffectorPosition, 'JointAngles', jointAngles);

            obj.dataBatch.fingerConfigArray(end+1) = fingerConfigStruct;

        end
        
        function sendDataBatch(obj)

            obj.dataBatch.fingerConfigArray(1) = [];
            fingerDataBatchJSON = jsonencode(obj.dataBatch);
            write(obj.mqClient, obj.topic, fingerDataBatchJSON, 'Retain', false, 'QualityOfService', 2);
            obj.dataBatchInit();

        end

    end

end
