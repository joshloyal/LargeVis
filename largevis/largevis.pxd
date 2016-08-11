import numpy as np
cimport numpy as np
np.import_array()


ctypedef float real

cdef extern from "LargeVis.h":
    cdef cppclass CLargeVis "LargeVis":
        void load_from_data(real* data, long long n_vert, long long_di) nogil
        void run(long long out_d, long long n_thre, long long n_samp, long long n_prop, real alpha, long long n_tree, long long n_nega, long long n_neig, real gamm, real perp) nogil
        real* get_ans()


cdef class LargeVis:
    cdef readonly int n_components
    cdef readonly int batch_size
    cdef readonly int n_propagations
    cdef readonly float alpha
    cdef readonly int n_trees
    cdef readonly int n_negatives
    cdef readonly int n_neighbors
    cdef readonly float gamma
    cdef readonly float perplexity
    cdef readonly int n_jobs
    cdef CLargeVis* model
