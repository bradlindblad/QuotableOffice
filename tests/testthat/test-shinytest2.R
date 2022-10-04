library(shinytest2)

test_that("{shinytest2} recording: QuotableOffice", {
  app <- AppDriver$new(variant = platform_variant(), name = "QuotableOffice", height = 886, 
      width = 1619)
  app$expect_screenshot()
  app$set_inputs(`query_corpus_1-expand_selection` = "James")
  app$expect_screenshot()
  app$set_inputs(`query_corpus_1-input_text` = "")
  app$expect_screenshot()
})
