library("shiny")
library("shinythemes")
source("scripts/intro.r")

landing_page <- tabPanel(
  titlePanel("Introduction"),
  verticalLayout(
    tags$h1(
      style = "text-align: center;
              font-size: 2.125rem;
              font-weight: bold;
              line-height: 1.3",
      "How Politcal Advertisers Target You on Facebook"
    ),
    tags$div(
      align = "middle",
      style = "margin: 30px",
      tags$iframe(
        width = "560",
        height = "315",
        src = "https://www.youtube.com/embed/mrnXv-g4yKU",
        frameborder = "0",
        allow = "accelerometer; autoplay; encrypted-media;
                  gyroscope; picture-in-picture"
      )
    ),
    tags$div(
      style = "margin-left: 150px; margin-right: 150px; line-height: 1.5",
      tags$p(
        intro1
      ),
      tags$br(),
      tags$p(
        intro2
      )
    )
  )
)

page_one <- tabPanel(
  titlePanel("Sample Users"),
  sidebarLayout(
    sidebarPanel(
      selectInput(
        inputId = "sample_var",
        label = "Pick a Caricature",
        choices = c(
          "18 year old female liberal from California who likes Bernie Sanders",
          "50 year old male conservative from Texas who likes Donald Trump"
        )
      ),
    ),

    # Display the map and table in the main panel
    # Use stylesheet and fit images
    mainPanel(
      tags$meta(charset = "utf-8"),
      tags$style("img {display: block;width: 100%;}"),
      tags$link(
        rel = "stylesheet",
        href = "https://projects.propublica.org/facebook-ads/styles.css",
        type = "text/css",
        media = "all"
      ),
      uiOutput(outputId = "sample_feed")
    ),
  )
)

page_two <- tabPanel(
  titlePanel("Custom User"),
  sidebarLayout(
    sidebarPanel(
      sliderInput(
        inputId = "custom_age",
        label = "Age",
        min = 0,
        max = 100,
        value = 20,
        step = 5
      ),
      selectInput(
        inputId = "custom_gender",
        label = "Gender",
        choices = c("man", "women")
      ),
      selectInput(
        inputId = "custom_po",
        label = "Political Orientation",
        choices = c(
          "very conservative", "conservative", "moderate",
          "liberal", "very liberal"
        )
      ),
      selectInput(
        inputId = "custom_region",
        label = "Location",
        choices = state.name
      )
    ),

    # Display the map and table in the main panel
    # Use stylesheet and fit images
    mainPanel(
      tags$meta(charset = "utf-8"),
      tags$style("img {display: block;width: 100%;}"),
      tags$link(
        rel = "stylesheet",
        href = "https://projects.propublica.org/facebook-ads/styles.css",
        type = "text/css",
        media = "all"
      ),
      uiOutput(outputId = "custom_feed")
    ),
  )
)

page_three <- tabPanel(
  titlePanel("About the Ads"),
  sidebarLayout(
    sidebarPanel(
      h2("What kind of information do you want?"),
      radioButtons(
        inputId = "graph_type",
        label = "Choices",
        choices = c("Top 10 Political Ads" = 1,
                    "Parties of Top 20 Advertisement" = 2
        )
      )
    ),
    mainPanel(
      h2("Your Desired Graph"),
      plotOutput("desired_graph"),
      plotlyOutput("interactive")
    )
  )
)

conclusion <- tabPanel(
  "Summary Takeaways",
  mainPanel(uiOutput("summary"))
)


app_ui <- navbarPage(
  theme = shinytheme("sandstone"),
  title = "Facebook Political Ads Simulator",
  landing_page,
  page_one,
  page_two,
  page_three,
  conclusion
)

