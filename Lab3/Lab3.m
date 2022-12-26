clc
clear all

x = 0.1:1/22:1;

d = (1 + 0.6*sin(2*pi*x/0.7)) + (0.3*sin(2*pi*x))/2;

w1 = randn(1);
w2 = randn(1);
w0 = randn(1);
eta = 0.1;

c1 = 0.19;
c2 = 0.87;
r1 = 0.17;
r2 = 0.15;

for k = 1:5000

for i = 1:20

y1 = exp(-1*(((x(i)-c1)^2) /( 2 * r1 ^2)));
y2 = exp(-1*(((x(i)-c2)^2) /( 2 * r2 ^2)));
y = w1 * y1 + w2 * y2 + w0;
e = d(i) - y;
w1 = w1 + eta * e * y1;
w2 = w2 + eta * e * y2;
w0 = w0 + eta * e;

end

end

for i = 1 : 20
    y1 = exp(-1*(((x(i)-c1)^2) / (2 * r1 ^2)));
    y2 = exp(-1*(((x(i)-c2)^2) / (2 * r2 ^2)));
    Y(i) = w1 * y1 + w2 * y2 + w0;
end

plot(x,d, x,Y)
grid on