%Thu thap so lieu 
hold off;
tt = ScopeData.time;
x1  = ScopeData.signals(1,1).values;
x2  = ScopeData.signals(1,2).values;
x3  = ScopeData.signals(1,3).values;
x4  = ScopeData.signals(1,4).values;

%Ve dap ung ngo ra
subplot(4,1,1);
hold off;
plot(tt,x1,'r','LineWidth',2);
grid on
hold on
xlabel('Theta1');

subplot(4,1,2);
hold off;
plot(tt,x2,'g','LineWidth',2);
grid on
hold on
xlabel('Theta1 Dot');

subplot(4,1,3);
hold off;
plot(tt,x3,'b','LineWidth',2);
grid on
hold on
xlabel('Theta2');

subplot(4,1,4);
hold off;
plot(tt,x4,'c','LineWidth',2);
grid on
hold on
xlabel('Theta2 Dot');
