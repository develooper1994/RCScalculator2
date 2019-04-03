function [dB_VV, dB_HH, s1, s2] = ToDb(EEVV, EEHH,RangeFreqThetaPhi,newteta,newphi,newfrequency,a,Nphi,Nteta,Nfreq) %#codegen
%ToDb RangeProfile, RCS_vs_Freq, RCS_vs_Theta and RCS_vs_Phi
% E_VV, E_HH, E_VVt, E_HHt converts to db
% EEVV, EEHH comes from "[a, freq, EEVV, EEHH] = RCSRangeCommon(dosyaAdi)" function
% RangeFreqThetaPhi is switch between mods.
if nargin<4
    newteta = 1;
elseif nargin<5
    newphi = 1;
elseif nargin<6
    newfrequency = 1;
end
if coder.target('Matlab')
    if RangeFreqThetaPhi>5 && RangeFreqThetaPhi<1
        error('RangeFreqThetaPhi: 1->RangeProfile\n2->RCS_vs_Freq\n3->RCS_vs_Theta\n4->RCS_vs_Phi')
    end
end

if RangeFreqThetaPhi == 1
    % RangeProfile
    E_VV=EEVV(:,newteta,newphi);
    E_VVt=fft(E_VV);
    dB_VVtt = todbsmall(E_VVt); % dB_VVt
    dB_VV = fftshift(dB_VVtt);
    
    E_HH=EEHH(:,newteta,newphi);
    E_HHt=fft(E_HH);
    dB_HHtt = todbsmall(E_HHt); % dB_HHt
    dB_HH = fftshift(dB_HHtt);
    
    s1=a(1:Nphi,3);
    s2=a(1:Nphi:Nteta*Nphi,2);
elseif RangeFreqThetaPhi == 2
    % RCS_vs_Freq
    E_VV=EEVV(:,newteta,newphi);
    dB_VV = todbsmall(E_VV);
    
    E_HH=EEHH(:,newteta,newphi);
    dB_HH = todbsmall(E_HH);
    
    s1=a(1:Nphi,3);
    s2=a(1:Nphi:Nteta*Nphi,2);
elseif RangeFreqThetaPhi == 3
    %RCS_vs_Theta
    E_VV=EEVV(newfrequency,:,newphi);
    dB_VV = todbsmall(E_VV);
    
    E_HH=EEHH(newfrequency,:,newphi);
    dB_HH = todbsmall(E_HH);
    
    s1=a(1:Nphi*Nteta:Nfreq*Nteta*Nphi,1);
    s2=a(1:Nphi,3);
elseif RangeFreqThetaPhi == 4
    % RCS_vs_Phi
    E_VV=EEVV(newfrequency,newteta,:);
    dB_VV = todbsmall(E_VV);
    dB_VV = dB_VV(1,:);
    
    E_HH=EEHH(newfrequency,newteta,:);
    dB_HH = todbsmall(E_HH);
    dB_HH = dB_HH(1,:);
    
    s1=a(1:Nphi*Nteta:Nfreq*Nteta*Nphi,1);
    s2=a(1:Nphi:Nteta*Nphi,2);
else % error contidition
    dB_VV = 0; dB_HH = 0; s1= 0; s2 = 0;
end



end

