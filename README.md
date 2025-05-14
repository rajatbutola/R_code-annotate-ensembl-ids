# Gene Annotation using Ensembl and Bioconductor Tools

This repository provides an R script that demonstrates multiple ways to map **Ensembl gene IDs to gene symbols** using several popular annotation resources including:

- **biomaRt**
- **annotables**
- **org.Hs.eg.db**
- **EnsDb.Hsapiens.v86**

The script is designed for researchers working with gene expression data who need to convert Ensembl IDs to human-readable gene symbols.

## Requirements

- R 4.3 or later

---
### Required R Packages

```r
install.packages(c("tidyverse", "remotes"))
install.packages("BiocManager")

# CRAN
remotes::install_github("stephenturner/annotables")

# Bioconductor
BiocManager::install("biomaRt")
BiocManager::install("org.Hs.eg.db")
BiocManager::install("EnsDb.Hsapiens.v86")
```

### How to Use
- Place your list of Ensembl gene IDs in a text file named Ens.txt (one ID per line).
- Set your working directory in the script to the folder containing Ens.txt.
- Run the script annotate_genes.R to perform gene annotation using four different methods.
- Review the mappings between Ensembl IDs and gene symbols from each method.


## Annotation Methods Used
### Method 1: biomaRt
- Connects to Ensembl's online BioMart to retrieve gene annotations.
- Flexible and up-to-date, but requires internet access.

### Method 2: annotables::grch38
- Uses a locally stored table of gene annotations for GRCh38.
- Fast and simple for smaller workflows.

### Method 3: org.Hs.eg.db
- Uses Bioconductor’s curated human gene database.
- Ideal for consistent annotations in Bioconductor-based workflows.

### Method 4: EnsDb.Hsapiens.v86
- Offline, version-specific annotation database from Ensembl.
- Ensures reproducibility across time.

### Notes
- Input file must be a plain text file with one Ensembl gene ID per line (no header).
- You can easily switch or combine annotation sources depending on your use case.
---

Let me know if you’d like me to create a `LICENSE` file or help structure this as a proper R package or GitHub repository!

