# Method

Preparations:

Download the tree files and metadata files from GTDB, and create symlinks:

ar53.tree
ar53.metadata.tsv
bac120.tree
bac120.metadata.tsv

I subset the GTDB to different taxonomic levels with Dendroscope, with a manual
workflow like this:

0. Start with the raw original tree

1. If needed: Subset tree to whichever parts you want

2. `make` a copy of the raw tree with singleton entries at your selected rank
   replaced with the taxon name. E.g.: `make ar53.family.wip.newick`. Open the
   resulting file in Dendroscope.

   (For subset trees, this requires a correctly named tree file, e.g.
   actinomycetia_r214.tree and a symlink pointing to a sed file, e.g.
   actinomycetia_r214.g__singletons.sed pointing to bac120.g__singletons.sed,
   see `makefile.release_dir`.)

3. Select all nodes for the rank you're subsetting for by searching for its
   prefix, e.g. `f__`.

4. Select the "subnetwork" from Dendroscope's "Select/Advanced selection" menu.

5. Invert the select ("Select/Invert Selection").

6. Add the focus taxon rank back by searching for the prefix again.

7. Invert the selection and delete selected taxa (<ctrl><backspace>).

8. Run replacement -- in *regexp* mode -- with e.g. "; g__.*" to "" to get rid
   of anything after the focus name in the labels.

9. Run replacement -- in *regexp* mode -- with "^.*f__" to "f__" to get
    rid of anything preceding the actual name in the labels.

10. Export the tree in newick format, with a `.newick` suffix and run `make
    NN.noo__leaves.newick` or whichever rank you want to remove (the one above
    the focus rank). Open the resulting file.

11. Remove bootstrap values, first by replacing "^[0-9.]+$" and then
    "^[0-9.]+-" with the empty string, in regex mode.

12. Save to the trees directory with the proper release subdirectory, by
    exporting to Newick format. Use `.newick` as suffix and name the file e.g.
    `ar122_r95_family.newick`.

13. Remove all rank prefixes (".*[a-z]__") and save as a separate file with a
    name like `ar122_r95_family_noprefix.newick`. (This is much faster with sed
    from the output in number 13.)

Make sure you start each rank's tree with the full tree, otherwise upper ranks
might have disappeared.
