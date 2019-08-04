%%%%%%%%%%%%regression exercise%%%%%%%%%%%%

clear all
clc

prompt = 'Enter integer: ';
input = input(prompt);

% if isinteger(input)
%     if isinteger(input)
%         display(['Not a whole number. Try again.']);
%     end
%     display(['Not a whole number. Try again.']);
% end

display(['Wait...']);
pause(1);
display(['Number of points: ' num2str(input)])
n = input;

A = rand(2,n);
B = rand(2,n);

figure
for i = 1:n
    scatter(A(1,i),A(2,i),'r','*');
    hold on
    scatter(B(1,i),B(2,i),'b','*');
    hold on
end

hold on

Aavgx = mean(A(1,:));
Aavgy = mean(A(2,:));

Bavgx = mean(B(1,:));
Bavgy = mean(B(2,:));

scatter(Aavgx,Aavgy,'m','o','filled');
hold on
scatter(Bavgx,Bavgy,'c','o','filled');
hold off


% Astd = std(A
