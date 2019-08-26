ui <- shiny::fluidPage(
  shiny::column(width = 6,
                lapply(1:4,FUN = function(x){
                  shiny::textInput(inputId = sprintf('txt_%02d',x),
                                   label = NULL,
                                   value = '',
                                   placeholder = letters[x])
                })),
  shiny::column(width = 6,
                lapply(1:4,FUN = function(x){
                  shiny::actionButton(inputId = sprintf('btn_%02d',x),label = 'update')
                })
                )
)

server <- shiny::shinyServer(function(input, output,session) {

  shinyselect::observe_contains('btn_0(1|3)',
                      handlerExpr = function(var_){
                        shiny::updateTextInput(
                          session,
                          inputId = gsub('btn','txt',var_),
                          value   = strrep(letters[as.numeric(gsub('[^0-9]','',var_))],3)
                          )
                      },input)

  shinyselect::observe_one_of(c('btn_02','btn_04'),
                                handlerExpr = function(var_){
                                  shiny::updateTextInput(
                                    session,
                                    inputId = gsub('btn','txt',var_),
                                    placeholder = 'something new'
                                  )
                                },input)

})

shiny::shinyApp(ui = ui, server = server)
