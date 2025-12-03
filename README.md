# Scientific Methodology and Performance Evaluation

This repository is a collection of studies and notes of the [Scientific Methodology and Performance Evaluation](https://codimd.math.cnrs.fr/0O2AeqE7TCijWofhF3SK-g) course of the MoSig track at Ensimag.

## Repository Structure

The project is organized as follows:

```
smpe/
├── .gitignore
├── README.md
├── mooc/
│   ├── module1/
│   │   └── readme.md
│   └── module2/
│       ├── challenger.ipynb
│       └── shuttle.csv
├── notes/
│   ├── Lecture1.md
│   ├── Lecture3.md
│   └── Lecture4.md
└── projects/
	├── good_graphics
	└── quicksort
```

## Contents

### Notes
Lecture notes covering topics such as:
- **R programming** for statistical analysis
- **Data visualization** principles and best practices
- Scientific methodology concepts

### Projects

#### Quicksort Performance Analysis
A comprehensive performance evaluation project comparing:
- Sequential quicksort implementation
- Parallel quicksort using Pthreads
- Standard library `qsort` implementation

The project includes:
- C source code with parallel implementation
- Benchmarking scripts for systematic performance measurement
- R-based data analysis and visualization
- Experimental methodology documentation

## Usage

- **Lecture notes**: Add notes in `notes/` directory
- **Code projects**: Add projects in `projects/` directory
- **MOOC materials**: Add MOOC-related files in `mooc/` directory
- Keep `README.md` updated with high-level information

## Building the Quicksort Project

```bash
cd projects/quicksort/src
make
./parallelQuicksort [array_size]
```

For benchmarking:
```bash
cd projects/quicksort
./scripts/run_benchmarking.sh
```