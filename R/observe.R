#' @title Select helpers
#' @description These functions allow you to observe multiple reactive elements based on their names
#' @param match character
#' @inheritParams shiny::observeEvent
#' @param input reactive object to observe
#' @param ignore.case logical If TRUE ignores case when matching names, Default: TRUE
#' @param elements character vector contains names of elements in the reactive object
#' @return observer reference class object
#' @details The
#' @examples
#' \dontrun{
#' if(interactive()){
#'  shiny::runApp(system.file('app.R',package = 'shinyselect'))
#'  }
#' }
#' @rdname observe
#' @export

observe_contains <- function(match,handlerExpr,input,ignore.case = TRUE){

  shiny_select(match,handlerExpr,input,ignore.case = ignore.case)

}

#' @rdname observe
#' @export
observe_starts_with <- function(match,handlerExpr,input,ignore.case = TRUE){

  shiny_select(sprintf('^%s',match),handlerExpr,input,ignore.case = ignore.case)

}

#' @rdname observe
#' @export
observe_ends_with <- function(match,handlerExpr,input,ignore.case = TRUE){

  shiny_select(sprintf('%s$',match),handlerExpr,input,ignore.case = ignore.case)

}

#' @rdname observe
#' @export
observe_one_of <- function(elements,handlerExpr,input,ignore.case = TRUE){

  match <- paste0(elements,collapse = '|')

  shiny_select(match,handlerExpr,input,ignore.case = ignore.case)

}
