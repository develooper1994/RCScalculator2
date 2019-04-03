from RCSRangeCommon import *
from ToDb import *


def RCSRangeCommonToDb(a=None, RangeFreqThetaPhi=None, newteta=None, newphi=None, newfrequency=None, *args, **kwargs):
    RCS = False  # RCSRangeCommonToDb.m:5
    if RangeFreqThetaPhi > 1:
        RCS = True  # RCSRangeCommonToDb.m:7

    freq, Nphi, Nteta, Nfreq, EEVV, EEHH = RCSRangeCommon(a, RCS)  # RCSRangeCommonToDb.m:9

    dB_VVt, dB_HHt, s1, s2 = ToDb(EEVV, EEHH, RangeFreqThetaPhi, newteta, newphi, newfrequency, a, Nphi, Nteta, Nfreq)  # RCSRangeCommonToDb.m:11
    return freq, Nphi, Nteta, Nfreq, EEVV, EEHH, dB_VVt, dB_HHt, s1, s2
