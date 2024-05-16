require "pstore" # https://github.com/ruby/pstore

class Survey
  QUESTIONS = {
    "q1" => "Can you code in Ruby?",
    "q2" => "Can you code in JavaScript?",
    "q3" => "Can you code in Swift?",
    "q4" => "Can you code in Java?",
    "q5" => "Can you code in C#?"
  }.freeze
  STORE_NAME = "tendable.pstore"

  def initialize
    @store = PStore.new(STORE_NAME)
  end

  def run
    answers = do_prompt
    do_report(answers)
  end

  def clear_store
    @store.transaction do
      @store.roots.each { |root| @store.delete(root) } # Clear the store
    end
  end

  private

  def do_prompt
    answers = {}
    # Ask each question and get an answer from the user's input.
    QUESTIONS.each_key do |question_key|
      print QUESTIONS[question_key]
      loop do
        ans = gets.chomp.downcase
        case ans
        when /\Ayes|\Ay/i #checking all combinations of yes
          answers[question_key] = true
          break
        when /\Ano|\An/i #checking all combinations of no
          answers[question_key] = false
          break
        else
          puts "Invalid input. Please enter 'Yes' or 'No' or 'Y' or 'N' (case insensitive)."
        end
      end
    end

    @store.transaction do
      @store[@store.roots.size] = answers
    end
    answers
  end

  def do_report(answers)
    # Calculate average rating for current run
    total_yes_count = answers.count { |_, ans| ans }
    total_questions = answers.size
    rating = (total_yes_count.to_f / total_questions) * 100
    puts "Rating for this run: #{rating.round(2)}%"

    # Calculate average rating for all runs
    total_yes_count_all_runs, total_questions_all_runs = 0, 0
    @store.transaction(true) do
      @store.roots.each do |root|
        run_answers = @store[root]
        total_yes_count_all_runs += run_answers.count { |_, ans| ans }
        total_questions_all_runs += run_answers.size
      end
    end
    average_rating = (total_yes_count_all_runs.to_f / total_questions_all_runs) * 100
    puts "Average rating for all runs: #{average_rating.round(2)}%"
  end
end