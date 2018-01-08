%f = sin(x)
x_prev = 1; 

for i=1:5
   x = x_prev + (1/sin(x_prev)) * cos(x_prev)
   x_prev = x; 
end