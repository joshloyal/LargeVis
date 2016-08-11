import numpy as np
cimport numpy as np
cimport carray
np.import_array()


from parallel import get_n_jobs


cdef class LargeVis:
    def __cinit__(self, n_components=2, batch_size=-1, n_propagations=-1,
                  alpha=-1, n_trees=-1, n_negatives=-1, n_neighbors=-1,
                  gamma=-1, perplexity=-1, n_jobs=-1):
        self.n_components = n_components
        self.batch_size = batch_size
        self.n_propagations = n_propagations
        self.alpha = alpha
        self.n_trees = n_trees
        self.n_negatives = n_negatives
        self.n_neighbors = n_neighbors
        self.gamma = gamma
        self.perplexity = perplexity
        self.n_jobs = n_jobs
        self.model = new CLargeVis()
        if self.model is NULL:
            raise MemoryError('Unable to initialize LargeVis model.')

    def __init__(self, n_components=2, batch_size=-1, n_propagations=-1,
                  alpha=-1, n_trees=-1, n_negatives=-1, n_neighbors=-1,
                  gamma=-1, perplexity=-1, n_jobs=-1):
        self.n_jobs = get_n_jobs(n_jobs)

    def __dealloc__(self):
        if self.model is not NULL:
            del self.model

    def fit_transform(self, np.ndarray[real, ndim=2, mode='c'] X):
        cdef long long n_samples = X.shape[0]
        cdef long long n_features = X.shape[1]
        cdef int output_size = n_samples * self.n_components
        cdef real* cembedding
        cdef np.ndarray embedding

        self.model.load_from_data(<real*> X.data, n_samples, n_features)
        self.model.run(self.n_components, self.n_jobs, self.batch_size,
                       self.n_propagations, self.alpha, self.n_trees,
                       self.n_negatives, self.n_neighbors, self.gamma,
                       self.perplexity)

        cembeddings = self.model.get_ans()
        embedding = carray.to_ndarray(cembedding, output_size)
        return embedding.reshape(n_samples, self.n_components)
