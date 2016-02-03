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

for n=2:length(time)
    
    dt = time(n) - time(n-1) * 1.0e-06;
    radGyro(:,n) = degGyro(:,n) .* (pi / 180);
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
    
    switch flag1(n)
        case 0
            accMag = sqrt(acc(X_,n)*acc(X_,n) + acc(Y_,n)*acc(Y_,n) + acc(Z_,n)*acc(Z_,n) )
            if (abs(accMag - 9.8) < 0.25)
                ax = -1 * acc(1,n);
                ay = -1 * acc(2,n);
                az = -1 * acc(3,n);
                recipNorm = 1/sqrt(ax * ax + ay * ay + az * az);
                ax = ax * recipNorm;
                ay = ay * recipNorm;
                az = az * recipNorm; 
            end
            
        case 1
    end
    
    
    
    
    
end