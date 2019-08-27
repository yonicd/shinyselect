shiny_observe_select <- function(match,handlerExpr,input,ignore.case = TRUE){

  shiny::observe({
    lapply(
      grep(match,names(input),value = TRUE,ignore.case = ignore.case),
      function(var_,input, handlerExpr){
        if(inherits(input[[var_]],'reactiveExpr')){
          shiny::observeEvent(eventExpr = input[[var_]](),handlerExpr(var_))
        }else{
          shiny::observeEvent(eventExpr = input[[var_]],handlerExpr(var_))
        }
      },
      input = input,
      handlerExpr = handlerExpr
    )
  })

}

shiny_reactive_select <- function(match,valueExpr,input,ignore.case = TRUE){

  shiny::reactive({

    nm <- grep(match,names(input),value = TRUE,ignore.case = ignore.case)
    nm <- setNames(nm,nm)

    lapply(nm,
      function(var_,input, valueExpr){
        shiny::eventReactive(eventExpr = input[[var_]],
                             valueExpr = valueExpr(var_))
      },
      input = input,
      valueExpr = valueExpr
    )
  })

}
