import multiprocessing

def get_n_jobs(n_jobs):
    """get_n_jobs.

    Determine the number of jobs which are going to run in parallel.
    This is the same function used by joblib in the PoolManager backend.
    """
    if n_jobs == 0:
        raise ValueError('n_jobs == 0 in Parallel has no meaning')
    elif n_jobs is None:
        return 1
    elif n_jobs < 0:
        n_jobs = max(multiprocessing.cpu_count() + 1 + n_jobs, 1)
    return n_jobs
