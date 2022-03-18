clear all;
close all;

t = [0,0,0,0,2,2,2,5,5,5,5,5,5,5,9,10,10,11,11,11,11,11,12,12,12,15,15,15,15,17,18,18,18,18,18,25,25,25,25,25,25,25,25,25,25,25,28,28,28,28,28,28,28,28,28,32,32,33,33,34,34,34,34,34,34,34,35,38,38,38,38,40,41,48,48,48,48,48,51,51,51,51,51,51,51,51,51,54,55,55,55,55,56,56,56,57,57,57,57,57,57,57,58,61,61,61,61,61,61,61,63,64,71,71,71,72,73,74,74,74,74,74,74,74,74,74,74,78,79,80,80,80,80,80,81,84,84,84,84,84,84,84,84,84,86,87,87,87,87,87,87,87,87,87,87,87,87,87,87,87,87,87,87,87,94,94,94,94,94,94,94,94,97,97,97,97,97,97,97,97,102,103,103,103,103,103,103,103,104,107,107,107,107,107,109,109,109,109,110,117,117,117,120,120,120,120,120,120,120,120,120,120,120,120,123,124,124,124,125,125,126,126,126,126,127,127,130,130,130,130,130,130,130,130,130,130,132];
o = [15,33,51,60,21,28,44,13,18,33,36,40,64,8,10,10,42,10,17,31,34,42,10,5,61,13,18,64,8,21,11,13,14,15,28,10,12,14,16,18,20,23,32,34,45,61,12,15,19,23,27,37,40,42,7,10,13,10,13,10,13,28,36,39,5,51,24,27,37,40,42,45,61,10,32,34,45,61,11,14,18,22,26,37,40,42,7,0,0,19,22,26,10,20,24,10,12,28,36,39,5,51,15,11,18,21,25,37,40,42,45,61,54,56,6,0,0,13,19,25,31,37,43,49,59,62,64,10,10,10,47,50,58,61,10,13,19,25,31,37,43,59,62,64,6,11,13,15,17,19,21,23,25,27,29,31,33,35,37,39,41,42,44,45,10,20,22,34,35,36,52,6,11,15,25,28,30,57,60,64,10,10,16,24,27,42,55,58,12,11,15,25,28,30,34,35,36,6,52,50,52,63,11,15,19,25,29,34,40,44,55,58,60,7,26,37,40,44,38,42,46,5,54,57,12,16,15,19,25,29,34,39,43,55,58,60,63];
x = [t;o];
N = length(x); % Total number of coordinates
D = zeros(N,N); % Creating distance matrix of N*N

% generating matrix
for i=1:N-1
    for j=i+1:N
        D(i,j)=norm(x(:,i)-x(:,j));
        D(j,i)=D(i,j);
    end
end


s = randperm(N); % Initial solution
sinit = s;
distance = tour_calculation(s,D); % calculating distance
d_list = distance; p_list = [];
factor = 10; 
epochs = 100000;
for i=1:epochs
     id = randperm(N,2);
     id = sort(id);
     snext = s;

     snext(id(1):id(2))=s(id(2):-1:id(1));% Swapping

     distance_next = tour_calculation(snext,D);
     E = distance-distance_next; % to check for minimum direction
     T = factor/(i);
     prob = 1/(1+exp(-E/T));
     %pE = exp(-E/(T));
     if E>0 
         s = snext;
     else
         ra = rand;
          if ra < prob 
                s = snext;
          end
     end
     distance = tour_calculation(s,D);
     d_list = [d_list, distance];
     p_list = [p_list, prob];
 

 
end 


% plotting graphs for Inital path and Path found by simulated annealing
x0=10;
y0=10;
width=1200;
height=400;
set(gcf,'position',[x0,y0,width,height])

figure(1);
subplot(1,2,1);
axis([0 1 0 1]);plot(x(1,[sinit sinit(1)]),x(2,[sinit sinit(1)]),'-o')
title('Initial Path')
xlabel('x-axis')
ylabel('y-axis')
legend('Connecting paths');
subplot(1,2,2);
axis([0 1 0 1]);



plot(x(1,[s s(1)]),x(2,[s s(1)]),'-o',x(1,s(1)),x(2,s(1)),'r-*');
title('Path after Simulated Annealing algo applied');
xlabel('x-axis');
ylabel('y-axis');
legend('Connecting paths','Start Node');

% Distance calculation / path cost for a tour s
% function for tour calculation
function [dis] = tour_calculation(s,D)
    [N,M] = size(D);
    dis = 0;
    for i=1:N-1
     dis = dis + D(s(i),s(i+1));
    end
    dis = dis + D(s(N),s(1));
end