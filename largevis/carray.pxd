import numpy as np
cimport numpy as np
np.import_array()

cdef np.ndarray to_ndarray(float* array, int size)
