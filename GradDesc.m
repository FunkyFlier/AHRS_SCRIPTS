X_ = 1;
Y_ = 2;
Z_ = 3;

degGyro(X_,:) = gyroX;
degGyro(Y_,:) = gyroY;
degGyro(Z_,:) = gyroZ;

acc(X_,:) = accX;
acc(Y_,:) = accY;
acc(Z_,:) = accZ;

mag(X_,:) = magX;
mag(Y_,:) = magY;
mag(Z_,:) = magZ;

[q(:,1)] = GetInitialQuat(acc(:,1),mag(:,1),0);
q0 = q(1,1);
q1 = q(2,1);
q2 = q(3,1);
q3 = q(4,1);

R_e_b = [ 1-2*(q2^2+q3^2),    2*(q1*q2+q3*q0),     2*(q1*q3-q2*q0);
          2*(q1*q2-q3*q0),    1-2*(q1^2+q3^2),     2*(q2*q3+q1*q0);
          2*(q1*q3+q2*q0),    2*(q2*q3-q1*q0),     1-2*(q1^2+q2^2);];

R_b_e = R_e_b';
beta1 = 0.1;
beta2 = 0.1'
previousTime = time(1)
for n=2:length(time)
    radGyro(:,n) = degGyro(:,n) .* (pi / 180);
    
    
    switch flag1(n)
        case 0
            dt = time(n) - previousTime * 1.0e-06;
            previousTime = time(n);
            gx = radGyro(1,n);
            gy = radGyro(2,n);
            gz = radGyro(3,n);
            q0 = q(1,n-1);
            q1 = q(2,n-1);
            q2 = q(3,n-1);
            q3 = q(4,n-1);

            qDot1 = 0.5 * (-q1 * gx - q2 * gy - q3 * gz);
            qDot2 = 0.5 * (q0 * gx + q2 * gz - q3 * gy);
            qDot3 = 0.5 * (q0 * gy - q1 * gz + q3 * gx);
            qDot4 = 0.5 * (q0 * gz + q1 * gy - q2 * gx);
            accMag = sqrt(acc(X_,n)*acc(X_,n) + acc(Y_,n)*acc(Y_,n) + acc(Z_,n)*acc(Z_,n) )
            if (abs(accMag - 9.8) < 0.25)
                ax = -1 * acc(1,n);
                ay = -1 * acc(2,n);
                az = -1 * acc(3,n);
                recipNorm = 1/sqrt(ax * ax + ay * ay + az * az);
                ax = ax * recipNorm;
                ay = ay * recipNorm;
                az = az * recipNorm; 
                s0 = 2*q2*(ax + 2*q0*q2 - 2*q1*q3) + 2*q1*(2*q0*q1 - ay + 2*q2*q3);
                s1 = 2*q0*(2*q0*q1 - ay + 2*q2*q3) - 2*q3*(ax + 2*q0*q2 - 2*q1*q3) + 4*q1*(2*q1^2 + 2*q2^2 + az - 1);
                s2 = 2*q0*(ax + 2*q0*q2 - 2*q1*q3) + 2*q3*(2*q0*q1 - ay + 2*q2*q3) + 4*q2*(2*q1^2 + 2*q2^2 + az - 1);
                s3 = 2*q2*(2*q0*q1 - ay + 2*q2*q3) - 2*q1*(ax + 2*q0*q2 - 2*q1*q3);
                recipNorm = 1/sqrt(s0 * s0 + s1 * s1 + s2 * s2 + s3 * s3); % normalise step magnitude
                s0 = s0 * recipNorm;
                s1 = s1 * recipNorm;
                s2 = s2 * recipNorm;
                s3 = s3 * recipNorm;
                qDot1 = qDot1 - beta * s0;
                qDot2 = qDot2 - beta * s1;
                qDot3 = qDot3 - beta * s2;
                qDot4 = qDot4 - beta * s3;
                
            end
            q0 = q0 + qDot1 * dt;
            q1 = q1 + qDot2 * dt;
            q2 = q2 + qDot3 * dt;
            q3 = q3 + qDot4 * dt;
            recipNorm = 1/sqrt(q0 * q0 + q1 * q1 + q2 * q2 + q3 * q3);
            q0 = q0 * recipNorm;
            q1 = q1 * recipNorm;
            q2 = q2 * recipNorm;
            q3 = q3 * recipNorm;
            
        case 1
            
    end
    
    
    
    
    
end