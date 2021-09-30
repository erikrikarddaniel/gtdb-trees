# gtdb-trees

This project is about subsetting GTDB trees by leaf taxon (e.g. to contain only
species representative genomes) or by higher taxa, e.g. families.  The former
is typically done with a script while the second task is manual but may start
from a tree subset to e.g. representative genomes to be easier and take less
memory.

# Directories

## `data`

Contains GTDB files plus Makefile(s) that make it easier to collect new data.

Data that can be downloaded from GTDB is not put in the Git repository, but
downloaded with `make` targets. At the moment this means all files except the
`Makefile` is kept from the repository.

## `scripts`

Scripts have paths that are relative to the root directory of the project, i.e.
the directory where this file is found.
