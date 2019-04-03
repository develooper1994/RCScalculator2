import numpy as np


def SwitchToRange(freq: object = None) -> object:
    dr = 0.3 / (2 * (np.max(freq) - np.min(freq)))  # SwitchToRange.m:5
    n: int = np.size(freq)  # SwitchToRange.m:6
    r = np.arange(0, dr * n, dr)  # SwitchToRange.m:7
    r: None = r * 100  # SwitchToRange.m:8

    rr: None = r - np.mean(r)  # SwitchToRange.m:9
    return rr
