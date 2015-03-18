# GOexpress (MDM full)
Example of a shiny app wrapped around the output object of the
[GOexpress](http://master.bioconductor.org/packages/devel/bioc/html/GOexpress.html)
Bioconductor package.

## GOexpress: Gene Ontology for expression data

GOexpress is a software package designed for the visualisation of gene
expression profiles, and the identification of robust molecular functions
(gene ontologies) associated with genes best clustering groups of
experimental samples.

### Visualisation

Gene expression profiles may be visualised for individual sample series,
summarised by groups of samples, or summarised by gene ontology. We
called those three types of plots 'expression\_profiles', 'expression\_plot',
and 'heatmap_GO', respectively.

### Scoring and ranking

The identification of interesting genes and gene ontologies is performed
using a supervised clustering approach called the random forest, subsequently
summarised at the gene ontology level by averaging the results of all genes
associated with a common ontology.

## Data

Here, we created a small app using the results of a study where we seeked
the genes and gene ontologies best clustering bovine monocyte-derived
macrophages experimentally infected with _M. bovis_, _M. bovis_ BCG,
_M. avium_ subspecies _paratuberculosis_, or negative controls left
 uninfected.
