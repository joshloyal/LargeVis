import numpy as np

import largevis
from mysuper.datasets import fetch_10kdiabetes

#X = rng.randn(10, 10).astype(np.float32)
def test_largevis():
    X = fetch_10kdiabetes()
    X = X.values.astype(np.float32)
    X = np.ascontiguousarray(X)

    projection = largevis.LargeVis()
    embeddings = projection.fit_transform(X)
