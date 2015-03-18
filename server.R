library(shiny)
library(GOexpress)

exprSet = readRDS(file = "data/MDM.eSet.rds")
gox.raw = readRDS(file = "data/GOx.Infection.pval.rds")

# The gene score table has probeset identifiers in the row names
# however row names are not displayed/supported by shiny
# we need to move those row names into a proper column of the
# result table
genesScore = gox.raw$genes
genesScore$Probeset = rownames(genesScore)
genesScore = genesScore[,c(
    'Probeset','Score','Rank','external_gene_name','description')
    ]

shinyServer(
    function(input, output) {
        
        # Generate a plot of the requested gene symbol by individual sample series
        output$exprProfiles <- renderPlot({
            expression_profiles_symbol(
                gene_symbol = input$external_gene_name,
                result = gox.raw,
                eSet = exprSet,
                x_var = "Hours.post.infection",
                seriesF = "Animal.Infection",
                subset = list(
                    Animal_ID=input$animals,
                    Time=input$hours,
                    Infection=input$infection
                ),
                colourF = "Infection",
                #linetypeF = "Infection",
                line.size = input$linesize,
                index = input$index,
                xlab="Hours post-infection",
            )
        })
        
        # Generate a plot of the requested gene symbol by sample groups
        output$exprPlot <- renderPlot({
            expression_plot_symbol(
                gene_symbol = input$external_gene_name,
                result = gox.raw,
                eSet = exprSet,
                x_var = "Hours.post.infection",
                subset = list(
                    Animal_ID=input$animals,
                    Time=input$hours,
                    Infection=input$infection
                ),
                index = input$index,
                xlab="Hours post-infection",
            )
        })
        
        # Generate a heatmap of the requested GO identifier
        output$heatmap <- renderPlot({
            heatmap_GO(
                go_id = input$go_id,
                result = gox.raw,
                eSet = exprSet,
                subset=list(
                    Animal_ID=input$animal.GO,
                    Time=input$hours.GO,
                    Infection=input$infection.GO
                ),
                cexRow = input$cexRow.GO
            )
        })
        
        # Turn the AnnotatedDataFrame into a data-table
        output$Adataframe <- renderDataTable(
            pData(exprSet),
            options = list(
                pageLength = 20)
        )
        
        output$GOscores <- renderDataTable(
            gox.raw$GO[which(
                gox.raw$GO$total_count >= input$min.total &
                    gox.raw$GO$p.val <= input$max.pval
            ),],
            options = list(
                pageLength = 20)
        )
        
        output$genesScore <- renderDataTable(
            genesScore,
            options = list(
                pageLength = 20)
        )
    }
)
