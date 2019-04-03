function [freq, Nphi, Nteta, Nfreq, EEVV, EEHH] = RCSRangeCommon(a,RCS) %#codegen
%RCSRangeCommon RangeProfile, RCS_Freq, RCS_Phi ve RCS_theta ortak kodlar
% True if you want to calculate RCS function
% a=load(dosyaAdi);
freq=a(:,1);
%% Find #of freq and angles;
% Find frequencies
ff = diff(freq);
[n,~] = find(ff);
Nfreq = length(n)+1;
[M,~] = size(a);
Nstep = M/Nfreq;
freq = a(1:Nstep:M,1);

% Find thetas
tt = a(1:Nstep,2);
ttt = diff(tt);
[nt,~] = find(ttt);
Nteta = length(nt)+1;
[Mt,~] = size(tt);
Tstep = Mt/Nteta;

% Find phis
pp = a(1:Tstep,3);
ppp = diff(pp);
[np,~] = find(ppp);
Nphi= length(np)+1;

% RESULTS:
% Nfreq  :  # of frequencies
% Nteta  :  # of THETA
% Nphi   :  # of PHI
% freq   : frequency vector
% teta   : theta vector
% phi    : phi vector

%%
if nargin<2
    RCS = true;
end

if RCS
    EEHH_index = [6,7];
else
    EEHH_index = [10,11];
end

EEVV = zeros(Nfreq, Nteta, Nphi)+1i*ones(Nfreq, Nteta, Nphi); % complex memory space
EEHH = zeros(Nfreq, Nteta, Nphi)+1i*ones(Nfreq, Nteta, Nphi);

%original
% for mm=1:Nfreq
%     for nn=1:Nteta
%         for pp=1:Nphi % bu for döngüsünü azaltmayý dene. kodu vektörleþtir.
%             index=Nteta*Nphi*(mm-1)+Nphi*(nn-1)+pp;
%             EEVV(mm,nn,pp) = a(index,4)+1i*a(index,5);
%             EEHH(mm,nn,pp) = a(index,EEHH_index(1))+1i*a(index,EEHH_index(2));
%         end
%     end
% end


pp=1:Nphi;
for mm=1:Nfreq
    for nn=1:Nteta
        index = Nteta*Nphi*(mm-1)+Nphi*(nn-1)+pp;
        EEVV(mm,nn,pp) = a(index,4)+1i*a(index,5);
        EEHH(mm,nn,pp) = a(index,EEHH_index(1))+1i*a(index,EEHH_index(2));
    end
end






end