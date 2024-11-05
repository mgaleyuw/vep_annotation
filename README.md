# VEP THING

I've edited this file and I want to save it.

A phenotype annotation tool for filtered vep output or any other type of comma separated values that include a genomic position. Uses RMarkdown to generate an HTML file with an interactive table of variants that are likely to be pathogenic, organized into priority tiers. Also returns the original input file with OMIM phenotypes and error-prone regions flagged.

This is highly tuned for the output of the Miller lab's internal use of VEP and the specific set of annotation datasets that we use. See the supplemental scripts (`/supplemental`) for what tools are used and what downstream processing is performed before running this tool. It almost certainly will not work with other configurations of VEP or without running the downstream processing tool to filter low quality variants and process the VCF into a .csv. Special care should be taken in the treatment of multiallelic variants.

For data aligned to hg38. Developed for use in a Linux environment; tested on Ubuntu and RedHat.

## Installation

Clone this repository. Run from the repository directory or add the repository to a `bin` folder on your path.

**Dependenceis:**
 - bcftools >= 2.31.1
 - R >= 4.2.3
 - R: dplyr
 - R: plyr
 - R: reshape2
 - R: tidyr
 - R: scales
 - R: ggplot2
 - R: htmltools
 - R: jsonlite
 - R: reactable
 - R: crosstalk
 - R: stringr
 - R: stringi
 - R: knitr
 - R: markdown

 In the miller lab, these dependenceies are all pre-installed in the conda environment `vep-annotate`.

## Usage

Run `annotate_vep_all.sh` using filtered vep output (the af_lt1.csv file).

Required flags:
    - `-i` : path to input file
    - `-o` : path to output file 

Options:
    - `-q`: For variants detected in regions with homopolymers, segmental duplications, simple repeats, blacklisted ENCODE regions, or GRC exclusions, quality must be above this threshold to be considered as a reportable variant (default of 20.0)
    - `d` : The minimum allelic depth of an ALT allele that should be considered as a reportable variant (default of 4)

## Example and Details

```
bash annotate_vep_all.sh -i /path/to/input_vep.csv -o /outputdir/vep.omim.flags.csv -q 10 -d 5
```

produces the following files:

```
/outputdir/vep.omim.flags.csv
/outputdir/vep.omim.flags.log
/outputdir/vep.omim.flags.prioritized.csv
/outputdir/vep.omim.flags.prioritized.report.html
```

VEP THING adds the following columns to the original csv:

- OMIM : indexed by position, any OMIM phenotypes associated with the variant
- Mappability: reports type of overlap with ENCODE blacklisted regions
- GRCExclusions : reports overlap with GRC Excluded regions
- Repeats: reports overlap with satellites and simple repeats
- UCSC_Unusual: reports overlap with UCSC's track of unusual regions
- SegmentalDuplications: reports overlap with UCSC's segmental duplication track
- Homopolymers: reports overlap with homopolymeric regions (>=4nt)

Variants are prioritized according to the following schema:


HTML reports are static and can be viewed outside of a server environment. See an example here:.
