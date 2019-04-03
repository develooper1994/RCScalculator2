function [freq, Nphi, Nteta, Nfreq, EEVV, EEHH, dB_VVt, dB_HHt, s1, s2] = RCSRangeCommonToDb(a, RangeFreqThetaPhi,newteta,newphi,newfrequency)  %#codegen

RCS = false;
if RangeFreqThetaPhi>1
    RCS = true;
end
[freq, Nphi, Nteta, Nfreq, EEVV, EEHH] = RCSRangeCommon(a,RCS);

[dB_VVt, dB_HHt, s1, s2] = ToDb(EEVV, EEHH,RangeFreqThetaPhi,newteta,newphi,newfrequency,a,Nphi,Nteta,Nfreq);

end

