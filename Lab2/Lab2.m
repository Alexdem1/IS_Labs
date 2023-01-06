clc
clear all
x = 0.1:1/22:1;

d = (1 + 0.6*sin(2*pi*x/0.7)) + (0.3*sin(2*pi*x))/2;

w11 = randn(1);
w12 = randn(1);
w13 = randn(1);
w14 = randn(1);
w15 = randn(1);

b1 = randn(1);
b2 = randn(1);
b3 = randn(1);
b4 = randn(1);
b5 = randn(1);
b6 = randn(1);

w21 = randn(1);
w22 = randn(1);
w23 = randn(1);
w24 = randn(1);
w25 = randn(1);

for k = 1:50000

for i = 1:20

v1 = x(i) * w11 + b1;
v2 = x(i) * w12 + b2;
v3 = x(i) * w13 + b3;
v4 = x(i) * w14 + b4;
v5 = x(i) * w15 + b5;

y1 = 1./(1 + exp(-1 * v1));
y2 = 1./(1 + exp(-1 * v2));
y3 = 1./(1 + exp(-1 * v3));
y4 = 1./(1 + exp(-1 * v4));
y5 = 1./(1 + exp(-1 * v5));

y = y1 * w21 + y2 * w22 + y3 * w23 + y4 * w24 + y5 * w25 + b6;
  
e = d(i) - y;
eta = 0.1;

w21 = w21 + (eta * 1 * e * y1);
w22 = w22 + (eta * 1 * e * y2);
w23 = w23 + (eta * 1 * e * y3);
w24 = w24 + (eta * 1 * e * y4);
w25 = w25 + (eta * 1 * e * y5);
b6 = b6 + eta * 1 * e * 1;

h1 = y1 * (1 - y1) * w21 * e;
h2 = y2 * (1 - y2) * w22 * e;
h3 = y3 * (1 - y3) * w23 * e;
h4 = y4 * (1 - y4) * w24 * e;
h5 = y5 * (1 - y5) * w25 * e;

w11 = w11 + eta * h1 * x(i);
w12 = w12 + eta * h2 * x(i);
w13 = w13 + eta * h3 * x(i);
w14 = w14 + eta * h4 * x(i);
w15 = w15 + eta * h5 * x(i);

b1 = b1 + eta * h1 * 1;
b2 = b2 + eta * h2 * 1;
b3 = b3 + eta * h3 * 1;
b4 = b4 + eta * h4 * 1;
b5 = b5 + eta * h5 * 1;

end

end

for j = 1:20

v1 = x(j) * w11 + b1;
v2 = x(j) * w12 + b2;
v3 = x(j) * w13 + b3;
v4 = x(j) * w14 + b4;
v5 = x(j) * w15 + b5;

y1 = 1/(1 + exp(-1 * v1));
y2 = 1/(1 + exp(-1 * v2));
y3 = 1/(1 + exp(-1 * v3));
y4 = 1/(1 + exp(-1 * v4));
y5 = 1/(1 + exp(-1 * v5));

Y(j) = y1 * w21 + y2 * w22 + y3 * w23 + y4 * w24 + y5 * w25 + b6;

end

plot(x,d, x, Y );
grid on