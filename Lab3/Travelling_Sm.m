% ---------------------------------------------------------
%
% Simulated Annealing for 
% Travelling Salesman Problem
%
% N - number of places
% D - distance matrix
% s - tour
% p - transition probability with iteration
% d - tour cost with iteration
% ---------------------------------------------------------

clear all;
close all;

t = [0,0,0,0,2,5,5,5,5,5,5,5,8,9,10,11,12,12,15,15,15,15,15,15,15,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,25,25,25,25,25,25,25,25,25,28,28,28,28,28,28,28,28,32,32,33,33,33,33,34,34,34,34,34,34,34,35,35,38,38,38,38,40,41,41,41,41,41,48,48,48,51,51,56,57,57,57,61,61,63,64,71,71,71,71,71,74,74,74,74,74,74,74,74,77,78,78,78,78,79,79,79,80,80,80,81,84,84,84,84,84,84,107];
o = [13,26,27,39,0,13,19,25,31,37,43,8,0,10,10,10,10,5,13,19,25,31,37,43,8,11,13,15,17,19,21,23,25,27,29,31,33,35,37,39,41,42,44,45,11,15,22,23,24,26,28,29,9,16,20,28,30,34,40,43,47,26,31,15,26,29,31,15,26,29,31,38,41,5,17,31,16,20,30,34,22,23,32,34,35,36,22,27,6,45,47,25,12,25,44,45,47,6,22,11,13,16,45,47,12,16,20,24,29,35,39,6,21,10,32,35,39,10,33,37,10,41,5,17,20,24,29,34,38,6,27];
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