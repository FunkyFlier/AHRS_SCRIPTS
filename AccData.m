accX(1) = accX(2);
accY(1) = accY(2);
accZ(1) = accZ(2);
%filtAccX(1) = accX(1)
%filtAccY(1) = accY(1)
%filtAccZ(1) = accZ(1)
for n=2:length(time)
    if accY(n) == 0
        accX(n) = accX(n-1);
        accY(n) = accY(n-1);
        accZ(n) = accZ(n-1);
    end
end

plot(time,accX,time,accY,time,accZ);
%plot(time,accZ);