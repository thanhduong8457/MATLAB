d=[3595 4285 4585 6403 6600 11990 10810];
r=[1595 1695 1760 2032 2000 2490 2500];
c=[1480 1435 1760 2070 2600 3415 3500];
for i=1:2
plot3(d(i),r(i),c(i),'o','MarkerSize',13,'MarkerEdgeColor','r','MarkerFaceColor','r');
hold on;
end

for i=3:3
plot3(d(i),r(i),c(i),'o','MarkerSize',13,'MarkerEdgeColor','g','MarkerFaceColor','g');
hold on;
end

for i=4:5
plot3(d(i),r(i),c(i),'o','MarkerSize',13,'MarkerEdgeColor','b','MarkerFaceColor','b');
hold on;
end

for i=6:7
plot3(d(i),r(i),c(i),'o','MarkerSize',13,'MarkerEdgeColor','c','MarkerFaceColor','c');
hold on;
end
rotate3d on
grid on
