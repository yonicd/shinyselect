shiny_select <- function(match,handlerExpr,input,ignore.case = TRUE){

  shiny::observe({
    lapply(
      grep(match,names(input),value = TRUE,ignore.case = ignore.case),
      function(var_,input, handlerExpr){
        shiny::observeEvent(eventExpr = input[[var_]],handlerExpr(var_))
      },
      input = input,
      handlerExpr = handlerExpr
    )
  })

}
