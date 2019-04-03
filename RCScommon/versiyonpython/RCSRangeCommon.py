from typing import Any, Union, List

import numpy
from numpy.core._multiarray_umath import ndarray # python index 0 matlab index 1 den baþlar.


def RCSRangeCommon(a: ndarray = None, RCS: bool = True) -> tuple:
    # RCSRangeCommon RangeProfile, RCS_Freq, RCS_Phi ve RCS_theta ortak kodlar
    # True if you want to calculate RCS function
    # a=load(dosyaAdi);
    a = numpy.array(a)
    freq = a[:, 0]  # RCSRangeCommon.m:5
    ## Find #of freq and angles;
    # Find frequencies
    ff = numpy.diff(freq)  # RCSRangeCommon.m:8
    n = numpy.flatnonzero(ff)  # RCSRangeCommon.m:9 # try numpy.transpose(np.nonzero(ff))
    nfreq: int = numpy.size(n) + 1  # RCSRangeCommon.m:10
    m, __ = a.shape  # RCSRangeCommon.m:11
    nstep: int = int(m / nfreq)  # RCSRangeCommon.m:12
    freq = a[0: m - 1: nstep, 0]  # RCSRangeCommon.m:13

    # Find thetas
    tt = a[0: nstep, 1]  # RCSRangeCommon.m:16
    ttt = numpy.diff(tt)  # RCSRangeCommon.m:17
    nt = numpy.flatnonzero(ttt)  # RCSRangeCommon.m:18
    nteta = nt.size + 1  # RCSRangeCommon.m:19
    mt = tt.shape  # RCSRangeCommon.m:20 # 1 dimensation
    tstep: int = int(mt[0] / nteta)  # RCSRangeCommon.m:21

    # Find phis
    pp = a[0:tstep, 2]  # RCSRangeCommon.m:26 # may tstep-1!!!
    ppp = numpy.diff(pp)  # RCSRangeCommon.m:27
    np: ndarray = numpy.flatnonzero(ppp)  # RCSRangeCommon.m:28
    nphi: int = np.size + 1  # RCSRangeCommon.m:29
    # RESULTS:
    # nfreq  :  # of frequencies
    # nteta  :  # of THETA
    # nphi   :  # of PHI
    # freq   : frequency vector
    # teta   : theta vector
    # phi    : phi vector

    if RCS:
        eehh_index: List[int] = [5, 6]  # RCSRangeCommon.m:49
    else:
        eehh_index: List[int] = [9, 10]  # RCSRangeCommon.m:51

    eevv = numpy.zeros([nfreq, nteta, nphi]) + 1j * numpy.ones([nfreq, nteta, nphi])  # RCSRangeCommon.m:54
    eehh = numpy.zeros([nfreq, nteta, nphi]) + 1j * numpy.ones([nfreq, nteta, nphi])  # RCSRangeCommon.m:55

    pp = numpy.arange(0, nphi)
    for mm in numpy.arange(0, nfreq):
        for nn in numpy.arange(0, nteta):
            index = nteta * nphi * mm + nphi * nn + pp  # RCSRangeCommon.m:59
            eevv[mm, nn, pp] = a[index, 3] + 1j * a[index, 4]  # RCSRangeCommon.m:60
            eehh[mm, nn, pp] = a[index, eehh_index[0]] + 1j * a[index, eehh_index[1]]  # RCSRangeCommon.m:61


#original
#    for mm in numpy.arange(1, nfreq).reshape(-1):
#        for nn in numpy.arange(1, nteta).reshape(-1):
#            for pp in numpy.arange(1, nphi).reshape(-1):
#                index = nteta * nphi * (mm - 1) + nphi * (nn - 1) + pp  # RCSRangeCommon.m:59
#                eevv[mm, nn, pp] = a[index, 4] + 1j * a[index, 5]  # RCSRangeCommon.m:60
#                eehh[mm, nn, pp] = a[index, eehh_index[0]] + 1j * a[index, eehh_index[1]]  # RCSRangeCommon.m:61

    return freq, nphi, nteta, nfreq, eevv, eehh
