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

3. Select all nodes for the rank you're subsetting for by searching for its
   prefix, e.g. `f__`.

4. Select the "subnetwork" from Dendroscope's "Select/Advanced selection" menu.

5. Invert the select ("Select/Invert Selection").

6. Add the focus taxon rank back by searching for the prefix again.

7. Invert the selection and delete selected taxa (<ctrl><backspace>).

*It seems like numbers 8, 9 and 12 aren't necessary if you do number 2 above. Only tested on ar53 genera.*

8. Select, and remove, any remaining lower taxa by searching for "RS_", "GB_",
   ":UBA[0-9]" and e.g. ":g__". *Don't* remove leaves with the target rank plus
   a lower taxon. (Search for e.g. "^[0-9.]+:g__" in *regexp* mode.)

9.  Alt 1: Find *leaf* labels consisting of only numbers ("^[0-9.]+$" in regexp mode) and
   delete them. Note that you can't just select all and delete, since that will
   remove interior nodes too, so this is *manual* work.


   Check, in R:

   library(ape)
   read.tree('trees/r207/bac120.genus.wip.updated.newick') -> t
   t$tip.label[grepl('^[0-9.]+$', t$tip.label)] -> n

9. Alt 2: Export the tree in newick format, with a `.newick` suffix and run
   `make NN.nobsleaves.newick`. Open the resulting file.

10. Run replacement -- in *regexp* mode -- with e.g. "; g__.*" to "" to get rid
   of anything after the focus name in the labels.

11. Run replacement -- in *regexp* mode -- with "^.*f__" to "f__" to get
    rid of anything preceding the actual name in the labels.

12. Alt 1: Check for higher ranked leaf labels, e.g. "o__" in leaf nodes, and
    delete.  Search, delete one, search again, repeat until the search gives no
    *leaf* nodes. *This is a step in which certain focus taxa are lost due to
    not being present in the tree in the first place. If this is important to
    you, you might want to manually replace some leaves in the _raw_ tree or
    the focus tree from step 2 with focus taxa and start from number 3 above.*

    Check, in R:

    library(ape)
    read.tree('trees/r207/bac120.genus.wip.updated.newick') -> t
    t$tip.label[grepl('o__', t$tip.label)] -> n

12. Alt 2: Export the tree in newick format, with a `.newick` suffix and run
    `make NN.noo__leaves.newick` or whichever rank you want to remove (WIP:
    only `.nof__leaves.newick` supported right now). Open the resulting file.

13. Remove bootstrap values, first by replacing "^[0-9.]+$" and then
    "^[0-9.]+:" with the empty string, in regex mode.

13. Save to the trees directory with the proper release subdirectory, by
    exporting to Newick format. Use `.newick` as suffix and name the file e.g.
    `ar122_r95_family.newick`.

14. Remove all rank prefixes (".*[a-z]__") and save as a separate file with a
    name like `ar122_r95_family_noprefix.newick`. (This is much faster with sed
    from the output in number 13.)

Make sure you start each rank's tree with the full tree, otherwise upper ranks
might have disappeared.
