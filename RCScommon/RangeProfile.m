function RangeProfile(dosyaAdi)
newphi = 1;
setappdata(0,'newphi',newphi);
newteta=1;
setappdata(0,'newteta',newteta);

%% RCSRangeCommonToDb
a=load(dosyaAdi);
RangeFreqThetaPhi = 1;
[freq, Nphi, Nteta, Nfreq, EEVV, EEHH, dB_VVt, dB_HHt, s1, s2] = RCSRangeCommonToDb_cumex(a, RangeFreqThetaPhi,newteta,newphi,1);
% swicht to range
RR = SwitchToRange_cumex(freq);

%% dB plot
% Hepsinde ayný
scrsize=get(0,'ScreenSize');
figure;
% pause(0.00001);
frame_h = get(handle(gcf),'JavaFrame');
set(frame_h,'Maximized',1);

dBPlot(RR, dB_VVt, dB_HHt, RangeFreqThetaPhi);

%% UI control
% Add a text uicontrol to label the slider.
yposition=scrsize(4)*0.75;
uicontrol('Style','text', 'Position',[35 yposition 100 50], 'FontName', 'Arial', 'FontSize',12,'FontWeight', 'Bold', 'String','Phi [Degree]');
% Create pop-up menu
uicontrol('Style', 'popup', 'String', {s1}, 'Position', [35 yposition-25 100 50],'FontName', 'Arial', 'FontSize',12,'FontWeight', 'Bold', 'Callback', @setphi);

    function setphi(source,~)
        newphi = source.Value;
        setappdata(0,'newphi',newphi);
        newteta=getappdata(0,'newteta');
        
        RangeFreqThetaPhi = 1;
        [dB_VVt, dB_HHt, ~] = ToDb_cumex(EEVV, EEHH,RangeFreqThetaPhi,newteta,newphi,1,a,Nphi,Nteta,Nfreq);
        % swicht to range
        RR = SwitchToRange_cumex(freq);
        
        % dB plot
        dBPlot(RR, dB_VVt, dB_HHt, RangeFreqThetaPhi);
    end


%% Add a text uicontrol to label the slider.
uicontrol('Style','text',...
    'Position',[35 yposition-90 115 50],'FontName', 'Arial', 'FontSize',12,'FontWeight', 'Bold',...
    'String','Theta [Degree]');

% Create pop-up menu
uicontrol('Style', 'popup',...
    'String', {s2},...
    'Position', [35 yposition-115 100 50],'FontName', 'Arial', 'FontSize',12,'FontWeight', 'Bold',...
    'Callback', @setteta);

    function setteta(source,~)
        newteta= source.Value;
        setappdata(0,'newteta',newteta);
        newphi=getappdata(0,'newphi');
        
        RangeFreqThetaPhi = 1;
        [dB_VVt, dB_HHt, ~] = ToDb(EEVV, EEHH,RangeFreqThetaPhi,newteta,newphi,1,a,Nphi,Nteta,Nfreq);
        % swicht to range
        RR = SwitchToRange(freq);
        
        dBPlot(RR, dB_VVt, dB_HHt, RangeFreqThetaPhi);
    end
end