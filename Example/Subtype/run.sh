### ALL
java -jar CNet.jar model=chisq \
    X=BRCA.mut_raw.txt \
    Y=BRCA.Y.txt \
    net=PC.interact.txt \
    r_include=0.2 \
    r_exclude=0.1 \
    output=BRCA.mut_raw.modules.txt \
    permutation=true \
    keep_permutation=false \
    2>log


### Exclude TP53
java -jar CNet.jar model=chisq \
    X=BRCA.mut_raw.txt \
    Y=BRCA.Y.txt \
    net=PC.interact.txt \
    r_include=0.2 \
    r_exclude=0.1 \
    output=BRCA.mut_raw.excludeTP53.modules.txt \
    permutation=true \
    keep_permutation=false \
    exclude=excludeTP53.txt \
    2>log


### Exclude TP53 and PIK3CA
java -jar CNet.jar model=chisq \
    X=BRCA.mut_raw.txt \
    Y=BRCA.Y.txt \
    net=PC.interact.txt \
    r_include=0.2 \
    r_exclude=0.1 \
    output=BRCA.mut_raw.excludeTP53_PIK3CA.modules.txt \
    permutation=true \
    keep_permutation=false \
    exclude=excludeTP53_PIK3CA.txt \
    2>log
