test_that("Expand Selection function 1", {
  expect_equal(
    expand_selection(idx = 5, number_lines="Jim"),

    tibble::tribble(
      ~character,                                                                                                                                                                                                                                                                                                                                                                                                                                                           ~text, ~episode, ~season, ~episode_name,    ~air_date, ~imdb_rating,
           "Jim",                                                                                                                                                                                                                                                                                                                                                                                                                    "Actually, you called me in here, but yeah.",       1L,      1L,       "Pilot", "2005-03-24",          7.6,
       "Michael",                                                                                                                                                                                                                                                                                                                                                                                                               "All right. Well, let me show you how it's done.",       1L,      1L,       "Pilot", "2005-03-24",          7.6,
       "Michael",       "Yes, I'd like to speak to your office manager, please. Yes, hello. This is Michael Scott. I am the Regional Manager of Dunder Mifflin Paper Products. Just wanted to talk to you manager-a-manger. All right. Done deal. Thank you very much, sir. You're a gentleman and a scholar. Oh, I'm sorry. OK. I'm sorry. My mistake. That was a woman I was talking to, so... She had a very low voice. Probably a smoker, so... So that's the way it's done.",       1L,      1L,       "Pilot", "2005-03-24",          7.6
      )

  )
})


test_that("Expand Selection function 1", {
  expect_equal(
    expand_selection(idx = 20, number_lines="Jimothy"),

    tibble::tribble(
      ~character,                                                                                                                                                                                                                       ~text, ~episode, ~season, ~episode_name,    ~air_date, ~imdb_rating,
       "Michael",   "People say I am the best boss. They go, \"God we've never worked in a place like this before. You're hilarious.\" \"And you get the best out of us.\" I think that pretty much sums it up. I found it at Spencer Gifts.",       1L,      1L,       "Pilot", "2005-03-24",          7.6,
        "Dwight",                                                                                                                                      "Shall I play for you? Pa rum pump um pum I have no gifts for you. Pa rum pump um pum",       1L,      1L,       "Pilot", "2005-03-24",          7.6,
           "Jim",   "My job is to speak to clients on the phone about... uh, quantities and type of copier paper. You know, whether we can supply it to them. Whether they can pay for it. And... I'm boring myself just talking about this.",       1L,      1L,       "Pilot", "2005-03-24",          7.6,
       "Michael",                                                                                                                                                                                                                  "Whassup!",       1L,      1L,       "Pilot", "2005-03-24",          7.6,
           "Jim",                                                                                                                                                                             "Whassup! I still love that after seven years.",       1L,      1L,       "Pilot", "2005-03-24",          7.6,
       "Michael",                                                                                                                                                                                                                  "Whassup!",       1L,      1L,       "Pilot", "2005-03-24",          7.6,
        "Dwight",                                                                                                                                                                                                                  "Whassup!",       1L,      1L,       "Pilot", "2005-03-24",          7.6,
       "Michael",                                                                                                                                                                                                               "Whass...up!",       1L,      1L,       "Pilot", "2005-03-24",          7.6,
        "Dwight",                                                                                                                                                                                                                  "Whassup.",       1L,      1L,       "Pilot", "2005-03-24",          7.6
      )


  )
})
