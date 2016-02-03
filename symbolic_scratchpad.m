q0 = sym('q0','real');
q1 = sym('q1','real');
q2 = sym('q2','real');
q3 = sym('q3','real');

dx = sym('dx','real');
dy = sym('dy','real');
dz = sym('dz','real');

sx = sym('sx','real');
sy = sym('sy','real');
sz = sym('sz','real');

ax = sym('ax','real');
ay = sym('ay','real');
az = sym('az','real');

hx = sym('hx','real');
hy = sym('hy','real');
hz = sym('hz','real');

bx = sym('bx','real');
bz = sym('bz','real');

mx = sym('mx','real');
my = sym('my','real');
mz = sym('mz','real');



% R_e_b = [ 1, 0              ,    0              ,                   0;
%           0, 1-2*(q2^2+q3^2),    2*(q1*q2+q3*q0),     2*(q1*q3-q2*q0);
%           0, 2*(q1*q2-q3*q0),    1-2*(q1^2+q3^2),     2*(q2*q3+q1*q0);
%           0, 2*(q1*q3+q2*q0),    2*(q2*q3-q1*q0),     1-2*(q1^2+q2^2);]
      

R_e_b = [ 1-2*(q2^2+q3^2),    2*(q1*q2+q3*q0),     2*(q1*q3-q2*q0);
          2*(q1*q2-q3*q0),    1-2*(q1^2+q3^2),     2*(q2*q3+q1*q0);
          2*(q1*q3+q2*q0),    2*(q2*q3-q1*q0),     1-2*(q1^2+q2^2);]
      
d = [ dx dy dz]'
q = [q0 q1 q2 q3]
s = [sx sy sz]'
f_ = R_e_b * d - s
J_ = jacobian(f_,q)
F_ = J_' * f_


dx = 0;
dy = 0;
dz = 1;
sx = ax;
sy = ay;
sz = az;
d = [ dx dy dz]'
q = [q0 q1 q2 q3]
s = [sx sy sz]'

facc = R_e_b * d - s
Jacc = jacobian(facc,q)
Facc = Jacc' * facc

dx = bx;
dy = 0;
dz = bz;
sx = mx;
sy = my;
sz = mz;
d = [ dx dy dz]'
q = [q0 q1 q2 q3]
s = [sx sy sz]'

fmag = R_e_b * d - s
Jmag = jacobian(fmag,q)
Fmag = Jmag' * fmag

F = Facc + Fmag
