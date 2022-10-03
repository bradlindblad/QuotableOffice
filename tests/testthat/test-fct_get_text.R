test_that("get text", {
  expect_equal(
    get_text(lines, "walk away bitch"),

    tibble::tribble(
      ~index, ~character,              ~text,
      40130L,     "Gabe", "walk away bitch."
      )

  )
})



test_that("get index", {
  expect_equal(

    get_index(lines, "walk away bitch", 1),

    tibble::tribble(
      ~index, ~character,              ~text,
      40130L,     "Gabe", "walk away bitch."
    )

  )
})
