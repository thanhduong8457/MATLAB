positive_ins = COOKER;
pos_dir = fullfile('C:\Users\ACER\Desktop\TGM\anh\positive');

addpath(pos_dir);
neg_dir = fullfile('C:\Users\ACER\Desktop\TGM\anh\negative');

trainCascadeObjectDetector('model3.xml', positive_ins, neg_dir,...
    'NumCascadeStages',12,'FalseAlarmRate',0.35);
