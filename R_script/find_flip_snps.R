#!/usr/bin/env Rscript

# Identify SNPs that require strand flipping between two VCF files.
# The script compares reference/alternate alleles and genotypes and
# reports SNP IDs that have complementary alleles with opposite
# homozygous genotypes.

suppressPackageStartupMessages({
  if (!requireNamespace("VariantAnnotation", quietly = TRUE)) {
    stop("The VariantAnnotation package is required")
  }
  library(VariantAnnotation)
})

args <- commandArgs(trailingOnly = TRUE)
if (length(args) < 3) {
  stop("Usage: Rscript find_flip_snps.R <vcf1> <vcf2> <output>")
}

vcf1 <- readVcf(args[1])
vcf2 <- readVcf(args[2])

ids1 <- rowRanges(vcf1)$ID
ids2 <- rowRanges(vcf2)$ID
common_ids <- intersect(ids1, ids2)

if (length(common_ids) == 0) {
  stop("No common markers found between VCF files")
}

# keep common markers in the same order
i1 <- match(common_ids, ids1)
i2 <- match(common_ids, ids2)
vcf1 <- vcf1[i1, ]
vcf2 <- vcf2[i2, ]

ref1 <- as.character(ref(vcf1))
ref2 <- as.character(ref(vcf2))
alt1 <- as.character(unlist(alt(vcf1)))
alt2 <- as.character(unlist(alt(vcf2)))

# genotype matrices
G1 <- geno(vcf1)$GT
G2 <- geno(vcf2)$GT

# complement bases
comp <- c(A="T", T="A", C="G", G="C")

flip <- c()
for (i in seq_along(common_ids)) {
  # only handle simple biallelic SNPs
  if (!(ref1[i] %in% names(comp) && alt1[i] %in% names(comp))) next
  if (!(ref2[i] %in% names(comp) && alt2[i] %in% names(comp))) next

  if (identical(comp[ref1[i]], ref2[i]) && identical(comp[alt1[i]], alt2[i])) {
    homo1a <- G1[i, ] %in% c("0/0", "0|0")
    homo1b <- G1[i, ] %in% c("1/1", "1|1")
    homo2a <- G2[i, ] %in% c("0/0", "0|0")
    homo2b <- G2[i, ] %in% c("1/1", "1|1")
    opp <- (homo1a & homo2b) | (homo1b & homo2a)
    if (any(opp, na.rm = TRUE)) {
      flip <- c(flip, common_ids[i])
    }
  }
}

writeLines(flip, con = args[3])
