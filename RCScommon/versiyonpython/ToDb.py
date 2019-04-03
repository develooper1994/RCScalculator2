# from libsmop import * # bu modülü kaldırmak için düzenlemeyle numpy fonksiyonlarıyla değiştir.
from todbsmall import todbsmall

import numpy as np
from numpy.core._multiarray_umath import ndarray


def ToDb(eevv: ndarray = None, eehh: ndarray = None, range_freq_theta_phi: int = None, newteta: int = 1, newphi: int = 1,
         newfrequency: int = 1, a: ndarray = None, Nphi: int = None, Nteta: int = None, Nfreq: int = None) -> tuple:
    # ToDb RangeProfile, RCS_vs_Freq, RCS_vs_Theta and RCS_vs_Phi
    # e_vv, e_hh, E_VVt, E_HHt converts to db
    # eevv, eehh comes from "[a, freq, eevv, eehh] = RCSRangeCommon(dosyaAdi)" function
    # range_freq_theta_phi is switch between mods.
    if 5 < range_freq_theta_phi < 1:
        import sys
        print('range_freq_theta_phi: 1->RangeProfile\n2->RCS_vs_Freq\n3->RCS_vs_Theta\n4->RCS_vs_Phi', file=sys.stderr)

    if range_freq_theta_phi == 1:
        # RangeProfile
        e_vv = eevv[:, newteta-1, newphi-1]  # ToDb.m:21
        E_VVt = np.fft.fft(e_vv)  # ToDb.m:22
        dB_VVtt = todbsmall(E_VVt)  # ToDb.m:23
        dB_VV = np.fft.fftshift(dB_VVtt)  # ToDb.m:24
        e_hh = eehh[:, newteta-1, newphi-1]  # ToDb.m:26
        E_HHt = np.fft.fft(e_hh)  # ToDb.m:27
        dB_HHtt = todbsmall(E_HHt)  # ToDb.m:28
        dB_HH = np.fft.fftshift(dB_HHtt)  # ToDb.m:29
        s1 = a[0: Nphi - 1, 2]  # ToDb.m:31
        s2 = a[0: Nteta * Nphi: Nphi - 1, 1]  # ToDb.m:32
    elif range_freq_theta_phi == 2:
        # RCS_vs_Freq
        e_vv = eevv[:, newteta-1, newphi-1]  # ToDb.m:35
        dB_VV = todbsmall(e_vv)  # ToDb.m:36
        e_hh = eehh[:, newteta-1, newphi-1]  # ToDb.m:38
        dB_HH = todbsmall(e_hh)  # ToDb.m:39
        s1 = a[0: Nphi-1, 2]  # ToDb.m:41
        s2 = a[0: Nteta * Nphi: Nphi, 1]  # ToDb.m:42
    elif range_freq_theta_phi == 3:
        # RCS_vs_Theta
        e_vv = eevv[newfrequency-1, :, newphi-1]  # ToDb.m:45
        dB_VV = todbsmall(e_vv)  # ToDb.m:46
        e_hh = eehh[newfrequency-1, :, newphi-1]  # ToDb.m:48
        dB_HH = todbsmall(e_hh)  # ToDb.m:49
        s1 = a[0: Nfreq * Nteta * Nphi: Nphi * Nteta, 0]  # ToDb.m:51
        s2 = a[0: Nphi-1, 2]  # ToDb.m:52
    elif range_freq_theta_phi == 4:
        # RCS_vs_Phi
        e_vv = eevv[newfrequency-1, newteta-1, :]  # ToDb.m:55
        dB_VV = todbsmall(e_vv)  # ToDb.m:56
        e_hh = eehh[newfrequency-1, newteta-1, :]  # ToDb.m:58
        dB_HH = todbsmall(e_hh)  # ToDb.m:59
        s1 = a[0: Nfreq * Nteta * Nphi: Nphi * Nteta, 0]  # ToDb.m:61
        s2 = a[0: Nteta * Nphi: Nphi, 1]  # ToDb.m:62
    return dB_VV, dB_HH, s1, s2
