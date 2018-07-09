######################################################################################################
#                             Statistical tests for Hydrology: 
#   MES =  Mean Squared Error
#   RMSE = Root Mean Squared Error
#   NSE  = Nash–Sutcliffe model efficiency coefficient
#   BS   = Brier Score
#   R2   = R^2
######################################################################################################

import numpy as np
from scipy.stats import *

######################################################################################################
#                               Mean Squared Error
######################################################################################################
def MSE(simulated_array, observed_array):
    """Mean Squred Error"""
    return np.mean((simulated_array - observed_array) ** 2)


######################################################################################################
#                               Root Mean Squared Error
######################################################################################################    
def RMSE(simulated_array, observed_array):
    """Returns the Root mean squared error"""
    return np.sqrt(np.mean((simulated_array - observed_array) ** 2))
        
######################################################################################################
#                              Nash–Sutcliffe model efficiency coefficient
######################################################################################################

######################################################################################################
#                              R^2 Coefficient
######################################################################################################
def r_squared(simulated_array, observed_array):
    """R^2 - linear correlation between two datasets."""
    a = observed_array - np.mean(observed_array)
    b = simulated_array - np.mean(simulated_array)
    return (np.sum(a * b)) ** 2 / (np.sum(a ** 2) * np.sum(b ** 2))





