#' @title Select helpers
#' @description These functions allow you to observe multiple reactive elements based on their names
#' @param match character
#' @inheritParams shiny::observeEvent
#' @param input reactive object to observe
#' @param ignore.case logical If TRUE ignores case when matching names, Default: TRUE
#' @param elements character vector contains names of elements in the reactive object
#' @return observer reference class object
#' @details The internal [shiny:observeEvent] is passed a variable `var_`
#'   that contains the matched element name in the reactive object input. That variable
#'   can be defined as a paramter of handlerExpr.
#' @examples
#' \dontrun{
#'if(interactive()){
#'ui <- shiny::fluidPage(
#'  shiny::column(width = 6,
#'                lapply(1:4,FUN = function(x){
#'                  shiny::textInput(inputId = sprintf('txt_%02d',x),
#'                                   label = NULL,
#'                                   value = '',
#'                                   placeholder = letters[x])
#'                })),
#'  shiny::column(width = 6,
#'                lapply(1:4,FUN = function(x){
#'                  shiny::actionButton(inputId = sprintf('btn_%02d',x),label = 'update')
#'                })
#'                )
#')
#'
#'server <- shiny::shinyServer(function(input, output,session) {
#'
#'  shinyselect::observe_contains('btn_0(1|3)',
#'                      handlerExpr = function(var_){
#'                        shiny::updateTextInput(
#'                          session,
#'                          inputId = gsub('btn','txt',var_),
#'                          value   = strrep(letters[as.numeric(gsub('[^0-9]','',var_))],3)
#'                          )
#'                      },input)
#'
#'  shinyselect::observe_one_of(c('btn_02','btn_04'),
#'                                handlerExpr = function(var_){
#'                                  shiny::updateTextInput(
#'                                    session,
#'                                    inputId = gsub('btn','txt',var_),
#'                                    placeholder = 'something new'
#'                                  )
#'                                },input)
#'
#'})
#'
#'shiny::shinyApp(ui = ui, server = server)
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
