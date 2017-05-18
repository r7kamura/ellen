require "spec_helper"

describe Ruboty::Handlers::Help do
  let(:robot) do
    Ruboty::Robot.new
  end

  describe "#help" do
    let(:from) do
      "alice"
    end

    let(:to) do
      "#general"
    end

    context "with valid condition" do
      let(:body) do
        <<-EOS.strip_heredoc.strip
          ruboty help (me) (<filter>) - Show this help message
          ruboty ping - Return PONG to PING
          ruboty who am i? - Answer who you are
        EOS
      end

      it "responds to `@ruboty help` and says each handler's description" do
        expect(robot).to receive(:say).with(
          body: body,
          code: true,
          from: to,
          to: from,
          original: {
            body: "@ruboty help",
            from: from,
            robot: robot,
            to: to,
          },
        )
        robot.receive(body: "@ruboty help", from: from, to: to)
      end
    end

    context "with filter" do
      it "filters descriptions by given filter" do
        expect(robot).to receive(:say).with(
          hash_including(
            body: "ruboty ping - Return PONG to PING",
          ),
        )
        robot.receive(body: "@ruboty help ping", from: from, to: to)
      end
    end
  end
end
