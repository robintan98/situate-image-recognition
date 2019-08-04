%%%%%%%%%%%%%%%%Aspect and Area Ratios Distribution%%%%%%%%%%%%%%%

clear all
clc


%%Read File and Split Text

%img-width|image-height|num-rects|x0|y0|w0|h0|x1|y1|w1|h1|label0|label1

textsplit_matrix = cell(320,18);

for i = 1:320
hstext = fileread(['handshake' num2str(i) '.labl']);
textsplit_temp = strsplit(hstext, '|');
textsplit_matrix(i,:) = textsplit_temp;
end

