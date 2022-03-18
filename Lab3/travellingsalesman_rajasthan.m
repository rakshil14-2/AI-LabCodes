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

%--- places in Rajsthan -------------------
places = ["Udaipur","Jaisalmer","Ganganagar","Ajmer","Jaipur","Chittaurgarh","Alwar","Jodhpur","Dungarpur","Ranthambore","Pushkar","Kota","Bundi","Pali","Kumbalgarh","Bikaner","Abu","Ranakpur","Nathdwara","Fatehpur"];
x = [24.6,26.9,29.9,26.4,26.9,24.8,27.5,26.2,23.8,26,26.4,25.2,25.4,25.7,25.1,28,24.5,25.1,24.9,25.9;73.1,70.9,73.8,74.6,75.7,74.6,76.6,73,73.7,76.5,74.5,75.8,75.6,73.3,73.5,73.3,72.7,73.4,73.8,80.7];
% x is the latitude and longitude of a given place
N = 20;
D = zeros(N,N);

R = 6371; % Radius of the earth in km
% Calculating distance using  Haversine formula
%---- Distance matrix (D)  -------------------
for i=1:N-1
    for j=i+1:N
        dlat = deg2rad(x(1,i) - x(1,j));
        dlon = deg2rad(x(2,i) - x(2,j));
        a = sin(dlat/2)^2 + cos(deg2rad(x(1,i)))*cos(deg2rad(x(1,j)))*sin(dlon/2)^2; 
        D(i,j) = R * 2 * atan2(sqrt(a),sqrt(1 - a)); % distance in kms
        D(j,i)=D(i,j);
    end
end
%-----------------------------------------

s = randperm(N); % Initial solution
sinit = s;
ds = path_cost_tour(s,D); 
d = ds; p = [];
Tm = 1000; 
iter_max = 10000;
for i=1:iter_max
    id = randperm(N,2);
    id = sort(id);
    snext = s;
    snext(id(1):id(2))=s(id(2):-1:id(1));
 
    dsnext = path_cost_tour(snext,D);
    E = ds-dsnext; % to check for minimum direction
    T = Tm/i;
    pE = 1/(1+exp(-E/T)); 
    if E>0 
        s = snext;
    else
        if rand < pE 
            s = snext;
        end
    end
    ds = path_cost_tour(s,D);
    d = [d, ds];
    p = [p, pE];
end

%------------------
figure(1);
subplot(1,2,1);

axis([0 1 0 1]);plot(x(1,[sinit sinit(1)]),x(2,[sinit sinit(1)]),'-*')
subplot(1,2,2);
axis([0 1 0 1]);plot(x(1,[s s(1)]),x(2,[s s(1)]),'-*');
hold on;
plot(x(1,s(1)),x(2,s(1)),'or');
legend('path','initial place');

% Path for the tour...
for i = 1:length(s)   
    pr(i) = sprintf("%s",char(places(s(i))));
   
end
pr

function [dis] = path_cost_tour(s,D)

% Distance calculation or Path Cost for a tour s
    [N,M] = size(D);
    dis = 0;
    for i=1:N-1
    dis = dis + D(s(i),s(i+1));
    end
    dis = dis + D(s(N),s(1));
end

