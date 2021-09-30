# Method

I subset the GTDB to different taxonomic levels with Dendroscope, with a manual
workflow like this:

1. Start with the raw original tree

2. Select all nodes for the taxon you're subsetting for by searching for its
   prefix, e.g. `f__`.

3. Select the "induced subnetwork" from Dendroscope's "Select/Advanced
   selection" menu.

4. Invert the select ("Select/Invert Selection").

5. Add the focus taxon rank back by searching for the prefix again.

6. Invert the selection and delete selected taxa (<ctrl><backspace>).

7. Select, and remove, any remaining lower taxa by searching for "RS_", "GB_"
   and e.g. ":g__".

8. Find leaf labels consisting of only numbers ("^[0-9]+$" in regexp mode) and
   delete them. Note that you can't just select all and delete, since that will
   remove interior nodes too, so this is *manual* work.

9. Run replacement -- in *regexp* mode -- with e.g. "; g__.*" to "" to get rid
   of anything after the focus name in the leaf labels.

10. Run replacement -- in *regexp* mode -- with "^.*f__" to "f__" to get
    rid of anything preciding the actual name in the leaf labels.

11. Check for higher ranked leaf labels, e.g. "o__" in leaf nodes, and delete.
    Search, delete one, search again, repeat until the search gives no *leaf*
    nodes.

11. Save by exporting to Newick format. Use `.newick` as suffix and name the
    file e.g. `ar122_r95_family.newick`.

12. Remove all rank prefixes (".*[a-z]__") and save as a separate file with a
    name like `ar122_r95_family_noprefix.newick`.

Make sure you start each rank's tree with the full tree, otherwise upper ranks
might have disappeared.
