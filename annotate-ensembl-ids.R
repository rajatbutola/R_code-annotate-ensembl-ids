# Load necessary libraries
library(biomaRt)              # Interface to Ensembl BioMart for gene annotations
library(annotables)           # Provides gene annotation tables like grch38
library(org.Hs.eg.db)         # Human gene annotation database (from Bioconductor)
library(EnsDb.Hsapiens.v86)   # Ensembl-based human annotation database (version 86)
library(tidyverse)            # Collection of R packages for data wrangling and visualization

# Set working directory to the folder containing your input file
setwd('C:/Users/gshieh2_/Desktop/Rajat Butola/GUI/New Manuscript')

# Read Ensembl gene IDs from a text file (one per line, no header)
ensembl.ids <- read.delim('Ens.txt', header = FALSE)

# -------------------------
# Method 1: Using biomaRt
# -------------------------

# List available Ensembl BioMart databases (not needed unless debugging or exploring options)
listEnsembl()

# Connect to the main Ensembl genes BioMart
ensembl <- useEnsembl(biomart = "genes")

# List available datasets in the selected BioMart (e.g., for different species)
datasets <- listDatasets(ensembl)

# Connect to the human gene dataset within Ensembl
ensembl.con <- useMart("ensembl", dataset = "hsapiens_gene_ensembl")

# List available attributes (columns you can retrieve, e.g., gene names, IDs, etc.)
attr <- listAttributes(ensembl.con)

# List available filters (e.g., ENSEMBL ID, SYMBOL) you can use for querying
filters <- listFilters(ensembl.con)

# Retrieve external gene names (HGNC symbols) for given Ensembl IDs
getBM(
  attributes = c("ensembl_gene_id", "external_gene_name"),  # columns to return
  filters = "ensembl_gene_id",                              # filter type
  values = ensembl.ids$V1,                                  # Ensembl IDs to look up
  mart = ensembl.con                                        # BioMart connection
)

# Filter the grch38 annotation table for your list of Ensembl IDs
# Returns gene symbol, description, etc.
grch38 %>% 
  filter(ensgene %in% ensembl.ids$V1)

# -------------------------
# Method 2: Using org.Hs.eg.db
# -------------------------

# List the key types you can use to query (e.g., ENSEMBL, SYMBOL, ENTREZID)
keytypes(org.Hs.eg.db)

# List available columns (what info you can retrieve, e.g., SYMBOL, GENENAME, etc.)
columns(org.Hs.eg.db)

# Map Ensembl IDs to gene symbols using org.Hs.eg.db
mapIds(
  org.Hs.eg.db,
  keys = ensembl.ids$V1,   # Input Ensembl IDs
  keytype = 'ENSEMBL',     # Specify input ID type
  column = 'SYMBOL'        # Desired output (gene symbols)
)

# -------------------------
# Method 3: Using EnsDb.Hsapiens.v86
# -------------------------

# List valid key types (e.g., GENEID, TXID, ENSEMBLTRANS) for querying
keytypes(EnsDb.Hsapiens.v86)

# List available columns that can be retrieved (e.g., SYMBOL, GENENAME)
columns(EnsDb.Hsapiens.v86)

# Map Ensembl gene IDs to gene symbols using EnsDb.Hsapiens.v86
mapIds(
  EnsDb.Hsapiens.v86,
  keys = ensembl.ids$V1,    # Input Ensembl IDs
  keytype = 'GENEID',       # Input key type in EnsDb
  column = 'SYMBOL'         # Output column: gene symbol
)
