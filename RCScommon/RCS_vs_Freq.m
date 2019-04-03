function RCS_vs_Freq(dosyaAdi)
newphi=1;
setappdata(0,'newphi',newphi);
newteta = 1;
setappdata(0,'newteta',newteta);

%% RCSRangeCommonToDb
a=load(dosyaAdi);
RangeFreqThetaPhi = 2;
[freq, Nphi, Nteta, Nfreq, EEVV, EEHH, dB_VV, dB_HH, s1, s2] = RCSRangeCommonToDb_mex(a,RangeFreqThetaPhi,newteta,newphi,1);

%% dB plot
% Hepsinde ayný
scrsize=get(0,'ScreenSize');
figure;
% pause(0.00001);
frame_h = get(handle(gcf),'JavaFrame');
set(frame_h,'Maximized',1);

dBPlot(freq, dB_VV, dB_HH, RangeFreqThetaPhi);

%% UI control
% Add a text uicontrol to label the slider.
yposition=scrsize(4)*0.75;
uicontrol('Style','text', 'Position',[35 yposition 100 50], 'FontName', 'Arial', 'FontSize',12,'FontWeight', 'Bold','String','Phi [Degree]');
% Create pop-up menu
uicontrol('Style', 'popup', 'String', {s1}, 'Position', [35 yposition-25 115 50],'FontName', 'Arial', 'FontSize',12,'FontWeight', 'Bold', 'Callback', @setphi);

    function setphi(source,~)
        val_phi = source.Value;
        newphi = val_phi;
        setappdata(0,'newphi',newphi);
        newteta=getappdata(0,'newteta');
        
        [dB_VV, dB_HH, ~] = ToDb_mex(EEVV, EEHH,RangeFreqThetaPhi,newteta,newphi,1,a,Nphi,Nteta,Nfreq);
        
        % dB plot
        dBPlot(freq, dB_VV, dB_HH, RangeFreqThetaPhi);
    end

%% Add a text uicontrol to label the slider.
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
        newteta =   val_teta;
        setappdata(0,'newteta',newteta);
        newphi=getappdata(0,'newphi');
        
        [dB_VV, dB_HH, ~] = ToDb_mex(EEVV, EEHH,RangeFreqThetaPhi,newteta,newphi,1,a,Nphi,Nteta,Nfreq);
        
        % dB plot
        dBPlot(freq, dB_VV, dB_HH, RangeFreqThetaPhi);
    end
end