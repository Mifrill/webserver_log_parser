describe 'parser' do # rubocop:disable RSpec/DescribeClass
  let(:command) { system './parser.rb spec/fixtures/webserver.log en' }
  let(:info) do
    <<~INFO
      /contact 3 visits
      /help_page/1 1 visit
      /contact 2 unique views
      /help_page/1 1 unique view
      /contact 1.5 average views
      /help_page/1 1.0 average view
    INFO
  end

  specify 'prints correct info to stdout' do
    expect { command }.to output(a_string_including(info)).to_stdout_from_any_process
  end
end
