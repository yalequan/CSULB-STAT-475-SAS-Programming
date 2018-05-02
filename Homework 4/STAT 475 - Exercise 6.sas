/*

Exercise 6. Take five points (-3, -2), (0, 4), (2, 8), (4, 12), and (7, 18). 
Note that these points lie on a perfectly straight line with the intercept a=4 and slope b=2.
The quantities a and b can be found as a solution of linear regression equation.
Use proc iml to find a and b

*/ 

proc iml;
title 'Basic Linear Regression';
x = {1 -3, 1 0, 1 2, 1 4, 1 7 }; *Design Matrix;
y = {-2, 4, 8, 12, 18};
coef = {'a', 'b'};
beta = inv(x`*x)*x`*y;
print coef beta;
