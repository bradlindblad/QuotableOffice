test_that("plot gt", {
  testthat::expect_s3_class(
    plot_gt(lines[1, ]),
    "gt_tbl"
  )
})
