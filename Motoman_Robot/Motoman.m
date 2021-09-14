function varargout = Motoman(varargin)
% MOTOMAN MATLAB code for Motoman.fig
%      MOTOMAN, by itself, creates a new MOTOMAN or raises the existing
%      singleton*.
%      H = MOTOMAN returns the handle to a new MOTOMAN or the handle to
%      the existing singleton*.
%      MOTOMAN('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MOTOMAN.M with the given input arguments.
%      MOTOMAN('Property','Value',...) creates a new MOTOMAN or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Scara_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Scara_OpeningFcn via varargin.
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Motoman
% Last Modified by GUIDE v2.5 14-Sep-2021 00:24:55

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Motoman_OpeningFcn, ...
                   'gui_OutputFcn',  @Motoman_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT

% --- Executes just before Motoman is made visible.
function Motoman_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Motoman (see VARARGIN)

%set the initial position of robot
rad = pi/180;

theta1 = str2double(get(handles.theta1,'string'))*rad;
theta2 = str2double(get(handles.theta2,'string'))*rad;
theta3 = str2double(get(handles.theta3,'string'))*rad;

handles.a       = [0        400     130]';
handles.alpha   = [pi/2     0       0  ]';
handles.d       = [200      0       0  ]';
%handles.theta   = [theta1   theta2  theta3]';
handles.theta   = [0  0  90]';

x0 = 0; y0 = 0; z0 = 0;
x1 = 0; y1 = 0; z1 = 0;
x2 = 0; y2 = 150; z2 = 1020;
x3 = 0; y3 = 150; z3 = 1150;

%joint position
handles.J1 = [x1 y1 z1 1]';
handles.J2 = [x2 y2 z2 1]';
handles.J3 = [x3 y3 z3 1]';


%position of end effector
handles.grip1 = [650 50 280 1]';
handles.grip2 = [650 50 330 1]';
handles.grip3 = [650 -50 280 1]';
handles.grip4 = [650 -50 330 1]';

%DH matrix frame
DH = zeros(4,4,4);
for i = 1:3
        DH(:,:,i)=[cos(handles.theta(i))   -cos(handles.alpha(i))*sin(handles.theta(i))    sin(handles.alpha(i))*sin(handles.theta(i))     handles.a(i)*cos(handles.theta(i));
                   sin(handles.theta(i))   cos(handles.alpha(i))*cos(handles.theta(i))     -sin(handles.alpha(i))*cos(handles.theta(i))    handles.a(i)*sin(handles.theta(i));
                   0                       sin(handles.alpha(i))                           cos(handles.alpha(i))                           handles.d(i);
                   0                       0                                               0                                               1];
end

%new joint position
handles.J1_new = handles.J1;
handles.J2_new = DH(:,:,1)*[0 0 0 1]';
handles.J3_new = DH(:,:,1)*DH(:,:,2)*[0 0 0 1]';
handles.J4_new = DH(:,:,1)*DH(:,:,2)*DH(:,:,3)*[0 0 0 1]';

%new grip position
T_matrix = DH(:,:,1)*DH(:,:,2)*DH(:,:,3);
handles.grip1_new = T_matrix*[0 -50 50  1]';
handles.grip2_new = T_matrix*[0 -50 0   1]';
handles.grip4_new = T_matrix*[0 +50 0   1]';
handles.grip3_new = T_matrix*[0 +50 50  1]';

%plot robot
axes(handles.axes1);

draw3d(handles.J1_new, handles.J2_new, handles.J3_new, handles.J4_new);

plot_axis_each_joint(DH);

%with T matrix above, we have
%rotation_matrix = T_matrix(1:3,1:3);
%handles.p1 = atan2(-rotation_matrix(3,1),sqrt(rotation_matrix(3,2)^2+rotation_matrix(3,3)^2));
%handles.p2 = atan2(-rotation_matrix(3,1),-sqrt(rotation_matrix(3,2)^2+rotation_matrix(3,3)^2));
%handles.r1 = atan2(rotation_matrix(3,2)/cos(handles.p1),rotation_matrix(3,3)/cos(handles.p1));
%handles.r2 = atan2(rotation_matrix(3,2)/cos(handles.p2),rotation_matrix(3,3)/cos(handles.p2));
%handles.y1 = atan2(rotation_matrix(2,1)/cos(handles.p1),rotation_matrix(1,1)/cos(handles.p1));
%handles.y2 = atan2(rotation_matrix(2,1)/cos(handles.p2),rotation_matrix(1,1)/cos(handles.p2));

%set x y z values to guide
%set(handles.x,'String',sprintf('%.2f',handles.J6_new(1)));
%set(handles.y,'String',sprintf('%.2f',handles.J6_new(2)));
%set(handles.z,'String',sprintf('%.2f',handles.J6_new(3)));

%set roll pitch yaw values to guide
%set(handles.roll,'String',sprintf('%.2f',(handles.r1)/rad));
%set(handles.pitch,'String',sprintf('%.2f',(handles.p1)/rad));
%set(handles.yaw,'String',sprintf('%.2f',(handles.y1)/rad));

% Choose default command line output for Motoman
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

function varargout = Motoman_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;

function forward_Callback(hObject, eventdata, handles)
hold off;
rad = pi/180;

%get theta 124 and theta3 from guide and update DH table
theta1 = str2double(get(handles.theta1,'String'))*rad;
theta2 = str2double(get(handles.theta2,'String'))*rad;
d3 = str2double(get(handles.theta3,'String'));
theta4 = str2double(get(handles.theta4,'String'))*rad;

handles.theta = [theta1 theta2 0 theta4]';
handles.d = [330 0 d3 0]';

if (handles.d(3) > 0)||(handles.d(3) < -330)||(handles.theta(1)/rad < -155)||(handles.theta(1)/rad > 155)||(handles.theta(2)/rad < -145)||(handles.theta(2)/rad > 145)||(handles.theta(4)/rad > 180)||(handles.theta(4)/rad < -180)
     set(handles.warning,'String',sprintf('OUT OF RANGE..!!! The condition should be like this: (d3<0; -155<Theta1<155; -145<Theta2<145; -180<Theta4<180)'));
     set(handles.x,'String',0);
     set(handles.y,'String',0);
     set(handles.z,'String',0);
     set(handles.roll,'String',0);
     set(handles.pitch,'String',0);
     set(handles.yaw,'String',0);
else
    set(handles.warning,'String',sprintf('                    ...Approved...                      '));   
   
    
%DH matrix frame
DH=zeros(4,4,4);
for i=1:4
        DH(:,:,i)=[cos(handles.theta(i)) -cos(handles.alpha(i))*sin(handles.theta(i)) sin(handles.alpha(i))*sin(handles.theta(i)) handles.a(i)*cos(handles.theta(i));
               sin(handles.theta(i)) cos(handles.alpha(i))*cos(handles.theta(i)) -sin(handles.alpha(i))*cos(handles.theta(i)) handles.a(i)*sin(handles.theta(i));
               0 sin(handles.alpha(i)) cos(handles.alpha(i)) handles.d(i);
               0 0 0 1];
end

%new joint position
handles.J1_new = handles.J1;
handles.J2_new = DH(:,:,1)*[0 0 0 1]';
handles.J3_new = DH(:,:,1)*DH(:,:,2)*[0 0 0 1]';
handles.J4_new = DH(:,:,1)*DH(:,:,2)*DH(:,:,3)*[0 0 0 1]';

%new grip position
T_matrix =(DH(:,:,1)*DH(:,:,2)*DH(:,:,3)*DH(:,:,4));
handles.grip1_new = T_matrix*[0 -50 50 1]';
handles.grip2_new = T_matrix*[0 -50 0 1]';
handles.grip4_new = T_matrix*[0 50 0 1]';
handles.grip3_new = T_matrix*[0 50 50 1]';

%with T matrix above, we have
rotation_matrix=T_matrix(1:3,1:3);
handles.p1 = atan2(-rotation_matrix(3,1),sqrt(rotation_matrix(3,2)^2+rotation_matrix(3,3)^2));
handles.p2 = atan2(-rotation_matrix(3,1),-sqrt(rotation_matrix(3,2)^2+rotation_matrix(3,3)^2));
handles.r1 = atan2(rotation_matrix(3,2)/cos(handles.p1),rotation_matrix(3,3)/cos(handles.p1));
handles.r2 = atan2(rotation_matrix(3,2)/cos(handles.p2),rotation_matrix(3,3)/cos(handles.p2));
handles.y1 = atan2(rotation_matrix(2,1)/cos(handles.p1),rotation_matrix(1,1)/cos(handles.p1));
handles.y2 = atan2(rotation_matrix(2,1)/cos(handles.p2),rotation_matrix(1,1)/cos(handles.p2));

%set x y z values to guide
set(handles.x,'String',sprintf('%.2f',handles.J4_new(1)));
set(handles.y,'String',sprintf('%.2f',handles.J4_new(2)));
set(handles.z,'String',sprintf('%.2f',handles.J4_new(3)));

%with T matrix above, we have
rotation_matrix = T_matrix(1:3,1:3);
handles.p1 = atan2(-rotation_matrix(3,1),sqrt(rotation_matrix(3,2)^2+rotation_matrix(3,3)^2));
handles.p2 = atan2(-rotation_matrix(3,1),-sqrt(rotation_matrix(3,2)^2+rotation_matrix(3,3)^2));
handles.r1 = atan2(rotation_matrix(3,2)/cos(handles.p1),rotation_matrix(3,3)/cos(handles.p1));
handles.r2 = atan2(rotation_matrix(3,2)/cos(handles.p2),rotation_matrix(3,3)/cos(handles.p2));
handles.y1 = atan2(rotation_matrix(2,1)/cos(handles.p1),rotation_matrix(1,1)/cos(handles.p1));
handles.y2 = atan2(rotation_matrix(2,1)/cos(handles.p2),rotation_matrix(1,1)/cos(handles.p2));

%set roll pitch yaw values to guide
set(handles.roll,'String',sprintf('%.2f',(handles.r1)/rad));
set(handles.pitch,'String',sprintf('%.2f',(handles.p1)/rad));
set(handles.yaw,'String',sprintf('%.2f',(handles.y1)/rad));
    
    
handles.theta1_2 = str2double(get(handles.theta1_22,'string'))*rad;
handles.theta2_2 = str2double(get(handles.theta2_22,'string'))*rad;
handles.d3_2 = str2double(get(handles.theta3_22,'string'));
handles.theta4_2 = str2double(get(handles.theta4_22,'string'))*rad;

if (handles.d3_2 > 0)||(handles.d3_2 < -330)||(handles.theta1_2/rad < -155)||(handles.theta1_2/rad > 155)||(handles.theta2_2/rad < -145)||(handles.theta2_2/rad > 145)||(handles.theta4_2/rad > 180)||(handles.theta4_2/rad < -180)
     set(handles.warning,'String',sprintf('OUT OF RANGE..!!! The condition should be like this: (d3<0; -155<Theta1<155; -145<Theta2<145; -180<Theta4<180)'));
     set(handles.x_2,'String',0);
     set(handles.y_2,'String',0);
     set(handles.z_2,'String',0);
     set(handles.roll_2,'String',0);
     set(handles.pitch_2,'String',0);
     set(handles.yaw_2,'String',0);
else
    set(handles.warning,'String',sprintf('                     ...Approved...                      '));   

    
    dentatheta1 = (handles.theta1_2 - handles.theta(1))/100;
    dentatheta2 = (handles.theta2_2 - handles.theta(2))/100;
    dentad3 = (handles.d3_2 - handles.d(3))/100;
    dentatheta4 = (handles.theta4_2 - handles.theta(4))/100;
    
    aa = zeros(100);
    bb = zeros(100);
    cc = zeros(100);
    
    for m=1:100
        
        handles.theta(1) = handles.theta(1) + dentatheta1;
        handles.theta(2) = handles.theta(2) + dentatheta2;
        handles.d(3) = handles.d(3) + dentad3;
        handles.theta(4) = handles.theta(4) + dentatheta4;
        
    %DH matrix frame
DH=zeros(4,4,4);
for i=1:4
        DH(:,:,i)=[cos(handles.theta(i)) -cos(handles.alpha(i))*sin(handles.theta(i)) sin(handles.alpha(i))*sin(handles.theta(i)) handles.a(i)*cos(handles.theta(i));
               sin(handles.theta(i)) cos(handles.alpha(i))*cos(handles.theta(i)) -sin(handles.alpha(i))*cos(handles.theta(i)) handles.a(i)*sin(handles.theta(i));
               0 sin(handles.alpha(i)) cos(handles.alpha(i)) handles.d(i);
               0 0 0 1];
end

%new joint position
handles.J1_new = handles.J1;
handles.J2_new = DH(:,:,1)*[0 0 0 1]';
handles.J3_new = DH(:,:,1)*DH(:,:,2)*[0 0 0 1]';
handles.J4_new = DH(:,:,1)*DH(:,:,2)*DH(:,:,3)*[0 0 0 1]';

%new grip position
T_matrix =(DH(:,:,1)*DH(:,:,2)*DH(:,:,3)*DH(:,:,4));
handles.grip1_new = T_matrix*[0 -50 50 1]';
handles.grip2_new = T_matrix*[0 -50 0 1]';
handles.grip4_new = T_matrix*[0 50 0 1]';
handles.grip3_new = T_matrix*[0 50 50 1]';

%plot new position of robot
hold off;

draw3d(handles.J1_new,handles.J2_new,handles.J3_new,handles.J4_new,handles.grip1_new,handles.grip2_new,handles.grip3_new,handles.grip4_new);

%with T matrix above, we have
rotation_matrix=T_matrix(1:3,1:3);
handles.p1 = atan2(-rotation_matrix(3,1),sqrt(rotation_matrix(3,2)^2+rotation_matrix(3,3)^2));
handles.p2 = atan2(-rotation_matrix(3,1),-sqrt(rotation_matrix(3,2)^2+rotation_matrix(3,3)^2));
handles.r1 = atan2(rotation_matrix(3,2)/cos(handles.p1),rotation_matrix(3,3)/cos(handles.p1));
handles.r2 = atan2(rotation_matrix(3,2)/cos(handles.p2),rotation_matrix(3,3)/cos(handles.p2));
handles.y1 = atan2(rotation_matrix(2,1)/cos(handles.p1),rotation_matrix(1,1)/cos(handles.p1));
handles.y2 = atan2(rotation_matrix(2,1)/cos(handles.p2),rotation_matrix(1,1)/cos(handles.p2));


plot_axis_each_joint(DH);


hold on;

aa(m) = handles.J4_new(1);
bb(m) = handles.J4_new(2);
cc(m) = handles.J4_new(3);

for j=1:m
plot3(aa(j),bb(j),cc(j),'o','MarkerSize',2,'MarkerEdgeColor','r','MarkerFaceColor','r');
end

%set x y z values to guide
set(handles.x_2,'String',sprintf('%.2f',handles.J4_new(1)));
set(handles.y_2,'String',sprintf('%.2f',handles.J4_new(2)));
set(handles.z_2,'String',sprintf('%.2f',handles.J4_new(3)));

%with T matrix above, we have
rotation_matrix = T_matrix(1:3,1:3);
handles.p1 = atan2(-rotation_matrix(3,1),sqrt(rotation_matrix(3,2)^2+rotation_matrix(3,3)^2));
handles.p2 = atan2(-rotation_matrix(3,1),-sqrt(rotation_matrix(3,2)^2+rotation_matrix(3,3)^2));
handles.r1 = atan2(rotation_matrix(3,2)/cos(handles.p1),rotation_matrix(3,3)/cos(handles.p1));
handles.r2 = atan2(rotation_matrix(3,2)/cos(handles.p2),rotation_matrix(3,3)/cos(handles.p2));
handles.y1 = atan2(rotation_matrix(2,1)/cos(handles.p1),rotation_matrix(1,1)/cos(handles.p1));
handles.y2 = atan2(rotation_matrix(2,1)/cos(handles.p2),rotation_matrix(1,1)/cos(handles.p2));

%set roll pitch yaw values to guide
set(handles.roll_2,'String',sprintf('%.2f',(handles.r1)/rad));
set(handles.pitch_2,'String',sprintf('%.2f',(handles.p1)/rad));
set(handles.yaw_2,'String',sprintf('%.2f',(handles.y1)/rad));

pause(0.005);

    end
    
end

end

function inverse_Callback(hObject, eventdata, handles)
hold off;
if handles.linear.Value == 1 && handles.circular.Value == 0
    linear(handles);
elseif handles.linear.Value == 0 && handles.circular.Value == 1
    circular(handles);
end

function linear(handles)
hold off;
rad = pi/180;

%position 1
handles.px = str2double(get(handles.x,'String'));
handles.py = str2double(get(handles.y,'String'));
handles.pz = str2double(get(handles.z,'String'));

handles.r1 = str2double(get(handles.roll,'String'))*rad;
handles.p1 = str2double(get(handles.pitch,'String'))*rad;
handles.y1 = str2double(get(handles.yaw,'String'))*rad;

if sqrt(handles.px^2+handles.py^2) <= 195 || sqrt(handles.px^2+handles.py^2) > 650 || handles.pz < 0 || handles.pz >330 || handles.y1 > pi || handles.y1 < -pi
    set(handles.warning,'String',sprintf('OUT OF RANGE..!!!... The condition should be like this: -612<=X<=650; -650<=Y<=650; 0<=Z<=330; -180<=YAW<=180; 150^2<=X^2+Y^2<=650^2'));
    set(handles.theta1,'String',0);
    set(handles.theta2,'String',0);
    set(handles.theta3,'String',0);
    set(handles.theta4,'String',0);
else  
handles.r1 = pi;
handles.p1 = 0;
set(handles.roll,'String',sprintf('%.2f',handles.r1/rad));
set(handles.pitch,'String',sprintf('%.2f',handles.p1/rad));

set(handles.warning,'String',sprintf('                    ...Approved...                       '));


    handles.d(3) = handles.pz - handles.d(1) - handles.d(4);
    
    cos_theta2 = (handles.px^2 + handles.py^2 - handles.a(1)^2 - handles.a(2)^2)/(2*handles.a(1)*handles.a(2));
    sin_theta2 = sqrt(1 - cos_theta2^2);
    handles.theta(2) = atan2(sin_theta2, cos_theta2);
    
    sin_theta1 = (handles.py*(handles.a(1) + handles.a(2)*cos(handles.theta(2))) - handles.px*handles.a(2)*sin(handles.theta(2)))...
        /((handles.a(2)^2)*(sin(handles.theta(2))^2) + (handles.a(1)+handles.a(2)*cos(handles.theta(2)))^2);
    cos_theta1 = (handles.px+handles.a(2)*sin(handles.theta(2))*sin_theta1)/(handles.a(1)+handles.a(2)*cos(handles.theta(2)));
    handles.theta(1) = atan2(sin_theta1, cos_theta1);
    
    handles.theta(4) = handles.y1 - handles.theta(1) - handles.theta(2);
    
    handles.theta(3)= 0;
    
        for i = 1:4
            if abs(handles.theta(i)) > pi
                handles.theta(i) = mod(handles.theta(i),pi);
            end
        end
    
    %set values
    set(handles.theta1,'String',sprintf('%.2f',handles.theta(1)/rad));
    set(handles.theta2,'String',sprintf('%.2f',handles.theta(2)/rad));
    set(handles.theta3,'String',sprintf('%.2f',handles.d(3)));
    set(handles.theta4,'String',sprintf('%.2f',handles.theta(4)/rad));



%position 2
handles.px_2 = str2double(get(handles.x_2,'String'));
handles.py_2 = str2double(get(handles.y_2,'String'));
handles.pz_2 = str2double(get(handles.z_2,'String'));

handles.r1_2 = str2double(get(handles.roll_2,'String'))*rad;
handles.p1_2 = str2double(get(handles.pitch_2,'String'))*rad;
handles.y1_2 = str2double(get(handles.yaw_2,'String'))*rad;

if sqrt(handles.px_2^2+handles.py_2^2) <= 195 || sqrt(handles.px_2^2+handles.py_2^2) > 650 || handles.pz_2 < 0 || handles.pz_2 >330 || handles.y1_2 > pi || handles.y1_2 < -pi
    set(handles.warning,'String',sprintf('OUT OF RANGE..!!!... The condition should be like this: -612<=X<=650; -650<=Y<=650; 0<=Z<=330; -180<=YAW<=180; 150^2<=X^2+Y^2<=650^2'));
    set(handles.theta1_22,'String',0);
    set(handles.theta2_22,'String',0);
    set(handles.theta3_22,'String',0);
    set(handles.theta4_22,'String',0);
else  
handles.r1_2 = pi;
handles.p1_2 = 0;
set(handles.roll_2,'String',sprintf('%.2f',handles.r1/rad));
set(handles.pitch_2,'String',sprintf('%.2f',handles.p1/rad));

set(handles.warning,'String',sprintf('                     ...Approved...                      '));


%caculate pmax
handles.pmax = sqrt((handles.px - handles.px_2)^2 + (handles.py - handles.py_2)^2 + (handles.pz - handles.pz_2)^2);
handles.vmax = str2double(get(handles.v_max,'String'));
handles.amax = str2double(get(handles.a_max,'String'));

set(handles.q_max,'String',sprintf('%.2f',handles.pmax));
handles.alfa = atan2((handles.pz - handles.pz_2), (handles.px - handles.px_2)^2 + (handles.pz - handles.pz_2)^2);
handles.beta = atan2((handles.py - handles.py_2), (handles.px - handles.px_2));

pmax = handles.pmax;
vmax = handles.vmax;
amax = handles.amax;

alfa = handles.alfa;
beta = handles.beta;

tc = vmax/amax;
tm = pmax/vmax - tc;
tf = 2*tc+tm;

q = zeros(1,100);
v = zeros(1,100);
v_x = zeros(1,100);
v_y = zeros(1,100);
v_z = zeros(1,100);
a = zeros(1,100);
time = zeros(1,100);

for i = 1:1:tf*100+1
    t = (i-1)*0.01;
    if t <= tc
        q(i) = amax/(2*tc)*t^2;
        v(i) = vmax/tc*t;
        v_x(i) = v(i)*cos(alfa)*cos(beta);
        v_y(i) = v(i)*cos(alfa)*sin(beta);
        v_z(i) = v(i)*sin(alfa);
        a(i) = amax;
    elseif (t > tc && t <= tc+tm)
        q(i) = vmax*t + amax*tc/2 - vmax*tc;
        v(i) = vmax;
        v_x(i) = v(i)*cos(alfa)*cos(beta);
        v_y(i) = v(i)*cos(alfa)*sin(beta);
        v_z(i) = v(i)*sin(alfa);
        a(i) = 0;
    elseif  (t>tc+tm && t <= tc+2*tm)
        q(i) = -amax/(2*tc)*t^2 + (vmax+amax/tc*(tm+tc))*t+pmax + amax/(2*tc)*tf^2 -(vmax+amax/tc*(tm+tc))*tf;
        v(i) = vmax/tc*(tf-t);
        v_x(i) = v(i)*cos(alfa)*cos(beta);
        v_y(i) = v(i)*cos(alfa)*sin(beta);
        v_z(i) = v(i)*sin(alfa);
        a(i) = -amax;
    end
    time(i) = t;
end

axes(handles.axes2);
plot(time,q,'r','LineWidth',2);
xlabel('position');
grid on;

axes(handles.axes3);
plot(time,v_x,'g','LineWidth',2);
xlabel('velocity_x');
grid on;

axes(handles.axes4);
plot(time,v_y,'g','LineWidth',2);
xlabel('velocity_y');
grid on;

axes(handles.axes5);
plot(time,v_z,'g','LineWidth',2);
xlabel('velocity_z');
grid on;

axes(handles.axes6);
plot(time,v,'g','LineWidth',2);
xlabel('velocity');
grid on;

axes(handles.axes7);
plot(time,a,'b','LineWidth',2);
xlabel('acceleration');
grid on;

axes(handles.axes1);


%plot robot 100 times
denta_px = -(handles.px - handles.px_2)/100;
denta_py = -(handles.py - handles.py_2)/100;
denta_pz = -(handles.pz - handles.pz_2)/100;
denta_y1 = -(handles.y1 - handles.y1_2)/100;

    aa = zeros(100);
    bb = zeros(100);
    cc = zeros(100);

for m=1:100
    
    handles.px = handles.px + denta_px;
    handles.py = handles.py + denta_py;
    handles.pz = handles.pz + denta_pz;
    handles.y1 = handles.y1 + denta_y1;
    
    handles.r1=pi;
    handles.p1=0;
    handles.d(3)= handles.pz - handles.d(1) - handles.d(4);
    cos_theta2= (handles.px^2+handles.py^2-handles.a(1)^2-handles.a(2)^2)/(2*handles.a(1)*handles.a(2));
    sin_theta2= sqrt(1-cos_theta2^2);
    
    handles.theta(2)= atan2(sin_theta2, cos_theta2);
    sin_theta1= (handles.py*(handles.a(1)+handles.a(2)*cos(handles.theta(2)))-handles.px*handles.a(2)*sin(handles.theta(2)))/((handles.a(2)^2)*(sin(handles.theta(2))^2)+(handles.a(1)+handles.a(2)*cos(handles.theta(2)))^2);
    cos_theta1= (handles.px+handles.a(2)*sin(handles.theta(2))*sin_theta1)/(handles.a(1)+handles.a(2)*cos(handles.theta(2)));
    handles.theta(1)= atan2(sin_theta1, cos_theta1);
    handles.theta(4)= handles.y1 - handles.theta(1) - handles.theta(2);
    handles.theta(3)=0;
     
        for i = 1:4
            if abs(handles.theta(i)) > pi
                handles.theta(i) = mod(handles.theta(i),pi);
            end
        end
    
    set(handles.theta1_22,'String',sprintf('%.2f',handles.theta(1)/rad));
    set(handles.theta2_22,'String',sprintf('%.2f',handles.theta(2)/rad));
    set(handles.theta3_22,'String',sprintf('%.2f',handles.d(3)));
    set(handles.theta4_22,'String',sprintf('%.2f',handles.theta(4)/rad));
    
    %DH matrix frame
    DH = zeros(4,4,4);
    for i=1:4
        DH(:,:,i)=[cos(handles.theta(i)) -cos(handles.alpha(i))*sin(handles.theta(i)) sin(handles.alpha(i))*sin(handles.theta(i)) handles.a(i)*cos(handles.theta(i));
               sin(handles.theta(i)) cos(handles.alpha(i))*cos(handles.theta(i)) -sin(handles.alpha(i))*cos(handles.theta(i)) handles.a(i)*sin(handles.theta(i));
               0 sin(handles.alpha(i)) cos(handles.alpha(i)) handles.d(i);
               0 0 0 1];
    end
    
%new joint position
handles.J1_new= handles.J1;
handles.J2_new= DH(:,:,1)*[0 0 0 1]';
handles.J3_new= DH(:,:,1)*DH(:,:,2)*[0 0 0 1]';
handles.J4_new= DH(:,:,1)*DH(:,:,2)*DH(:,:,3)*[0 0 0 1]';

%new grip position
T_matrix = (DH(:,:,1)*DH(:,:,2)*DH(:,:,3)*DH(:,:,4));
handles.grip1_new = T_matrix*[0 -50 50 1]';
handles.grip2_new = T_matrix*[0 -50 0 1]';
handles.grip4_new = T_matrix*[0 50 0 1]';
handles.grip3_new = T_matrix*[0 50 50 1]';

%plot new position of robot
hold off;

draw3d(handles.J1_new,handles.J2_new,handles.J3_new,handles.J4_new,handles.grip1_new,handles.grip2_new,handles.grip3_new,handles.grip4_new);

plot_axis_each_joint(DH);

    %plot new position of robot
    aa(m) = handles.J4_new(1);
    bb(m) = handles.J4_new(2);
    cc(m) = handles.J4_new(3);
     for j = 1:m
        plot3(aa(j),bb(j),cc(j),'o','MarkerSize',2,'MarkerEdgeColor','b','MarkerFaceColor','b');
     end
    
    pause(0.005);
    
end
    
end

end

function circular(handles)
hold off;
rad = pi/180;

%position 1
handles.px = str2double(get(handles.x,'String'));
handles.py = str2double(get(handles.y,'String'));
handles.pz = str2double(get(handles.z,'String'));

handles.r1 = str2double(get(handles.roll,'String'))*rad;
handles.p1 = str2double(get(handles.pitch,'String'))*rad;
handles.y1 = str2double(get(handles.yaw,'String'))*rad;

if sqrt(handles.px^2+handles.py^2) <= 195 || sqrt(handles.px^2+handles.py^2) > 650 || handles.pz < 0 || handles.pz >330 || handles.y1 > pi || handles.y1 < -pi
    set(handles.warning,'String',sprintf('OUT OF RANGE..!!!... The condition should be like this: -612<=X<=650; -650<=Y<=650; 0<=Z<=330; -180<=YAW<=180; 150^2<=X^2+Y^2<=650^2'));
    set(handles.theta1,'String',0);
    set(handles.theta2,'String',0);
    set(handles.theta3,'String',0);
    set(handles.theta4,'String',0);
else  
handles.r1 = pi;
handles.p1 = 0;
set(handles.roll,'String',sprintf('%.2f',handles.r1/rad));
set(handles.pitch,'String',sprintf('%.2f',handles.p1/rad));

set(handles.warning,'String',sprintf('                    ...Approved...                       '));


    handles.d(3) = handles.pz - handles.d(1) - handles.d(4);
    
    cos_theta2 = (handles.px^2 + handles.py^2 - handles.a(1)^2 - handles.a(2)^2)/(2*handles.a(1)*handles.a(2));
    sin_theta2 = sqrt(1 - cos_theta2^2);
    handles.theta(2) = atan2(sin_theta2, cos_theta2);
    
    sin_theta1 = (handles.py*(handles.a(1) + handles.a(2)*cos(handles.theta(2))) - handles.px*handles.a(2)*sin(handles.theta(2)))/((handles.a(2)^2)*(sin(handles.theta(2))^2) + (handles.a(1)+handles.a(2)*cos(handles.theta(2)))^2);
    cos_theta1 = (handles.px+handles.a(2)*sin(handles.theta(2))*sin_theta1)/(handles.a(1)+handles.a(2)*cos(handles.theta(2)));
    handles.theta(1) = atan2(sin_theta1, cos_theta1);
    
    handles.theta(4) = handles.y1 - handles.theta(1) - handles.theta(2);
    
    handles.theta(3)= 0;
    
        for i = 1:4
            if abs(handles.theta(i)) > pi
                handles.theta(i) = mod(handles.theta(i),pi);
            end
        end
    
    %set values
    set(handles.theta1,'String',sprintf('%.2f',handles.theta(1)/rad));
    set(handles.theta2,'String',sprintf('%.2f',handles.theta(2)/rad));
    set(handles.theta3,'String',sprintf('%.2f',handles.d(3)));
    set(handles.theta4,'String',sprintf('%.2f',handles.theta(4)/rad));



%position 2
handles.px_2 = str2double(get(handles.x_2,'String'));
handles.py_2 = str2double(get(handles.y_2,'String'));
handles.pz_2 = str2double(get(handles.z_2,'String'));

handles.r1_2 = str2double(get(handles.roll_2,'String'))*rad;
handles.p1_2 = str2double(get(handles.pitch_2,'String'))*rad;
handles.y1_2 = str2double(get(handles.yaw_2,'String'))*rad;

if sqrt(handles.px_2^2+handles.py_2^2) <= 195 || sqrt(handles.px_2^2+handles.py_2^2) > 650 || handles.pz_2 < 0 || handles.pz_2 >330 || handles.y1_2 > pi || handles.y1_2 < -pi
    set(handles.warning,'String',sprintf('OUT OF RANGE..!!!... The condition should be like this: -612<=X<=650; -650<=Y<=650; 0<=Z<=330; -180<=YAW<=180; 150^2<=X^2+Y^2<=650^2'));
    set(handles.theta1_22,'String',0);
    set(handles.theta2_22,'String',0);
    set(handles.theta3_22,'String',0);
    set(handles.theta4_22,'String',0);
else  
handles.r1_2 = pi;
handles.p1_2 = 0;
set(handles.roll_2,'String',sprintf('%.2f',handles.r1/rad));
set(handles.pitch_2,'String',sprintf('%.2f',handles.p1/rad));

set(handles.warning,'String',sprintf('                     ...Approved...                      '));

%taam cuar duongwf tronf
handles.ix = (handles.px_2 + handles.px)/2;
handles.iy = (handles.py_2 + handles.py)/2;

handles.r = sqrt((handles.px - handles.px_2)^2 + (handles.py - handles.py_2)^2)/2;

handles.phi = acos((handles.px_2 - handles.px)/sqrt((handles.px_2 - handles.px)^2 + (handles.py_2 - handles.py)^2));

denta_z = (handles.pz_2 - handles.pz)/100;
denta_y1 = (handles.y1_2 - handles.y1)/100;

set(handles.R,'String',sprintf('%.2f',handles.r));

    aa = zeros(100);
    bb = zeros(100);
    cc = zeros(100);

for m=1:100
    if (handles.counter.Value == 0)
        handles.phi = handles.phi - pi/100;
    else
        handles.phi = handles.phi + pi/100;
    end
    
    handles.px = -handles.r*cos(handles.phi) + handles.ix;
    handles.py = -handles.r*sin(handles.phi) + handles.iy;
    handles.pz = handles.pz + denta_z;
    handles.y1 = pi;
    handles.r1 = 0;
    handles.y1 = handles.y1 + denta_y1;
    
    handles.d(3)= handles.pz - handles.d(1) - handles.d(4);
    cos_theta2= (handles.px^2+handles.py^2-handles.a(1)^2-handles.a(2)^2)/(2*handles.a(1)*handles.a(2));
    sin_theta2= sqrt(1-cos_theta2^2);
    
    handles.theta(2)= atan2(sin_theta2, cos_theta2);
    sin_theta1= (handles.py*(handles.a(1)+handles.a(2)*cos(handles.theta(2)))-handles.px*handles.a(2)*sin(handles.theta(2)))/((handles.a(2)^2)*(sin(handles.theta(2))^2)+(handles.a(1)+handles.a(2)*cos(handles.theta(2)))^2);
    cos_theta1= (handles.px+handles.a(2)*sin(handles.theta(2))*sin_theta1)/(handles.a(1)+handles.a(2)*cos(handles.theta(2)));
    handles.theta(1)= atan2(sin_theta1, cos_theta1);
    handles.theta(4)= handles.y1 - handles.theta(1) - handles.theta(2);
    handles.theta(3)=0;
     
        for i = 1:4
            if abs(handles.theta(i)) > pi
                handles.theta(i) = mod(handles.theta(i),pi);
            end
        end
    
    set(handles.theta1_22,'String',sprintf('%.2f',handles.theta(1)/rad));
    set(handles.theta2_22,'String',sprintf('%.2f',handles.theta(2)/rad));
    set(handles.theta3_22,'String',sprintf('%.2f',handles.d(3)));
    set(handles.theta4_22,'String',sprintf('%.2f',handles.theta(4)/rad));
    
    %DH matrix frame
    DH = zeros(4,4,4);
    for i=1:4
        DH(:,:,i)=[cos(handles.theta(i)) -cos(handles.alpha(i))*sin(handles.theta(i)) sin(handles.alpha(i))*sin(handles.theta(i)) handles.a(i)*cos(handles.theta(i));
               sin(handles.theta(i)) cos(handles.alpha(i))*cos(handles.theta(i)) -sin(handles.alpha(i))*cos(handles.theta(i)) handles.a(i)*sin(handles.theta(i));
               0 sin(handles.alpha(i)) cos(handles.alpha(i)) handles.d(i);
               0 0 0 1];
    end
    
%new joint position
handles.J1_new= handles.J1;
handles.J2_new= DH(:,:,1)*[0 0 0 1]';
handles.J3_new= DH(:,:,1)*DH(:,:,2)*[0 0 0 1]';
handles.J4_new= DH(:,:,1)*DH(:,:,2)*DH(:,:,3)*[0 0 0 1]';

%new grip position
T_matrix = (DH(:,:,1)*DH(:,:,2)*DH(:,:,3)*DH(:,:,4));
handles.grip1_new = T_matrix*[0 -50 50 1]';
handles.grip2_new = T_matrix*[0 -50 0 1]';
handles.grip4_new = T_matrix*[0 50 0 1]';
handles.grip3_new = T_matrix*[0 50 50 1]';

%plot new position of robot
hold off;

draw3d(handles.J1_new,handles.J2_new,handles.J3_new,handles.J4_new,handles.grip1_new,handles.grip2_new,handles.grip3_new,handles.grip4_new);

plot_axis_each_joint(DH);

    %plot new position of robot
    aa(m) = handles.J4_new(1);
    bb(m) = handles.J4_new(2);
    cc(m) = handles.J4_new(3);
     for j = 1:m
        plot3(aa(j),bb(j),cc(j),'o','MarkerSize',2,'MarkerEdgeColor','r','MarkerFaceColor','r');
     end
    
    pause(0.005);

end

end

end 

function trianlge(handles)
rad = pi/180;

%position 1
handles.px = str2double(get(handles.x,'String'));
handles.py = str2double(get(handles.y,'String'));
handles.pz = str2double(get(handles.z,'String'));

handles.r1 = str2double(get(handles.roll,'String'))*rad;
handles.p1 = str2double(get(handles.pitch,'String'))*rad;
handles.y1 = str2double(get(handles.yaw,'String'))*rad;

if sqrt(handles.px^2+handles.py^2) <= 195 || sqrt(handles.px^2+handles.py^2) > 650 || handles.pz < 0 || handles.pz >330 || handles.y1 > pi || handles.y1 < -pi
    set(handles.warning,'String',sprintf('OUT OF RANGE..!!!... The condition should be like this: -612<=X<=650; -650<=Y<=650; 0<=Z<=330; -180<=YAW<=180; 150^2<=X^2+Y^2<=650^2'));
    set(handles.theta1,'String',0);
    set(handles.theta2,'String',0);
    set(handles.theta3,'String',0);
    set(handles.theta4,'String',0);
else  
handles.r1 = pi;
handles.p1 = 0;
set(handles.roll,'String',sprintf('%.2f',handles.r1/rad));
set(handles.pitch,'String',sprintf('%.2f',handles.p1/rad));

set(handles.warning,'String',sprintf('                    ...Approved...                       '));


%position 2
handles.px_2 = str2double(get(handles.x_2,'String'));
handles.py_2 = str2double(get(handles.y_2,'String'));
handles.pz_2 = str2double(get(handles.z_2,'String'));

handles.r1_2 = str2double(get(handles.roll_2,'String'))*rad;
handles.p1_2 = str2double(get(handles.pitch_2,'String'))*rad;
handles.y1_2 = str2double(get(handles.yaw_2,'String'))*rad;

if sqrt(handles.px_2^2+handles.py_2^2) <= 195 || sqrt(handles.px_2^2+handles.py_2^2) > 650 || handles.pz_2 < 0 || handles.pz_2 >330 || handles.y1_2 > pi || handles.y1_2 < -pi
    set(handles.warning,'String',sprintf('OUT OF RANGE..!!!... The condition should be like this: -612<=X<=650; -650<=Y<=650; 0<=Z<=330; -180<=YAW<=180; 150^2<=X^2+Y^2<=650^2'));
    set(handles.theta1_22,'String',0);
    set(handles.theta2_22,'String',0);
    set(handles.theta3_22,'String',0);
    set(handles.theta4_22,'String',0);
else  
handles.r1_2 = pi;
handles.p1_2 = 0;
set(handles.roll_2,'String',sprintf('%.2f',handles.r1/rad));
set(handles.pitch_2,'String',sprintf('%.2f',handles.p1/rad));

set(handles.warning,'String',sprintf('                     ...Approved...                      '));


%caculate pmax
handles.pmax = sqrt((handles.px - handles.px_2)^2 + (handles.py - handles.py_2)^2 + (handles.pz - handles.pz_2)^2);
handles.vmax = str2double(get(handles.v_max,'String'));
handles.amax = str2double(get(handles.a_max,'String'));

set(handles.q_max,'String',sprintf('%.2f',handles.pmax));
handles.alfa = atan2((handles.pz - handles.pz_2), (handles.px - handles.px_2)^2 + (handles.pz - handles.pz_2)^2);
handles.beta = atan2((handles.py - handles.py_2), (handles.px - handles.px_2));

pmax = handles.pmax;
vmax = handles.vmax;
amax = handles.amax;

alfa = handles.alfa;
beta = handles.beta;

tc = 2*vmax/amax;          
tm = pmax/vmax - tc;      
tf = 2*tc + tm;

q = zeros(1,100);
v = zeros(1,100);
v_x = zeros(1,100);
v_y = zeros(1,100);
v_z = zeros(1,100);
a = zeros(1,100);
time = zeros(1,100);

for i = 1:1:tf*100+1
    t = (i-1)*0.01;
    if t <= tc/2 
        q(i) = (amax/(3*tc))*t^3;
        v(i) = (amax/tc)*t^2;
        a(i) = (2*amax/tc)*t;
    elseif (t>tc/2 && t <= tc) 
        q(i) = (-amax/(3*tc))*t^3 + amax*t^2 - vmax*t + vmax*tc/2 - amax*tc^2/6;
        v(i) = (-amax/tc)*t^2 + 2*amax*t - vmax;
        a(i) = (-2*amax/tc)*(t-tc);
    elseif (t>tc && t <= tc+tm)
        q(i) = vmax*t + amax*tc^2/2 - 3*vmax*tc/2;
        v(i) = vmax;
        a(i) = 0;
    elseif (t>tc+tm && t <= tf-tc/2)
        q(i) = -amax/(3*tc)*t^3 + amax/tc*(tc+tm)*t^2 + (vmax-amax/tc*(tc+tm)^2)*t + amax/(3*tc)*(tc+tm)^3 + amax/2*tc^2 - 3*vmax*tc/2;
        v(i) = (-amax*t^2)/tc +(2*amax*(tc+tm)*t)/tc + vmax -amax/tc*(tc+tm)^2;
        a(i) = (-2*amax/tc)*(t-tc-tm);
    elseif (t>tf-tc/2 && t <= tf)
        k = (-amax*(tm+3*tc/2)^2)/tc +(2*amax*(tc+tm)*(tm+3*tc/2))/tc + vmax -amax/tc*(tc+tm)^2 - amax/tc*(tm+3*tc/2)^2+2*amax/tc*(tm+2*tc)*(tm+3*tc/2);
        h = -amax/(3*tc)*(tm+3*tc/2)^3 + amax/tc*(tc+tm)*(tm+3*tc/2)^2 + (vmax-amax/tc*(tc+tm)^2)*(tm+3*tc/2) + amax/(3*tc)*(tc+tm)^3 + amax/2*tc^2 - 3*vmax*tc/2 - amax/(3*tc)*(tm+3*tc/2)^3 + amax/tc*(tm+2*tc)*(tm+3*tc/2)^2 - k*(tm+3*tc/2);
        q(i) = amax/(3*tc)*t^3 - amax/tc*(tm+2*tc)*t^2 + k*t +h;
        v(i) = amax/tc*t^2 -2*amax/tc*(tm+2*tc)*t+k;
        a(i) = (2*amax/tc)*(t-tf);
    end
        v_x(i) = v(i)*cos(alfa)*cos(beta);
        v_y(i) = v(i)*cos(alfa)*sin(beta);
        v_z(i) = v(i)*sin(alfa);
    time(i) = t;
end
axes(handles.axes2);
plot(time,q,'r','LineWidth',2);
xlabel('position');
grid on;

axes(handles.axes3);
plot(time,v_x,'g','LineWidth',2);
xlabel('velocity_x');
grid on;

axes(handles.axes4);
plot(time,v_y,'g','LineWidth',2);
xlabel('velocity_y');
grid on;

axes(handles.axes5);
plot(time,v_z,'g','LineWidth',2);
xlabel('velocity_z');
grid on;

axes(handles.axes6);
plot(time,v,'g','LineWidth',2);
xlabel('velocity');
grid on;

axes(handles.axes7);
plot(time,a,'b','LineWidth',2);
xlabel('acceleration');
grid on;

axes(handles.axes1);
end
end

function rectangle(handles)
rad = pi/180;

%position 1
handles.px = str2double(get(handles.x,'String'));
handles.py = str2double(get(handles.y,'String'));
handles.pz = str2double(get(handles.z,'String'));

handles.r1 = str2double(get(handles.roll,'String'))*rad;
handles.p1 = str2double(get(handles.pitch,'String'))*rad;
handles.y1 = str2double(get(handles.yaw,'String'))*rad;

if sqrt(handles.px^2+handles.py^2) <= 195 || sqrt(handles.px^2+handles.py^2) > 650 || handles.pz < 0 || handles.pz >330 || handles.y1 > pi || handles.y1 < -pi
    set(handles.warning,'String',sprintf('OUT OF RANGE..!!!... The condition should be like this: -612<=X<=650; -650<=Y<=650; 0<=Z<=330; -180<=YAW<=180; 150^2<=X^2+Y^2<=650^2'));
    set(handles.theta1,'String',0);
    set(handles.theta2,'String',0);
    set(handles.theta3,'String',0);
    set(handles.theta4,'String',0);
else  
handles.r1 = pi;
handles.p1 = 0;
set(handles.roll,'String',sprintf('%.2f',handles.r1/rad));
set(handles.pitch,'String',sprintf('%.2f',handles.p1/rad));

set(handles.warning,'String',sprintf('                    ...Approved...                       '));

%position 2
handles.px_2 = str2double(get(handles.x_2,'String'));
handles.py_2 = str2double(get(handles.y_2,'String'));
handles.pz_2 = str2double(get(handles.z_2,'String'));

handles.r1_2 = str2double(get(handles.roll_2,'String'))*rad;
handles.p1_2 = str2double(get(handles.pitch_2,'String'))*rad;
handles.y1_2 = str2double(get(handles.yaw_2,'String'))*rad;

if sqrt(handles.px_2^2+handles.py_2^2) <= 195 || sqrt(handles.px_2^2+handles.py_2^2) > 650 || handles.pz_2 < 0 || handles.pz_2 >330 || handles.y1_2 > pi || handles.y1_2 < -pi
    set(handles.warning,'String',sprintf('OUT OF RANGE..!!!... The condition should be like this: -612<=X<=650; -650<=Y<=650; 0<=Z<=330; -180<=YAW<=180; 150^2<=X^2+Y^2<=650^2'));
    set(handles.theta1_22,'String',0);
    set(handles.theta2_22,'String',0);
    set(handles.theta3_22,'String',0);
    set(handles.theta4_22,'String',0);
else  
handles.r1_2 = pi;
handles.p1_2 = 0;
set(handles.roll_2,'String',sprintf('%.2f',handles.r1/rad));
set(handles.pitch_2,'String',sprintf('%.2f',handles.p1/rad));

set(handles.warning,'String',sprintf('                     ...Approved...                      '));


%caculate pmax
handles.pmax = sqrt((handles.px - handles.px_2)^2 + (handles.py - handles.py_2)^2 + (handles.pz - handles.pz_2)^2);
handles.vmax = str2double(get(handles.v_max,'String'));
handles.amax = str2double(get(handles.a_max,'String'));

set(handles.q_max,'String',sprintf('%.2f',handles.pmax));
handles.alfa = atan2((handles.pz - handles.pz_2), (handles.px - handles.px_2)^2 + (handles.pz - handles.pz_2)^2);
handles.beta = atan2((handles.py - handles.py_2), (handles.px - handles.px_2));

pmax = handles.pmax;
vmax = handles.vmax;
amax = handles.amax;

alfa = handles.alfa;
beta = handles.beta;

tc = vmax/amax;
tm = pmax/vmax - tc;
tf = 2*tc+tm;

q = zeros(1,100);
v = zeros(1,100);
v_x = zeros(1,100);
v_y = zeros(1,100);
v_z = zeros(1,100);
a = zeros(1,100);
time = zeros(1,100);

for i = 1:1:tf*100+1
    t = (i-1)*0.01;
    if t <= tc
        q(i) = amax/(2*tc)*t^2;
        v(i) = vmax/tc*t;
        v_x(i) = v(i)*cos(alfa)*cos(beta);
        v_y(i) = v(i)*cos(alfa)*sin(beta);
        v_z(i) = v(i)*sin(alfa);
        a(i) = amax;
    elseif (t > tc && t <= tc+tm)
        q(i) = vmax*t + amax*tc/2 - vmax*tc;
        v(i) = vmax;
        v_x(i) = v(i)*cos(alfa)*cos(beta);
        v_y(i) = v(i)*cos(alfa)*sin(beta);
        v_z(i) = v(i)*sin(alfa);
        a(i) = 0;
    elseif  (t>tc+tm && t <= tc+2*tm)
        q(i) = -amax/(2*tc)*t^2 + (vmax+amax/tc*(tm+tc))*t+pmax + amax/(2*tc)*tf^2 -(vmax+amax/tc*(tm+tc))*tf;
        v(i) = vmax/tc*(tf-t);
        v_x(i) = v(i)*cos(alfa)*cos(beta);
        v_y(i) = v(i)*cos(alfa)*sin(beta);
        v_z(i) = v(i)*sin(alfa);
        a(i) = -amax;
    end
    time(i) = t;
end

axes(handles.axes2);
plot(time,q,'r','LineWidth',2);
xlabel('position');
grid on;

axes(handles.axes3);
plot(time,v_x,'g','LineWidth',2);
xlabel('velocity_x');
grid on;

axes(handles.axes4);
plot(time,v_y,'g','LineWidth',2);
xlabel('velocity_y');
grid on;

axes(handles.axes5);
plot(time,v_z,'g','LineWidth',2);
xlabel('velocity_z');
grid on;

axes(handles.axes6);
plot(time,v,'g','LineWidth',2);
xlabel('velocity');
grid on;

axes(handles.axes7);
plot(time,a,'b','LineWidth',2);
xlabel('acceleration');
grid on;

axes(handles.axes1);
end
end

function [h]=arrow3d(x,y,z,head_frac,radii,radii2,colr)
if size(x,1)==2
    x=x';
    y=y';
    z=z';
end
x(3)=x(2);
x(2)=x(1)+head_frac*(x(3)-x(1));
y(3)=y(2);
y(2)=y(1)+head_frac*(y(3)-y(1));
z(3)=z(2);
z(2)=z(1)+head_frac*(z(3)-z(1));
r=[x(1:2)',y(1:2)',z(1:2)'];
N=50;
dr=diff(r);
dr(end+1,:)=dr(end,:);
origin_shift=(ones(size(r))*(1+max(abs(r(:))))+[dr(:,1) 2*dr(:,2) -dr(:,3)]);
r=r+origin_shift;
normdr=(sqrt((dr(:,1).^2)+(dr(:,2).^2)+(dr(:,3).^2)));
normdr=[normdr,normdr,normdr];
dr=dr./normdr;
Pc=r;
n1=cross(dr,Pc);
normn1=(sqrt((n1(:,1).^2)+(n1(:,2).^2)+(n1(:,3).^2)));
normn1=[normn1,normn1,normn1];
n1=n1./normn1;
P1=n1+Pc;
X1=[];Y1=[];Z1=[];
j=1;
for theta=([0:N])*2*pi./(N)
    R1=Pc+radii*cos(theta).*(P1-Pc) + radii*sin(theta).*cross(dr,(P1-Pc)) -origin_shift;
    X1(2:3,j)=R1(:,1);
    Y1(2:3,j)=R1(:,2);
    Z1(2:3,j)=R1(:,3);
    j=j+1;
end
r=[x(2:3)',y(2:3)',z(2:3)'];
dr=diff(r);
dr(end+1,:)=dr(end,:);
origin_shift=(ones(size(r))*(1+max(abs(r(:))))+[dr(:,1) 2*dr(:,2) -dr(:,3)]);
r=r+origin_shift;
normdr=(sqrt((dr(:,1).^2)+(dr(:,2).^2)+(dr(:,3).^2)));
normdr=[normdr,normdr,normdr];
dr=dr./normdr;
Pc=r;
n1=cross(dr,Pc);
normn1=(sqrt((n1(:,1).^2)+(n1(:,2).^2)+(n1(:,3).^2)));
normn1=[normn1,normn1,normn1];
n1=n1./normn1;
P1=n1+Pc;
j=1;
for theta=([0:N])*2*pi./(N)
    R1=Pc+radii2*cos(theta).*(P1-Pc) + radii2*sin(theta).*cross(dr,(P1-Pc)) -origin_shift;
    X1(4:5,j)=R1(:,1);
    Y1(4:5,j)=R1(:,2);
    Z1(4:5,j)=R1(:,3);
    j=j+1;
end
X1(1,:)=X1(1,:)*0 + x(1);
Y1(1,:)=Y1(1,:)*0 + y(1);
Z1(1,:)=Z1(1,:)*0 + z(1);
X1(5,:)=X1(5,:)*0 + x(3);
Y1(5,:)=Y1(5,:)*0 + y(3);
Z1(5,:)=Z1(5,:)*0 + z(3);
h=surf(X1,Y1,Z1,'facecolor',colr,'edgecolor','none');

function plot_axis_each_joint(DH)

x1 = 0; y1 = 150; z1 = 450;

%joint position
handles.J1 = [x1 y1 z1 1]';

%plot mini axis of each joint

handles.J1_new = handles.J1;
handles.J2_new = DH(:,:,1)*[0 0 0 1]';
handles.J3_new = DH(:,:,1)*DH(:,:,2)*[0 0 0 1]';

%calculate J3 axis
J3_xaxis = DH(:,:,1)*DH(:,:,2)*[300 0 0 1]';
J3_yaxis = DH(:,:,1)*DH(:,:,2)*[0 300 0 1]';
J3_zaxis = DH(:,:,1)*DH(:,:,2)*[0 0 100 1]';

arrow3d([handles.J3_new(1) J3_xaxis(1)],[handles.J3_new(2) J3_xaxis(2)],[handles.J3_new(3) J3_xaxis(3)],0.5,3,5,'r');
arrow3d([handles.J3_new(1) J3_yaxis(1)],[handles.J3_new(2) J3_yaxis(2)],[handles.J3_new(3) J3_yaxis(3)],0.5,3,5,'b');
arrow3d([handles.J3_new(1) J3_zaxis(1)],[handles.J3_new(2) J3_zaxis(2)],[handles.J3_new(3) J3_zaxis(3)],0.5,9,15,'y');

%calculate J2 axis
J2_xaxis = DH(:,:,1)*[300 0 0 1]';
J2_yaxis = DH(:,:,1)*[0 300 0 1]';
J2_zaxis = DH(:,:,1)*[0 0 100 1]';

arrow3d([handles.J2_new(1) J2_xaxis(1)],[handles.J2_new(2) J2_xaxis(2)],[handles.J2_new(3) J2_xaxis(3)],0.5,3,5,'r');
arrow3d([handles.J2_new(1) J2_yaxis(1)],[handles.J2_new(2) J2_yaxis(2)],[handles.J2_new(3) J2_yaxis(3)],0.5,3,5,'b');
arrow3d([handles.J2_new(1) J2_zaxis(1)],[handles.J2_new(2) J2_zaxis(2)],[handles.J2_new(3) J2_zaxis(3)],0.5,9,15,'y');

%calculate frame 0 axis
frame0_xaxis = [300 0 0 1]';
frame0_yaxis = [0 300 0 1]';
frame0_zaxis = [0 0 100 1]';

arrow3d([0 frame0_xaxis(1)],[0 frame0_xaxis(2)],[0 frame0_xaxis(3)],0.5,3,5,'r');
arrow3d([0 frame0_yaxis(1)],[0 frame0_yaxis(2)],[0 frame0_yaxis(3)],0.5,3,5,'b');
arrow3d([0 frame0_zaxis(1)],[0 frame0_zaxis(2)],[0 frame0_zaxis(3)],0.5,9,15,'y');

function draw3d(arg1, arg2, arg3, arg4)
rotate3d on
%plot robot arms
hold on;
plot3([arg1(1) arg2(1)],[arg1(2) arg2(2)],[arg1(3) arg2(3)],'c','LineWidth',5);
plot3([arg2(1) arg3(1)],[arg2(2) arg3(2)],[arg2(3) arg3(3)],'c','LineWidth',5);
plot3([arg3(1) arg4(1)],[arg3(2) arg4(2)],[arg3(3) arg4(3)],'c','LineWidth',5);


%plot joint
plot3(0,0,0,'o','MarkerSize',15,'MarkerEdgeColor','c','MarkerFaceColor','c');
plot3(arg1(1),arg1(2),arg1(3),'o','MarkerSize',15,'MarkerEdgeColor','c','MarkerFaceColor','c');
plot3(arg2(1),arg2(2),arg2(3),'o','MarkerSize',15,'MarkerEdgeColor','c','MarkerFaceColor','c');
plot3(arg3(1),arg3(2),arg3(3),'o','MarkerSize',15,'MarkerEdgeColor','c','MarkerFaceColor','c');
plot3(arg4(1),arg4(2),arg4(3),'o','MarkerSize',15,'MarkerEdgeColor','c','MarkerFaceColor','c');

%plot end effector
%plot3([arg7(1) arg8(1)],[arg7(2) arg8(2)],[arg7(3) arg8(3)],'c','LineWidth',3);
%plot3([arg8(1) arg10(1)],[arg8(2) arg10(2)],[arg8(3) arg10(3)],'c','LineWidth',3);
%plot3([arg10(1) arg9(1)],[arg10(2) arg9(2)],[arg10(3) arg9(3)],'c','LineWidth',3);
grid on;

axis([-1500 1500 -1500 1500 -10 1200]);
xlabel('X');
ylabel('Y');
zlabel('Z');

% --- Executes on button press in Linear.
function linear_Callback(hObject, eventdata, handles)
% hObject    handle to Linear (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.circular.Value = 0;
set(handles.R, 'enable', 'off');
set(handles.counter, 'enable','off');
set(handles.clockwises, 'enable', 'off');

% Hint: get(hObject,'Value') returns toggle state of Linear

% --- Executes on button press in triangle.
function circular_Callback(hObject, eventdata, handles)
% hObject    handle to triangle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.linear.Value = 0;
set(handles.R, 'enable', 'on')
set(handles.counter, 'enable','on');
set(handles.clockwises, 'enable', 'on');
% Hint: get(hObject,'Value') returns toggle state of triangle

% --- Executes on button press in rectangle.
function rectangle_Callback(hObject, eventdata, handles)
% hObject    handle to rectangle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
rectangle(handles);

% --- Executes on button press in triangle.
function triangle_Callback(hObject, eventdata, handles)
% hObject    handle to triangle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
trianlge(handles);

function theta1_22_Callback(hObject, eventdata, handles)
% hObject    handle to theta1_22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of theta1_22 as text
%        str2double(get(hObject,'String')) returns contents of theta1_22 as a double


% --- Executes during object creation, after setting all properties.
function theta1_22_CreateFcn(hObject, eventdata, handles)
% hObject    handle to theta1_22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function theta2_22_Callback(hObject, eventdata, handles)
% hObject    handle to theta2_22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of theta2_22 as text
%        str2double(get(hObject,'String')) returns contents of theta2_22 as a double


% --- Executes during object creation, after setting all properties.
function theta2_22_CreateFcn(hObject, eventdata, handles)
% hObject    handle to theta2_22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function theta3_22_Callback(hObject, eventdata, handles)
% hObject    handle to theta3_22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of theta3_22 as text
%        str2double(get(hObject,'String')) returns contents of theta3_22 as a double


% --- Executes during object creation, after setting all properties.
function theta3_22_CreateFcn(hObject, eventdata, handles)
% hObject    handle to theta3_22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function theta4_22_Callback(hObject, eventdata, handles)
% hObject    handle to theta4_22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of theta4_22 as text
%        str2double(get(hObject,'String')) returns contents of theta4_22 as a double


% --- Executes during object creation, after setting all properties.
function theta4_22_CreateFcn(hObject, eventdata, handles)
% hObject    handle to theta4_22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function x_2_Callback(hObject, eventdata, handles)
% hObject    handle to x_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of x_2 as text
%        str2double(get(hObject,'String')) returns contents of x_2 as a double


% --- Executes during object creation, after setting all properties.
function x_2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to x_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function y_2_Callback(hObject, eventdata, handles)
% hObject    handle to y_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of y_2 as text
%        str2double(get(hObject,'String')) returns contents of y_2 as a double


% --- Executes during object creation, after setting all properties.
function y_2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to y_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function z_2_Callback(hObject, eventdata, handles)
% hObject    handle to z_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of z_2 as text
%        str2double(get(hObject,'String')) returns contents of z_2 as a double


% --- Executes during object creation, after setting all properties.
function z_2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to z_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function roll_2_Callback(hObject, eventdata, handles)
% hObject    handle to roll_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of roll_2 as text
%        str2double(get(hObject,'String')) returns contents of roll_2 as a double


% --- Executes during object creation, after setting all properties.
function roll_2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to roll_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function pitch_2_Callback(hObject, eventdata, handles)
% hObject    handle to pitch_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of pitch_2 as text
%        str2double(get(hObject,'String')) returns contents of pitch_2 as a double


% --- Executes during object creation, after setting all properties.
function pitch_2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pitch_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function yaw_2_Callback(hObject, eventdata, handles)
% hObject    handle to yaw_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of yaw_2 as text
%        str2double(get(hObject,'String')) returns contents of yaw_2 as a double


% --- Executes during object creation, after setting all properties.
function yaw_2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to yaw_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit17_Callback(hObject, eventdata, handles)
% hObject    handle to edit17 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit17 as text
%        str2double(get(hObject,'String')) returns contents of edit17 as a double


% --- Executes on button press in triangle.
function cricular_Callback(hObject, eventdata, handles)
% hObject    handle to triangle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of triangle


% --- Executes on button press in linear.
function checkbox5_Callback(hObject, eventdata, handles)
% hObject    handle to linear (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of linear


% --- Executes on button press in exit.
function exit_Callback(hObject, eventdata, handles)
% hObject    handle to exit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
closereq();


% --- Executes on button press in clockwises.
function clockwises_Callback(hObject, eventdata, handles)
% hObject    handle to clockwises (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.counter.Value = 0;
% Hint: get(hObject,'Value') returns toggle state of clockwises


% --- Executes on button press in counter.
function counter_Callback(hObject, eventdata, handles)
% hObject    handle to counter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.clockwises.Value = 0;
% Hint: get(hObject,'Value') returns toggle state of counter



function theta5_Callback(hObject, eventdata, handles)
% hObject    handle to theta5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of theta5 as text
%        str2double(get(hObject,'String')) returns contents of theta5 as a double


% --- Executes during object creation, after setting all properties.
function theta5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to theta5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function theta5_22_Callback(hObject, eventdata, handles)
% hObject    handle to theta5_22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of theta5_22 as text
%        str2double(get(hObject,'String')) returns contents of theta5_22 as a double


% --- Executes during object creation, after setting all properties.
function theta5_22_CreateFcn(hObject, eventdata, handles)
% hObject    handle to theta5_22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function theta6_Callback(hObject, eventdata, handles)
% hObject    handle to theta6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of theta6 as text
%        str2double(get(hObject,'String')) returns contents of theta6 as a double


% --- Executes during object creation, after setting all properties.
function theta6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to theta6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function theta6_22_Callback(hObject, eventdata, handles)
% hObject    handle to theta6_22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of theta6_22 as text
%        str2double(get(hObject,'String')) returns contents of theta6_22 as a double


% --- Executes during object creation, after setting all properties.
function theta6_22_CreateFcn(hObject, eventdata, handles)
% hObject    handle to theta6_22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
