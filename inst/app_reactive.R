ui <- shiny::fluidPage(
  shiny::column(width = 6,
                lapply(1:4,FUN = function(x){
                  shiny::actionButton(inputId = sprintf('btn_%02d',x),label = 'update')
                })
                )
)

server <- shiny::shinyServer(function(input, output,session) {

  out <- shinyselect::reactive_one_of(c('btn_01','btn_03'),valueExpr = function(var_){
    runif(as.numeric(gsub('[^0-9]','',var_)))
  },input)

  shinyselect::observe_contains(match = 'btn_0(1|3)',
                              handlerExpr = function(var_){
                                print(out()[[var_]]())
                                },
                              input = out()
                              )

})

shiny::shinyApp(ui = ui, server = server)
