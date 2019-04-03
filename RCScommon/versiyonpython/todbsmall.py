import numpy as np


def todbsmall(E: object = None) -> object:
    rcs = 4 * np.pi * np.abs(E) ** 2  # todbsmall.m:2
    db = 10 * np.log10(rcs)  # todbsmall.m:3
    return db
