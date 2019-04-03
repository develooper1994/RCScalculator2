from PyQt5.QtWidgets import QApplication
import sys


from RangeProfile import RangeProfileApplicationWindow
from RCS_vs_Freq import  RCS_vs_FreqApplicationWindow


if __name__ == "__main__":
    Filename = 'v1newTET75Phi45.rka.out2'
    app = QApplication(sys.argv)
    #ex = RangeProfileApplicationWindow()
    ex = RCS_vs_FreqApplicationWindow()

    sys.exit(app.exec_())



    ## RangeProfile
    #RangeProfile(Filename)
    ## RCS_vs_Freq
    #RCS_vs_Freq(Filename)
    ## RCS_vs_Phi
    #RCS_vs_Phi(Filename)
    ## RCS_vs_Theta
    #RCS_vs_Theta(Filename)