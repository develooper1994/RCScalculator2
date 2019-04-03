import matplotlib.pyplot as plt
import matplotlib as mpl


def dBPlot(xx: object, dB_VV: object, dB_HH: object, range_freq_theta_phi: object, fig: object) -> object:
    if 5 < range_freq_theta_phi < 1:
        import sys
        print('range_freq_theta_phi: 1->RangeProfile\n2->RCS_vs_Freq\n3->RCS_vs_Theta\n4->RCS_vs_Phi',
              file=sys.stderr)  # matlab error

    # Hepsinde aynı
    # fig = plt.figure()
    fig.suptitle("dBPlot", fontsize=16)
    ax1 = fig.add_subplot(211)
    ax1.plot(xx, dB_VV, 'b', linewidth=2, marker='d')
    # set(gca, 'FontName', 'Arial', 'FontSize', 12, 'FontWeight', 'Bold')
    ax1.axis()
    ax1.grid(b=True)
    ax2 = fig.add_subplot(212)
    ax2.plot(xx, dB_HH, 'r', linewidth=2, marker='d')
    # set(gca, 'FontName', 'Arial', 'FontSize', 12, 'FontWeight', 'Bold')
    font = {'family': 'normal',
            'weight': 'bold',
            'size': 12}
    mpl.rc('font', **font)
    ax2.axis()
    plt.tight_layout()  # may not work
    ax2.grid(b=True)

    if range_freq_theta_phi == 1:
        # RangeProfile XX = RR; dB_VV = dB_VVt; dB_HH = dB_HHt
        ax1.set_title('Range Profile (VV Pol.)', color='b')
        ax1.set_xlabel('Range [cm]')
        ax1.set_ylabel('[dBsm]')

        ax2.set_title('Range Profile (HH Pol.)', color='r')
        ax2.set_xlabel('Range [cm]')
        ax2.set_ylabel('[dBsm]')
    elif range_freq_theta_phi == 2:
        # RCS_vs_Freq; XX = freq
        ax1.set_title('Radar Cross Section (VV pol.)', color='b')
        ax1.set_xlabel('Frequency [GHz]')
        ax1.set_ylabel('RCS [dBsm]')

        ax2.set_title('Radar Cross Section (HH pol.)', color='r')
        ax2.set_xlabel('Frequency [GHz]')
        ax2.set_ylabel('RCS [dBsm]')
    elif range_freq_theta_phi == 3:
        # RCS_vs_Theta; XX = tet1
        ax1.set_title('Radar Cross Section (VV pol.)', color='b')
        ax1.set_xlabel('Angle , theta  [Degree]')
        ax1.set_ylabel('RCS[dBsm]')

        ax2.set_title('Radar Cross Section (HH pol.)', color='r')
        ax2.set_xlabel('Angle  , theta  [Degree]')
        ax2.set_ylabel('RCS[dBsm]')
    elif range_freq_theta_phi == 4:
        # RCS_vs_Phi; XX = tet1; dB_VV = dB_VV[0, :]; dB_HH = dB_HH[0, :]
        ax1.set_title('Radar Cross Section (VV pol.)', color='b')
        ax1.set_xlabel('Angle , phi  [Degree]')
        ax1.set_ylabel('RCS[dBsm]')

        ax2.set_title('Radar Cross Section (HH pol.)', color='r')
        ax2.set_xlabel('Angle  , phi  [Degree]')
        ax2.set_ylabel('RCS[dBsm]')
