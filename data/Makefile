FETCH_R95 = wget https://data.gtdb.ecogenomic.org/releases/release95/95.0/$@

r95: trees_r95 metadata_r95

trees_r95: ar122_r95.tree bac120_r95.tree

metadata_r95: ar122_metadata_r95.tsv.gz bac120_metadata_r95.tsv.gz

%_r95.tree:
	$(FETCH_R95)

ar122_metadata_r95.tar.gz:
	$(FETCH_R95)

bac120_metadata_r95.tar.gz:
	$(FETCH_R95)

%.tsv.gz: %.tar.gz
	tar xzf $<
	gzip $(basename $@)
	rm $<
