######################################################################################################
#                             Statistical tests for Hydrology: 
#   MES = Mean Squared Error
#   NSE = Nash–Sutcliffe model efficiency coefficient
#   BS  = Brier Score
#   R2  = R^2
######################################################################################################

import numpy as np
from scipy.stats import gmean, rankdata

######################################################################################################
#                               Mean Squared Error
######################################################################################################
def MSE(simulated_array, observed_array):
    ""Mean Squred Error"""
    return np.mean((simulated_array - observed_array) ** 2)
