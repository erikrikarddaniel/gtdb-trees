#!/usr/bin/env Rscript

# subset_to_representative.R
#
# THIS SCRIPT IS UNNECESSARY SINCE GTDB TREES ONLY CONTAIN REPRESENTATIVE GENOMES!
#
# Reads the tree and metadata file for either the ar122 or the bac120 part of
# the GTDB taxonomy and outputs a tree subset to only contain species
# representative genomes.
#
# Author: daniel.lundin@dbb.su.se

suppressPackageStartupMessages(library(optparse))
suppressPackageStartupMessages(library(readr))
suppressPackageStartupMessages(library(treeio))
suppressPackageStartupMessages(library(dplyr, warn.conflicts = FALSE))
suppressPackageStartupMessages(library(tidyr))
suppressPackageStartupMessages(library(purrr))
suppressPackageStartupMessages(library(stringr))

SCRIPT_VERSION = "0.1"

options(warn = 1)

# Dev data: opt <- list(options = list(version = SCRIPT_VERSION, intree = 'data/ar122_r95.tree', outtree = '/tmp/ar122_species.newick', metadata = 'data/ar122_metadata_r95.tsv.gz'))
# Get arguments
option_list = list(
  make_option(
    c("--intree"), type="string", 
    help="Path to input newick formatted tree file"
  ),
  make_option(
    c("--metadata"), type="string", 
    help="Path to input metadata tsv(.gz) from GTDB"
  ),
  make_option(
    c("--outtree"), type="string", 
    help="Path to output newick formatted tree file"
  ),
  make_option(
    c("-V", "--version"), action="store_true", default=FALSE, 
    help="Print program version and exit"
  )
)
opt = parse_args(
  OptionParser(
    usage = "%prog [options] edger_result_file.tsv[.gz]\n\n\tThe EdgeR result file must contain a key to join in with the SEED tables, a 'contrast' column plus logFC, FDR, locCPM.", 
    option_list = option_list
  ), 
  positional_arguments = TRUE
)

if ( opt$options$version ) {
  write(SCRIPT_VERSION, stdout())
  quit('no')
}

metadata  <- read_tsv(opt$options$metadata, show_col_types = FALSE) %>%
  filter(gtdb_representative == TRUE) %>%
  select(accession)

intree    <- read.newick(opt$options$intree)

tips2drop <- intree$tip.label[!intree$tip.label %in% metadata$accession]

drop.tip(intree, tips2drop) %>% write.tree(opt$options$outtree)
