require_relative '../models/person'  # a reference to our code

describe Person do
  describe "Constructor" do
    subject(:matt) { Person.new("Matt") }

    it "creates a new instance of class Person" do
      expect(matt).to be_an_instance_of(Person)
    end

    it "gives instance a name" do
      expect(matt.name).to_not be_nil
    end

    it "defaults language to 'English'" do
      expect(matt.language).to eq("English")
    end
  end

  describe "#greeting" do
    context "when language is English (default language)" do
      subject(:bob) { Person.new("Bob") }

      it "returns a greeting in English" do
        expect(bob.greeting).to eql("Hello, my name is Bob.")
      end
    end

    context "when language is 'Italian'" do
      subject(:tony) { Person.new("Tony", "Italian") }

      it "returns a greeting in Italian" do
        # legacy syntax - the old DSL
        tony.greeting.should eql("Ciao, mi chiamo Tony.")
        # equivalent to:
        expect(tony.greeting).to eql("Ciao, mi chiamo Tony.")
      end
    end
  end
end
