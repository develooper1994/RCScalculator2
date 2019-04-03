from RCSRangeCommonToDb import RCSRangeCommonToDb
from dBPlot import dBPlot
from ToDb import ToDb

import numpy as np
import matplotlib
import matplotlib.pylab as plt

# matplotlib.use('qt5agg')

from PyQt5.QtWidgets import QApplication, QMainWindow, QMenu, QVBoxLayout, QSizePolicy, QMessageBox, QWidget, \
    QPushButton
# from PyQt5.QtGui import QIcon

from matplotlib.backends.backend_qt5agg import FigureCanvasQTAgg as FigureCanvas
from matplotlib.figure import Figure


class RCS_vs_FreqApplicationWindow(QMainWindow):
    def __init__(self):
        super().__init__()
        self.left = 10
        self.top = 10
        self.title = 'PyQt5 matplotlib'
        self.width = 640
        self.height = 400
        self.initUI()

    def initUI(self):
        self.setWindowTitle(self.title)
        self.setGeometry(self.left, self.top, self.width, self.height)

        m = PlotCanvas(self, width=5, height=4)
        m.move(0, 0)

        button = QPushButton('PyQt5 button', self)
        button.setToolTip('This s an example button')
        button.move(500, 0)
        button.resize(140, 100)

        self.show()


class PlotCanvas(FigureCanvas):
    def __init__(self, parent=None, width=5, height=4, dpi=100):
        self.fig = Figure(figsize=(width, height), dpi=dpi)
        # self.axes = self.fig.add_subplot(111)

        FigureCanvas.__init__(self, self.fig)
        self.setParent(parent)

        FigureCanvas.setSizePolicy(self, QSizePolicy.Fixed, QSizePolicy.Fixed)
        FigureCanvas.updateGeometry(self)

        Filename = 'v1newTET75Phi45.rka.out2'
        self.RCS_vs_Freq(Filename)

    def RCS_vs_Freq(self, dosya_adi):
        newphi: int = 1
        newteta: int = 1

        ## RCSRangeCommonToDb
        a = np.loadtxt(dosya_adi, skiprows=0)
        RangeFreqThetaPhi: int = 2
        freq, Nphi, Nteta, Nfreq, EEVV, EEHH, dB_VVt, dB_HHt, s1, s2 = RCSRangeCommonToDb(a, RangeFreqThetaPhi, newteta,
                                                                                          newphi, 1)

        ## dBplot
        #fig = plt.figure()
        dBPlot(freq, dB_VVt, dB_HHt, RangeFreqThetaPhi, self.fig)

        def setphi(source, _):
            val_phi = source.Value
            newphi = val_phi

            RangeFreqThetaPhi: int = 1
            dB_VVt, dB_HHt, _ = ToDb(EEVV, EEHH, RangeFreqThetaPhi, newteta, newphi, 1, a, Nphi, Nteta, Nfreq)

            # dB plot
            dBPlot(freq, dB_VVt, dB_HHt, RangeFreqThetaPhi, self.fig)

        def setteta(source, _):
            val_teta = source.Value
            newteta = val_teta

            RangeFreqThetaPhi = 1

            # [dB_VVt, dB_HHt] = ToDb(EEVV, EEHH, RangeFreqThetaPhi)
            dB_VVt, dB_HHt, _ = ToDb(EEVV, EEHH, RangeFreqThetaPhi, newteta, 1, 1, a, Nphi, Nteta, Nfreq);

            dBPlot(freq, dB_VVt, dB_HHt, RangeFreqThetaPhi, self.fig)

        # not very good solution with backend change but it works. it should least 200ms
        # plt.pause(2)  # matplotlib run on backend thread. So main thread have to wait until sync finished
        self.draw()
