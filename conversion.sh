#!/usr/bin/env bash

vcf=subset_VCF_for_conversion_snp_DP.vcf

##########################################################
# first convert VCF to a tab-separated table of genotypes
##########################################################

# write a header line of the genotype table, including sample names
printf "#chrom\tpos\tref\talt\t" > gt.tsv
bcftools query -l $vcf | tr '\n' '\t' | sed 's/\t$/\n/' >> gt.tsv

# convert the full VCF file into a simple tab-separated table of GTs
# after first subsetting to only biallelic SNPs
bcftools view -m2 -M2 -v snps $vcf \
         | bcftools query -f "%CHROM\t%POS\t%REF\t%ALT[\t%GT]\n" $vcf \
         >> gt.tsv

# compress and index the table
bgzip gt.tsv
tabix -s1 -b2 -e2 gt.tsv.gz

# create a subset of this genotype table with transversions only
zcat gt.tsv.gz \
    | awk 'NR == 1 || !(($3 == "C" && $4 == "T") || ($3 == "G" && $4 == "A"))' \
    | bgzip \
          > gt_nodmg.tsv.gz
tabix -s1 -b2 -e2 gt_nodmg.tsv.gz


##########################################################
# convert the table of genotypes into EIGENSTRAT
# (just one table, transversions-only table can be
# converted in the same way)
##########################################################

# convert a table of genotypes into EIGENSTRAT

# geno file
zcat gt.tsv.gz \
    | cut -f5- \
    | tail -n+2 \
    | perl -lane '$_ =~ s/0/2/g; $_ =~ s/1/0/g; $_ =~ s/\./9/g; $_ =~ s/\W//g; print' \
           > eigenstrat.geno

# snp file
zcat gt.tsv.gz \
    | tail -n+2 \
    | perl -lane '$F[0] =~ s/chr//; print "$F[0]_$F[1]" . "\t" . $F[0] . "\t0\t" . $F[1] . "\t" . $F[2] . "\t" . $F[3]' \
           > eigenstrat.snp

# ind file
zcat gt.tsv.gz \
    | head -n1 \
    | cut -f5- \
    | tr '\t' '\n' \
    | perl -lane 'print $F[0] . "\tU\t" . "$F[0]"' \
	   > eigenstrat.ind
