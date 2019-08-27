#' @title Select helpers
#' @description These functions allow you to reactive multiple reactive elements based on their names
#' @param match character
#' @inheritParams shiny::eventReactive
#' @param input reactive object
#' @param ignore.case logical If TRUE ignores case when matching names, Default: TRUE
#' @param elements character vector contains names of elements in the reactive object
#' @return observer reference class object
#' @details The internal [shiny::eventReactive] is passed a variable `var_`
#'   that contains the matched element name in the reactive object input. That variable
#'   can be defined as a paramter of valueExpr.
#' @examples
#' \dontrun{
#'if(interactive()){
#' ui <- shiny::fluidPage(
#'   shiny::column(width = 6,
#'      lapply(1:4,FUN = function(x){
#'        shiny::actionButton(inputId = sprintf('btn_%02d',x),label = 'update')
#'      })
#'                 )
#' )
#'
#' server <- shiny::shinyServer(function(input, output,session) {
#'
#'   out <- shinyselect::reactive_one_of(c('btn_01','btn_03'),
#'   valueExpr = function(var_){
#'     runif(as.numeric(gsub('[^0-9]','',var_)))
#'   },input)
#'
#'   shinyselect::observe_contains(match = 'btn_0(1|3)',
#'                               handlerExpr = function(var_){
#'                                 print(out()[[var_]]())
#'                                 },
#'                               input = out()
#'                               )
#'
#' })
#'
#' shiny::shinyApp(ui = ui, server = server)
#' }
#' }
#' @rdname reactive
#' @export

reactive_contains <- function(match,valueExpr,input,ignore.case = TRUE){

  shiny_reactive_select(match,valueExpr,input,ignore.case = ignore.case)

}

#' @rdname reactive
#' @export
reactive_starts_with <- function(match,valueExpr,input,ignore.case = TRUE){

  shiny_reactive_select(sprintf('^%s',match),valueExpr,input,ignore.case = ignore.case)

}

#' @rdname reactive
#' @export
reactive_ends_with <- function(match,valueExpr,input,ignore.case = TRUE){

  shiny_reactive_select(sprintf('%s$',match),valueExpr,input,ignore.case = ignore.case)

}

#' @rdname reactive
#' @export
reactive_one_of <- function(elements,valueExpr,input,ignore.case = TRUE){

  match <- paste0(elements,collapse = '|')

  shiny_reactive_select(match,valueExpr,input,ignore.case = ignore.case)

}
