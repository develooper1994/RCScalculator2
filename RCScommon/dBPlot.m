function dBPlot(XX, dB_VV,dB_HH,RangeFreqThetaPhi)

if coder.target('Matlab')
    if RangeFreqThetaPhi>5 && RangeFreqThetaPhi<1
        error('RangeFreqThetaPhi: 1->RangeProfile\n2->RCS_vs_Freq\n3->RCS_vs_Theta\n4->RCS_vs_Phi')
    end
end

% Hepsinde ayný
ax1 = subplot(211);
plot(ax1,XX,dB_VV,'b','LineWidth',2,'Marker', 'd');
set(gca,'FontName', 'Arial', 'FontSize',12,'FontWeight', 'Bold');
axis tight; grid on
ax2 = subplot(212);
plot(ax2,XX,dB_HH,'r','LineWidth',2,'Marker', 'd');
set(gca,'FontName', 'Arial', 'FontSize',12,'FontWeight', 'Bold');
axis tight; grid on

if RangeFreqThetaPhi == 1
    % RangeProfile; XX=RR; dB_VV = dB_VVt; dB_HH = dB_HHt
    xlabelSTR = 'Range [cm]';
    xlabel(ax1,xlabelSTR)
    xlabel(ax2,xlabelSTR)
elseif RangeFreqThetaPhi == 2
    % RCS_vs_Freq; XX=freq
    xlabelSTR = 'Frequency [GHz]';
    xlabel(ax1,xlabelSTR)
    xlabel(ax2,xlabelSTR)
elseif RangeFreqThetaPhi == 3
    %RCS_vs_Theta; XX=tet1
    xlabelSTR = 'Angle , \theta  [Degree]';
    xlabel(ax1,xlabelSTR)
    xlabel(ax2,xlabelSTR)
elseif RangeFreqThetaPhi == 4
    % RCS_vs_Phi; XX=tet1; dB_VV = dB_VV(1,:); dB_HH = dB_HH(1,:);
    xlabelSTR = 'Angle , \phi  [Degree]';
    xlabel(ax1,xlabelSTR)
    xlabel(ax2,xlabelSTR)
end

title(ax1,'Radar Cross Section (VV pol.)','Color','b')
ylabel (ax1,'RCS[dBsm]')

title(ax2,'Radar Cross Section (HH pol.)','Color','r')
ylabel (ax2,'RCS[dBsm]')

end

