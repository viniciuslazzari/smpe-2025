M2R-ParallelQuicksort
=====================

This small project aims at teaching 2nd year master students how to
improve their experimental methodology.

To explore the measurements interactively using Jupyter, follow these steps:

1. (Optional) Create and activate a Python virtual environment:

```zsh
python3 -m venv .venv
source .venv/bin/activate
```

2. Install dependencies from `requirements.txt`:

```zsh
pip install -U pip
pip install -r requirements.txt
```

3. Start Jupyter Lab or Notebook:

```zsh
jupyter lab
# or
jupyter notebook
```

4. In the browser, open the file `quicksort_analysis.ipynb` located at the repository root and run all cells (`Run -> Run All Cells`).

Outputs
-------

When executed, the notebook writes a consolidated CSV and other results under the `analysis_outputs/` directory.

If `requirements.txt` is not present or you want me to pin specific packages, tell me which packages/versions you prefer and I will update the file and the notebook accordingly.
