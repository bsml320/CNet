# CNet: discovery of clinically associated, combinatory genomic signatures

CNet is a JAR package that detects groups of genomic signatures that are associated with clinical and phenotypical outcomes.

## Input files that should be prepared

1. X: Predictor profile matrices: formatted as samples by genes, with only 0 and 1 allowed (i.e., binary matrix). Space seperated. 
2. Y: Phenotype file: a file with 2 columns (continuous or categorical phenotype) or 3 columns (censored data)
3. net: Network file: a file with 2 columns, each row with a pair of genes, space seperated. Alternatively, use the label "net=full" to refer a fully connected network.

## Other input parameters:

4. model={glm|km|chisq|FET}: no default value; users must select one of the four models according to their phenotype.
5. r_include=0.2: default: 0.2; suggest to be a value between 0.2 and 0.5
6. r_exclude=0.1: default: 0.1; suggest to be half of the value r_include
7. output=output.modules.txt
8. exclude: a file that includes a list of genes to be excluded, one gene per row. Default: no gene is excluded.
9. permutation={true|false}:
10. keep_permutation={true|false}: whether to keep the intermediate permutation files

## Output file

If permutation is turned off (permutation=false), a file named output.modules.txt will be generated, with 5 columns: seed_gene, module_score, component_genes, tags, z_score

If permutation is turned on, a file named output.modules.withZ.txt will be generated, with 6 columns: seed_gene, module_score, component_genes, tags, z_score, z_score2

## Example
### 1. Default

java -jar /home/pjia/code/CNet.jar

usage: java CNet <model=glm|km|chisq|FET>
        <X=Xfile>
        <Y=Yfile>
        <net=networkfile>
        <r_include=0.2>
        <r_exclude=0.1>
        <output=output.modules.txt>
        <exclude=exclude_gene_file>
        <permutation={true|false}>
        <keep_permutation={true|false}>

### 2. One predictor matrix:

java -jar /path/to/code/CNet.jar model=chisq X=BRCA.mut_raw.txt Y=BRCA.Y.txt net=/path/to/PC.interact.txt r_include=0.2 r_exclude=0.1 output=BRCA.mut_raw.modules.txt permutation=true keep_permutation=false 2>log

### 3. Two predictor matrices:

java -jar /home/pjia/code/CNet.jar model=chisq X=BRCA.cnv_gain.txt:BRCA.cnv_loss.txt Y=BRCA.CNV_Y.txt net=/path/to/PC.interact.txt r_include=0.4 r_exclude=0.2 output=BRCA.cnv.modules.txt permutation=true keep_permutation=false 2>log
          
In this case, the column "tag" in the output file has multiple index to indicate the dimension that the corresponding gene was selected. For example:

seed_gene       module_score    component_genes tags    z_score z_score2

PDE4B   39.43061966735023       AGA PDE4B       1 0     13.921094778202217      6.869421258373911

There are two genes (AGA and PDE4B) in this module. The tag "1 0" indicates that the first gene AGA has its best dimension in the 2nd input matrix, i.e., BRCA.cnv_loss.txt, and the second gene PDE4B has its best dimension in the 1st input matrix, i.e. BRCA.cnv_gain.txt. Here "1 0" is the index of the input matrices (started at 0).

### 4. Exclude genes with extreme effect:
java -jar /home/pjia/code/CNet.jar model=chisq X=BRCA.mut_one.txt Y=BRCA.Y.txt net=/path/to/PC.interact.txt r_include=0.2 r_exclude=0.1 output=BRCA.mut_one.excludeTP53.modules.txt permutation=true keep_permutation=false exclude=excludeTP53.txt 2>log
 
