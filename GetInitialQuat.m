function [q]=GetInitialQuat(acc,mag,dec)
X_ = 1;
Y_ = 2;
Z_ = 3;
radPitch = atan2( acc(X_,1), sqrt(acc(Y_,1)^2 + acc(Z_,1)^2 ) );
radRoll = atan2(-1 * acc(Y_,1) ,-1 *  acc(Z_,1));


partialRot =[              cos(radPitch),             0,             -sin(radPitch);
 sin(radRoll)*sin(radPitch),  cos(radRoll), cos(radPitch)*sin(radRoll);
 cos(radRoll)*sin(radPitch), -sin(radRoll), cos(radRoll)*cos(radPitch);];
 
             
b = partialRot * mag(:,1);
radYaw = atan2(  - b(2) , b(1) ) - dec;


q0 = cos(radYaw/2)*cos(radPitch/2)*cos(radRoll/2) + sin(radYaw/2)*sin(radPitch/2)*sin(radRoll/2); ...
q1 = cos(radYaw/2)*cos(radPitch/2)*sin(radRoll/2) - sin(radYaw/2)*sin(radPitch/2)*cos(radRoll/2); ...
q2 = cos(radYaw/2)*sin(radPitch/2)*cos(radRoll/2) + sin(radYaw/2)*cos(radPitch/2)*sin(radRoll/2); ...
q3 = sin(radYaw/2)*cos(radPitch/2)*cos(radRoll/2) - cos(radYaw/2)*sin(radPitch/2)*sin(radRoll/2);
magnitude = sqrt(q0 ^ 2 + q1 ^ 2 + q2 ^ 2 + q3 ^ 2); 
q0 = q0 / magnitude;
q1 = q1 / magnitude;
q2 = q2 / magnitude;
q3 = q3 / magnitude;
q = [q0,q1,q2,q3]';


% roll = 180/pi * (atan2(2 * (q0 * q1 + q2 * q3),1 - 2 * (q1 * q1 + q2 * q2)))
% pitch = 180/pi *(asin(2 * (q0 * q2 - q3 * q1)))
% yaw = 180 / pi *(atan2(2 * (q0 * q3 + q1 * q2) , 1 - 2* (q2 * q2 + q3 * q3)))
% if (yaw < 0)
%     yaw = yaw + 360;
% end
end