%%%%%%%%%%%%%%%%%%%%%read images 6/22/16%%%%%%%%%%%%%%%%%%%%%%

clear all
clc

addpath('C:\Users\Robin Tan\Documents\Robin Tan\2016 ASE');
addpath('C:\Users\Robin Tan\Documents\Robin Tan\2016 ASE\HandshakeLabeled');

for i = 1:400
%%Find Label Files
    
handshake = imread(sprintf('handshake%s.jpg',num2str(i)));

hstext = fileread(['handshake' num2str(i) '.labl']);
textsplit = strsplit(hstext, '|');
if numel(textsplit) ~= 18
    display([ num2str(i) ' is bad']);
    continue;
end
dtextsplit = str2double(textsplit);

ind = find(dtextsplit == 0);
if ~isempty(ind)
    dtextsplit(ind) = dtextsplit(ind) + 1;
end

%%Out of Bounds

if dtextsplit(5) + dtextsplit(7) > dtextsplit(2)
    dtextsplit(7) = dtextsplit(7) - 1;
end
if dtextsplit(9) + dtextsplit(11) > dtextsplit(2)
    dtextsplit(11) = dtextsplit(11) - 1;
end
if dtextsplit(13) + dtextsplit(15) > dtextsplit(2)
    dtextsplit(15) = dtextsplit(15) - 1;
end
if dtextsplit(4) + dtextsplit(6) > dtextsplit(1)
    dtextsplit(6) = dtextsplit(6) - 1;
end
if dtextsplit(8) + dtextsplit(10) > dtextsplit(1)
    dtextsplit(10) = dtextsplit(10) - 1;
end
if dtextsplit(12) + dtextsplit(14) > dtextsplit(1)
    dtextsplit(14) = dtextsplit(14) - 1;
end

%%Generate Crops

p1crop = handshake(dtextsplit(5):dtextsplit(5)+dtextsplit(7),dtextsplit(4):dtextsplit(4)+dtextsplit(6),:);
p2crop = handshake(dtextsplit(9):dtextsplit(9)+dtextsplit(11),dtextsplit(8):dtextsplit(8)+dtextsplit(10),:);
p3crop = handshake(dtextsplit(13):dtextsplit(13)+dtextsplit(15),dtextsplit(12):dtextsplit(12)+dtextsplit(14),:);

%% first box%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if strcmp(textsplit(16), 'person-my-left') == 1
cd('C:\Users\Robin Tan\Documents\Robin Tan\2016 ASE\HandshakeLabeled\personmyleft');
imwrite(p1crop,['hs' num2str(i) 'person-my-left.jpg']);
cd('C:\Users\Robin Tan\Documents\Robin Tan\2016 ASE\HandshakeLabeled');
end

if strcmp(textsplit(16), 'person-my-right') == 1
cd('C:\Users\Robin Tan\Documents\Robin Tan\2016 ASE\HandshakeLabeled\personmyright');
imwrite(p1crop,['hs' num2str(i) 'person-my-right.jpg']);
cd('C:\Users\Robin Tan\Documents\Robin Tan\2016 ASE\HandshakeLabeled');
end

if strcmp(textsplit(16), 'handshake') == 1
cd('C:\Users\Robin Tan\Documents\Robin Tan\2016 ASE\HandshakeLabeled\handshake');
imwrite(p1crop,['hs' num2str(i) 'handshake.jpg']);
cd('C:\Users\Robin Tan\Documents\Robin Tan\2016 ASE\HandshakeLabeled');
end

%%second box%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if strcmp(textsplit(17), 'person-my-left') == 1
cd('C:\Users\Robin Tan\Documents\Robin Tan\2016 ASE\HandshakeLabeled\personmyleft');
imwrite(p2crop,['hs' num2str(i) 'person-my-left.jpg']);
cd('C:\Users\Robin Tan\Documents\Robin Tan\2016 ASE\HandshakeLabeled');
end

if strcmp(textsplit(17), 'person-my-right') == 1
cd('C:\Users\Robin Tan\Documents\Robin Tan\2016 ASE\HandshakeLabeled\personmyright');
imwrite(p2crop,['hs' num2str(i) 'person-my-right.jpg']);
cd('C:\Users\Robin Tan\Documents\Robin Tan\2016 ASE\HandshakeLabeled');
end

if strcmp(textsplit(17), 'handshake') == 1
cd('C:\Users\Robin Tan\Documents\Robin Tan\2016 ASE\HandshakeLabeled\handshake');
imwrite(p2crop,['hs' num2str(i) 'handshake.jpg']);
cd('C:\Users\Robin Tan\Documents\Robin Tan\2016 ASE\HandshakeLabeled');
end

%%thirdbox%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if strcmp(textsplit(18), 'person-my-left') == 1
cd('C:\Users\Robin Tan\Documents\Robin Tan\2016 ASE\HandshakeLabeled\personmyleft');
imwrite(p3crop,['hs' num2str(i) 'person-my-left.jpg']);
cd('C:\Users\Robin Tan\Documents\Robin Tan\2016 ASE\HandshakeLabeled');
end

if strcmp(textsplit(18), 'person-my-right') == 1
cd('C:\Users\Robin Tan\Documents\Robin Tan\2016 ASE\HandshakeLabeled\personmyright');
imwrite(p3crop,['hs' num2str(i) 'person-my-right.jpg']);
cd('C:\Users\Robin Tan\Documents\Robin Tan\2016 ASE\HandshakeLabeled');
end

if strcmp(textsplit(18), 'handshake') == 1
cd('C:\Users\Robin Tan\Documents\Robin Tan\2016 ASE\HandshakeLabeled\handshake');
imwrite(p3crop,['hs' num2str(i) 'handshake.jpg']);
cd('C:\Users\Robin Tan\Documents\Robin Tan\2016 ASE\HandshakeLabeled');
end


end
