# Tendable Coding Assessment

## Usage

```sh
bundle
ruby questionnaire.rb
```

## Goal

The goal is to implement a survey where a user should be able to answer a series of Yes/No questions. After each run, a rating is calculated to let them know how they did. Another rating is also calculated to provide an overall score for all runs.

## Requirements

Possible question answers are: "Yes", "No", "Y", or "N" case insensitively to answer each question prompt.

The answers will need to be **persisted** so they can be used in calculations for subsequent runs >> it is proposed you use the pstore for this, already included in the Gemfile

After _each_ run the program should calculate and print a rating. The calculation for the rating is: `100 * number of yes answers / number of questions`.

The program should also print an average rating for all runs.

The questions can be found in questionnaire.rb

Ensure we can run your exercise

## Bonus Points

Updated readme with an explanation of your approach

Unit Tests

Code Comments

Dockerfile / Bash script if needed for us to run the exercise

## Solution
Take github repo using git clone to your local

Go inside the folder

To run the code - use command ruby run.rb

To clear the store - use command ruby clear_store.rb

To run test cases -  use command rspec questionnaire_spec.rb

## Use cases covered

Invalid inputs handled. System will ask to enter input until user enters valid input.

All permutaion and combinations of inputs are handled.

You can clear the entire store whenever you want.

Current run rating and average rating of all the runs is caluculated for every run.

Required test cases are added.
