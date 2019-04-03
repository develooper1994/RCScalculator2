function RCS_vs_Phi(dosyaAdi)
newfrequency = 1;
setappdata(0,'newfrequency',newfrequency);
newteta = 1;
setappdata(0,'newteta',newteta);

%% RCSRangeCommonToDb
a=load(dosyaAdi);
RangeFreqThetaPhi = 4;
[~, Nphi, Nteta, Nfreq, EEVV, EEHH, dB_VV, dB_HH, s1, s2] = RCSRangeCommonToDb_mex(a,RangeFreqThetaPhi,newteta,1,newfrequency);
tet1=a(1:Nphi,3)';

%% dB plot
% Hepsinde ayný
scrsize=get(0,'ScreenSize');
figure;
% pause(0.00001);
frame_h = get(handle(gcf),'JavaFrame');
set(frame_h,'Maximized',1);

dBPlot(tet1, dB_VV, dB_HH, RangeFreqThetaPhi);

%% UI control
% Add a text uicontrol to label the slider.
yposition=scrsize(4)*0.75;
uicontrol('Style','text',...
    'Position',[35 yposition 140 50],'FontName', 'Arial', 'FontSize',12,'FontWeight', 'Bold',...
    'String', 'Frequency [GHz]');
% Create pop-up menu
uicontrol('Style', 'popup', 'String', {s1},...
    'Position', [35 yposition-25 115 50],'FontName', 'Arial', 'FontSize',12,'FontWeight', 'Bold',...
    'Callback', @setfrequency);

    function setfrequency(source,~)
        val_freq= source.Value;
        newfrequency=  val_freq;
        setappdata(0,'newfrequency',newfrequency);
        newteta=getappdata(0,'newteta');
        
        [dB_VV, dB_HH, ~] = ToDb_mex(EEVV, EEHH,RangeFreqThetaPhi,newteta,1,newfrequency,a,Nphi,Nteta,Nfreq);
        
        % dB plot
        dBPlot(tet1, dB_VV, dB_HH, RangeFreqThetaPhi);
    end




uicontrol('Style','text',...
    'Position',[35 yposition-90 115 50],'FontName', 'Arial', 'FontSize',12,'FontWeight', 'Bold',...
    'String','Theta [Degree]');
% Create pop-up menu
uicontrol('Style', 'popup',...
    'String', {s2},...
    'Position',[35 yposition-115 115 50],'FontName', 'Arial', 'FontSize',12,'FontWeight', 'Bold',...
    'Callback', @setteta);

    function setteta(source,~)
        val_teta= source.Value;
        newteta = val_teta;
        setappdata(0,'newteta',newteta);
        newfrequency=getappdata(0,'newfrequency');
        
        [dB_VV, dB_HH, ~] = ToDb_mex(EEVV, EEHH,RangeFreqThetaPhi,newteta,1,newfrequency,a,Nphi,Nteta,Nfreq);
        
        % dB plot
        dBPlot(tet1, dB_VV, dB_HH, RangeFreqThetaPhi);
    end

figure;
% pause(0.00001);
frame_h = get(handle(gcf),'JavaFrame');
set(frame_h,'Maximized',1);

maxV=5*ceil(max(dB_VV)/5);
maxH=5*ceil(max(dB_HH)/5);
dr=60;
maxHdr3 = [maxH maxH-dr 3];
maxVdr3 = [maxV maxV-dr 3];

ax1 = subplot(121);
set(gca,'FontName', 'Arial', 'FontSize',12,'FontWeight', 'Bold');
title(ax1,'Radar Cross Section (VV pol.)','Color','b')
xlabel(ax1,'Angle , \phi  [Degree]');
if (isinf(dB_VV))
    polar(ax1, 0,0);
else
    dirplot(tet1,dB_VV,'b', maxVdr3);
end
ax2 = subplot(122);
set(gca,'FontName', 'Arial', 'FontSize',12,'FontWeight', 'Bold');
title(ax2,'Radar Cross Section (HH pol.)','Color','r')
xlabel(ax2,'Angle , \phi  [Degree]');
if (isinf(dB_HH))
    polar(ax1, 0,0);
else
    dirplot(tet1,dB_HH,'r', maxHdr3);
end

%% Add a text uicontrol to label the slider.
uicontrol('Style','text',...
    'Position',[35 yposition 140 50],'FontName', 'Arial', 'FontSize',12,'FontWeight', 'Bold',...
    'String','Frequency [GHz]');
% Create pop-up menu
uicontrol('Style', 'popup',...
    'String', {s1},...
    'Position', [35 yposition-25 115 50],'FontName', 'Arial', 'FontSize',12,'FontWeight', 'Bold',...
    'Callback', @setfrequency1);

    function setfrequency1(source,~)
        val_freq= source.Value;
        newfrequency=  val_freq;
        setappdata(0,'newfrequency',newfrequency);
        newteta=getappdata(0,'newteta');

        [dB_VV, dB_HH, ~] = ToDb_mex(EEVV, EEHH,RangeFreqThetaPhi,newteta,1,newfrequency,a,Nphi,Nteta,Nfreq);
        maxV=5*ceil(max(dB_VV)/5);
        maxH=5*ceil(max(dB_HH)/5);
        dr=60;
        maxHdr3 = [maxV maxV-dr 3];
        maxVdr3 = [maxV maxV-dr 3];

        ax1 = subplot(121);
        set(gca,'FontName', 'Arial', 'FontSize',12,'FontWeight', 'Bold');
        title(ax1,'Radar Cross Section (VV pol.)','Color','b')
        xlabel(ax1,'Angle , \phi  [Degree]');
        if (isinf(dB_VV))
           polar(ax1, 0,0);
        else
            dirplot(tet1,dB_VV,'b', maxVdr3);
        end
        ax2 = subplot(122);
        set(gca,'FontName', 'Arial', 'FontSize',12,'FontWeight', 'Bold');
        title(ax2,'Radar Cross Section (HH pol.)','Color','r')
        xlabel(ax2,'Angle , \phi  [Degree]');
        if (isinf(dB_HH))
            polar(0,0);
        else
            dirplot(tet1,dB_HH,'r', maxHdr3);
        end
    end

uicontrol('Style','text',...
    'Position',[35 yposition-90 115 50],'FontName', 'Arial', 'FontSize',12,'FontWeight', 'Bold',...
    'String','Theta [Degree]');

% Create pop-up menu
uicontrol('Style', 'popup',...
    'String', {s2},...
    'Position',[35 yposition-115 115 50],'FontName', 'Arial', 'FontSize',12,'FontWeight', 'Bold',...
    'Callback', @setteta2);

    function setteta2(source,~)
        val_teta= source.Value;
        newteta = val_teta;
        setappdata(0,'newteta',newteta);
        newfrequency=getappdata(0,'newfrequency');

        [dB_VV, dB_HH, ~] = ToDb_mex(EEVV, EEHH,RangeFreqThetaPhi,newteta,1,newfrequency,a,Nphi,Nteta,Nfreq);
        maxV=5*ceil(max(dB_VV)/5);
        maxH=5*ceil(max(dB_HH)/5);
        dr=60;
        maxHdr3 = [maxH maxH-dr 3];
        maxVdr3 = [maxV maxV-dr 3];

        ax1 = subplot(121);
        set(gca,'FontName', 'Arial', 'FontSize',12,'FontWeight', 'Bold');
        title(ax1,'Radar Cross Section (VV pol.)','Color','b');
        xlabel(ax1,'Angle , \phi  [Degree]');
        if (isinf(dB_VV))
            polar(0,0);
        else
            dirplot(tet1,dB_VV,'b', maxVdr3);
        end
        ax2 = subplot(122);
        set(gca,'FontName', 'Arial', 'FontSize',12,'FontWeight', 'Bold');
        title(ax2,'Radar Cross Section (HH pol.)','Color','r');
        xlabel(ax2,'Angle , \phi  [Degree]');
        if (isinf(dB_HH))
            polar(0,0);
        else
            dirplot(tet1,dB_HH,'r', maxHdr3);
        end
    end


end