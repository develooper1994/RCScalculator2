function RR = SwitchToRange(freq)
%UNTÝTLED3 Summary of this function goes here
%   Detailed explanation goes here

dr=.3/(2*(max(freq)-min(freq)));
N=length(freq);
R=0:dr:dr*(N-1);
R=R*100; %centimeters
RR=R-mean(R);

end

