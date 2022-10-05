test_that("get text", {
  expect_equal(
    get_text(lines, "Walk away bitch"),
    tibble::tribble(
      ~index, ~character,              ~text,
      40130L,     "Gabe", "Walk away bitch."
    )
  )
})



test_that("get index", {
  expect_equal(
    get_index(lines, "Walk away bitch", 1),
    tibble::tribble(
      ~index, ~character,              ~text,
      40130L,     "Gabe", "Walk away bitch."
    )
  )
})
