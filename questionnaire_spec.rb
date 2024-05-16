require_relative 'questionnaire'

RSpec.describe Survey do
  describe "#run" do
    context "when user provides valid input" do
      it "stores user answers in the store" do
        survey = Survey.new
        user_input = StringIO.new("yes\nno\nyes\nno\nyes\n")
        allow(survey).to receive(:gets).and_return(user_input.gets)
        expect(survey).to receive(:do_prompt).and_call_original
        expect(survey).to receive(:do_report).and_call_original
        survey.run
        store = PStore.new(Survey::STORE_NAME)
        retrieved_answers = store.transaction { store[0] }
        
        expect(retrieved_answers.size).to eq(5)
        expect(retrieved_answers.values.all? { |ans| ans == true || ans == false }).to be true
      end

      it "calculates and displays rating for the run" do
        survey = Survey.new
        user_input = StringIO.new("yes\nyes\nyes\nyes\nyes\n")
        allow(survey).to receive(:gets).and_return(user_input.gets)
        expect { survey.run }.to output(/Rating for this run: 100\.0%\n/).to_stdout
      end
    end

    context "when user provides invalid input" do
      it "re-prompts the user until valid input is provided" do
        survey = Survey.new
        allow(survey).to receive(:gets).and_return("foo\n", "yes\n")
        # Expect the invalid input message to be printed
        expect { survey.run }.to output(/Invalid input. Please enter 'Yes' or 'No' or 'Y' or 'N' \(case insensitive\)/).to_stdout
        # Ensure the loop ends after valid input is provided
        expect { survey.run }.to output(/Rating for this run: \d+\.\d+%$/).to_stdout
      end
    end
  end
end