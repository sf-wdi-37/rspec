![](https://ga-dash.s3.amazonaws.com/production/assets/logo-9f88ae6c9c3871690e33280fcf557f33.png)

# Testing with RSpec

### Why is this important?

Test Driven Development leads to better code. TDD is extremely helpful when implimenting software according to predefined specifications and expectations. Previously, we've run tests and passed them; now, we'll see how to write them.

### What are the objectives?
*After this workshop, developers will be able to:*

- Write unit tests using RSpec using `expectations` and `matchers`
- Compare and contrast common RSpec terms including `"describe"`, `"it"`, `"context"`, `before(:each)`, `before(:all)`, `"subject"`,  `"let"`
- Write and pass unit tests using RSpec

### Where should we be now?
*Before this workshop, developers should already be able to:*

- Program in Ruby
- Pass tests in a TDD manner

## Do You Test?

We first encountered Test Driven Development during Unit 2, when we ran & passed unit tests in Ruby using RSpec.

####Place yourselves somewhere in the following ranges:

* I have used TDD **or** I have never used TDD

* I love the idea of TDD **or** I hate the idea of TDD

####Thoughts:

* For those of you who are negative to testing, why? What did you or would you do instead?
* For those of you who are positive to testing, why? What problems did it solve?

<details><summary>Some possible responses...</summary>

* Cons
 * **Time.** It's a waste of my time and effort to test.
 * **It's too much.** I can test just fine using the console.
 * **App complexity.** My app is too simple to require testing.
* Pros
 * **Bug detection.** Quickly identify unanticipated errors.
 * **Code Quality.** Create standards for our code before writing it.
 * **Time.** Shorten development time through bug detection; allows for [continuous integration](https://en.wikipedia.org/wiki/Continuous_integration).
 * **Documentation.** Tests act as a documentation of sorts for how our code should work. Helpful to other developers and shareholders.
 * **Jobs.** Testing is a job requirement across the board.

</details>

## Unit vs Acceptance Tests

**Unit tests** check the smallest level; the functionality of a specific method.

**Acceptance tests** verify our apps at the level of user interaction; testing for things when users take an action like visiting a page, clicking a links, loggin in, etc.  

  * The "units" in unit tests are individual methods. Unit tests are intended to test small, little blocks of code, and make sure a specific input results in a specific output.

  * Acceptance tests have a much wider focus. You'd use acceptance testing to make sure a sign-in form works, or that a user who doesn't have admin privileges can see this page, while a user who does have admin privileges can see that page.

Unit testing always should come before acceptance testing.

You'll see the term **test coverage** pop up pretty often. People are always aiming for "100% test coverage". If your app has 100% test coverage, that means every single method in your app has a unit test verifying that it works.

>For instance, while it's easy and free to write Salesforce apps, Salesforce will only add your app to its "app store" if you've obtained 100% test coverage, and Salesforce's developer team can run your tests and have them all pass.

**What are the reasons testing is so important? Why would employers love it so much?**

We've asked you to write user stories. Writing unit tests is a very similar process. In fact, user

When we think of "testing" we tend to think of something you do *after* you've created something. With unit tests, you're encouraged to write the tests *first* before you even start writing actual code.

## TDD Review

![TDD Example](http://joshldavis.com/img/tdd-vs-bdd/tdd-flowchart.png)

**Benefits**

* Fewer bugs in our code

* Provides a clear goal in the development, that is, to make all tests to pass.

* Allows for automation and continuous integration, ensuring that our application won’t break

* A little more time upfront means a lot of time saved down the line! (Think about refactoring)

**DrawBacks**

* Requires time and effort.

* Could be more costly to an organization when there are changes in requirements.

## What is RSpec?

**RSpec** is a testing framework for the Ruby programming language.

RSpec makes it easier to write tests. Essentially it's a Domain Specific Language for writing live specifications about your code.  It was released on May 18, 2007, so it's been around for a while.

> A DSL, "Domain Specific Language", is created specifically to solve problems in a particular domain and is not intended to be able to solve problems outside of it. Other DSLs include HTML or SQL. This is opposed to domain independent languages like Java, C++, Ruby, Python, PHP, JavaScript, Clojure, Rust, Scala, Erlang etc that are Turing complete (can solve any possible computation problem).

## RSpec Example

Code is available here: [example-tests](./example-tests)

When `rspec` is run in the `example-tests` directory, what does it show?

```
Finished in 0.00565 seconds (files took 0.14281 seconds to load)
5 examples, 0 failures
```
Let's review `spec/person_spec.rb`.  This is the specification for a Person.  It indicates how we can expect a Person to function.

```
rspec_person_example/
├── models
│   └── person.rb
└── spec
    ├── person_spec.rb
    └── spec_helper.rb

2 directories, 3 files
```

We have a Person model and a Person spec (a specification or test). This is the typical RSpec convention.  Specs live under the spec directory and echo the models in our system with the `_spec` suffix.

Let's look further into `person_spec.rb`

```ruby
# This first line is a reference to our library code.  We need to access to the classes we have written in Ruby to write our tests!

require_relative '../models/person'  # a reference to our code

describe Person do
  describe "Constructor" do
    before(:each) do
      @matt = Person.new("Matt")
    end

    it "should create a new instance of class Person" do
      expect(@matt).to be_an_instance_of(Person)
    end

    it "should have a name" do
      expect(@matt.name).to_not be_nil
    end

    it "should default #language to 'English'" do
      expect(@matt.language).to eq("English")
    end
  end

  describe "#greeting" do
    context "for default language (English)" do
      subject(:bob) { Person.new("Bob") }

      it "should offer a greeting in English" do
        expect(bob.greeting).to eql("Hello, my name is Bob.")
      end
    end

    context "when language is 'Italian'" do
      subject(:tony) { Person.new("Tony", "Italian") }

      it "should offer a greeting in Italian" do
        # legacy syntax - the old DSL
        tony.greeting.should eql("Ciao, mi chiamo Tony.")
        # equivalent to:
        # expect(tony.greeting).to eql("Ciao, mi chiamo Tony.")
      end
    end
  end
end
```
>What does `expect(@matt).to be_an_instance_of(Person)` mean in regular English?

## Creating a Unit Test using RSpec

We are going to be creating something similar to the above example. Instead we will be writing a spec for creating a new ruby class of `Dog`

### Set-up

Make a new directory `dog`, `cd` into it and `touch` a `Gemfile`.

#### Install RSpec

The first thing we'll do is install a gem called RSpec. To do this, just add `gem 'rspec'` to the `Gemfile`:

```rb
source "https://rubygems.org"

gem 'rspec'
```

Then, in your Terminal:

```sh
$ bundle install
$ rspec
```

>After running `rspec`, you should get a message saying "No examples found." When it says "examples", it means "tests". It's saying, "You haven't written any tests for me to run!"

#### Set up the directory

Enter the command `rspec --init`. What just happened?

* a `spec` directory was created, where the tests will live
* an `.rspec` file was created, where one can specify options on how the tests are displayed
* a `spec/spec_helper.rb` is created, which ensures the tests are run with the correct requirements and configurations

Inside the `spec` directory and add a file called `dog_spec.rb`. Additionally, create a `models` directory and a file inside it, `dog.rb`, where we will define our class `Dog`.

>Note: Within `.rspec` file add `--color` OR in `spec/spec_helper.rb` add `config.color = true` to see colorful tests!

### Writing our Specification

Let's start defining the design of our program with certain specifications. Let's spec out our `Dog` with some psuedocode.

**/spec/dog_spec.rb**

```rb
require_relative "../models/dog"
describe Dog do

end
```

We will specing-out or `describe` our `Dog`. A `describe` block is commonly used to split up a set of tests into sections about a certain set of tests will be focused on.

Now let's run `rspec`. What happened? Does the file it's require exist?

Make the file and run the tests again. What happens this time? Does the constant `Dog` exist? Let's give it just enough code to satisfy the current (minimal) specifications.

**/models/dog.rb**

```ruby
Dog = Object.new
```

Realistically we'll want our `Dog` constant to be class that creates new dogs. So let's start specing it out. We'll first want to start describing it's `.new` method. Remember, in Ruby documentation it is convention to prefix class methods with `::` and instance methods with `#`.

**/spec/dog_spec.rb**

```ruby 
describe Dog do
  describe "::new" do
    # specs to come
  end
end
```

Now we can start writing out some specifications related to the `new` method using and `it` block

```ruby 
describe Dog do
  describe "::new" do
    it "initializes a new dog"
  end
end
```

What is is the output now? We should get `1 example, 0 failures, 1 pending`, saying that our specification is not yet implimented.

Now add `do` at the end of the first `it` line.

```ruby 
describe Dog do
  describe "::new" do
    it "initializes a new dog" do
      #specs to come...
    end
  end
end
```

>Run `rspec` again. Our tests passed because RSpec will evaluate a test as passing as long as no errors are thrown.

Let's make our specs actually test something.

```ruby 
describe Dog do
  describe "::new" do
    it "initializes a new dog" do
      dog = Dog.new
      expect(dog).to be_a(Dog)
    end
  end
end
```

> Expectation: `expect(dog).to` 

> Matcher: `be_a(Dog)`

We use the pattern `expect(IUT)` to "wrap" the ***Item Under Test***, so that it supports the `to` method which accepts a matcher. Here we are wrapping an object or block in expect, call to or to_not (aliased as not_to) and pass it a matcher object

[RSpec documentation Built in Matchers](https://www.relishapp.com/rspec/rspec-expectations/docs/built-in-matchers)

>What is the minimal amount of code we can write in `models/dog.rb` to pass our current expectation?

##More expectations!


###Naming your Dog

Let's give our dog instances the method to get and set an attribute `name`. Obviously let's first start with the specfication.

```ruby
describe Dog do
  #...
  describe "#name" do
    it "allows the reading and writing of a name" do
      dog = Dog.new
      dog.name = "Fido"
      expect(dog.name).to eq("Fido")
    end
  end
end
```

>What is the minimal code one could write to pass these specifications?

### Challenge: Hungry Dog

Add an expectation to the dog that, "allows the reading and writing of a hunger level". When complete, ensure the tests are writing correctly by watching them fail. Finally implement the code that passes the new expectation.

<details><summary>Example solution</summary>

**/spec/dog_spec.rb**

```ruby
describe Dog do
  #...
  describe "#name" do
    it "allows the reading and writing of a hunger level" do
      dog = Dog.new
      dog.hunger_level = 5
      expect(dog.hunger_level).to eq(5)
    end
  end
end
```

**/models/dog.rb**

```ruby
class Dog
  #...
  attr_accessor :hunger_level

end
```

</details>

###Feeding the Dog

Let's impliment a method `eat` which decrements a dog's hunger level when invoked. How would we translate this specification in RSpec tests?

**/spec/dog_spec.rb**

```ruby
describe Dog do
  #...
  describe "eat" do
    it "decrements the hunger level when invoked" do
      dog = Dog.new
      dog.hunger_level = 5
      dog.eat
      expect(dog.hunger_level).to eq(4)
    end
  end
end
```

###Challenge: Teach the Dog to Eat

Write the code that passes the above specifications.

<details><summary>Example solution</summary>

**/models/dog.rb**

```ruby
class Dog
  #...
  def eat
    self.hunger_level -= 1
  end
end
```

</details>

###Context

Image we want the eat method to behave differently in different contexts. For example if the dog is not hungry and has a `hunger_level` of `0`, we don't want the eat method to continue decrementing. In order to setup different scenarios or contexts in our specifications, we can use the `context` keyword. Generally, context blocks are a *"nice to have"* in testing and improve **organization** and **readability**.

Use `describe` for "things" and `context` for "states.


**/spec/dog_spec.rb**

```ruby
describe Dog do
  #...
  describe "eat" do
    context "when the dog is hungry" do
      it "decrements the hunger level when invoked" do
        dog = Dog.new
        dog.hunger_level = 5
        dog.eat
        expect(dog.hunger_level).to eq(4)
      end
    end
    context "when the dog is full" do
      it "doesn't decrement the hunger level when invoked" do
        dog = Dog.new
        dog.hunger_level = 0
        dog.eat
        expect(dog.hunger_level).to eq(0)
      end
    end
  end
end
```

###Challenge: Don't Over Eat

Write the code to pass the above specs!

<details><summary>Example solution</summary>

**/models/dog.rb**

```ruby
class Dog
  #...
  def eat
    self.hunger_level -= 1 if hunger_level > 0
  end
end
```

</details>

##Refactoring with `before` blocks

Do you see any opportunities to refactor? Identify them...

```ruby
describe Dog do
  describe "::new" do
    it "initializes a new dog" do
      rover = Dog.new
      expect(rover).to be_a(Dog)
    end
  end
  describe "#name" do
    it "allows the reading and writing of a name" do
      dog = Dog.new
      dog.name = "Fido"
      expect(dog.name).to eq("Fido")
    end
  end
  describe "#name" do
    it "allows the reading and writing of a hunger level" do
      dog = Dog.new
      dog.hunger_level = 5
      expect(dog.hunger_level).to eq(5)
    end
  end
  describe "eat" do
    context "when the dog is hungry" do
      it "decrements the hunger level when invoked" do
        dog = Dog.new
        dog.hunger_level = 5
        dog.eat
        expect(dog.hunger_level).to eq(4)
      end
    end
    context "when the dog is full" do
      it "doesn't decrement the hunger level when invoked" do
        dog = Dog.new
        dog.hunger_level = 0
        dog.eat
        expect(dog.hunger_level).to eq(0)
      end
    end
  end
end
```

How many times are we writing `dog = Dog.new`? It seems we'll have to do that at the beginning of most specifications.

We could use `before`, `let`, or `subject` to help us refactor these specifications. Let's prefer using `subject` as the dog is the subject, or thing we are testing. `let` is similar, but may be used when one wants to set up a variable that isn't necessarily the subject, for example it could be the food the dog is eating. Whereas `let` and `subject` are used to setup "dependencies", `before` which is best used to setup an action in advance, such as opening a connection with a database.

```ruby
describe Dog do
  
  describe "attributes of a dog" do
    it "has the class Dog" do
      expect(@dog).to be_a(Dog)
    end
    it "has a String for an Name" do
      expect(@dog.name).to be_a(String)
    end
    it "has an Integer for a hunger level" do
      expect(@dog.hunger_level).to be_a(Integer)
    end
  end

  describe "#set_hunger_level" do
    context "when new hunger level" do
      context "is less than 0" do
        it "sets the hunger level to 0" do
          @dog.set_hunger_level(-1)
          expect(@dog.hunger_level).to eq(0)
        end
      end
      context "is greater than 0" do
        it "sets our hunger level to the new hunger level" do
          @dog.set_hunger_level(5)
          expect(@dog.hunger_level).to eq(5)
        end
      end
    end

  end
end
```

##BEFORE & CONTEXT SET HUNGER LEVEL

**before:each** is a block of code that runs *before each* test inside it. Try adding a `puts "*" * 50` inside `before:each`, then running `rspec`. You should see two lines of asterisks pop up.

**before:all** is the same concept, except it only runs **once**, *before all* the tests inside it have started.

### `before` vs `subject`

Now replace the code with this:

```rb

describe Dog do

  subject(:dog) do
    dog = Dog.new("Rover", 10)
  end

  describe "attributes of a dog" do
    it "has the class Dog" do
      expect(dog).to be_a(Dog)
    end
    it "has a String for an Name" do
      expect(dog.name).to be_a(String)
    end
    it "has an Integer for a hunger level" do
      expect(dog.hunger_level).to be_a(Integer)
    end
  end

  describe "#set_hunger_level" do
    context "when new hunger level" do
      context "is less than 0" do
        it "sets the hunger level to 0" do
          dog.set_hunger_level(-1)
          expect(dog.hunger_level).to eq(0)
        end
      end
      context "is greater than 0" do
        it "sets our hunger level to the new hunger level" do
          dog.set_hunger_level(5)
          expect(dog.hunger_level).to eq(5)
        end
      end
    end

  end
end

```
What changed?  We've identified that "dog" is the "subject under test", converting the instance variable (@dog) into the "subject" helper.  This method takes a name (:dog) and block of code that returns the subject (a new Dog with a name of Rover and hunger level of 10).  It provides a method, named "dog", that we now use throughout our spec.  

This is a way of ensuring the subject is available in every test, just like `before:each` and `before:all`. What's the difference? `subject` is semantic.

Interestingly, we could also replace each use of "dog" with "subject".

### `let`

RSpec also provides a "let" helper, which works the same way.  You can use it to identify other important components of the specification.

`let` is "lazy-evaluated", only evaluated when directly called upon and value is cached the first time

You can have `subject`, `let`, and `before:each` right next to each other.

## Garnet Example

RSpec is used to test Garnet, the attendance/homework tracking app. Before any changes get pushed up to our live server, they have to pass all the tests -- an automated system rejects the changes if they don't pass.

[Here's what that looks like. Seem familiar?](https://travis-ci.org/ga-dc/garnet/builds/89503768#L241) Clearly there are a lot of tests that are just pending and don't do anything yet -- almost 60!

## Challenge: Let's Go Shopping

**Instructions:**

 * Fork and Clone the following repo:
[rspec-shopping-exercise](https://github.com/ga-wdi-exercises/rspec-shopping-exercise/tree/master)

  > Don't forget to run bundle install!

 * Take a look at the `product.rb model`. Write unit tests in `product_spec.rb` to to test the methods it contains

 * You might need to refer to the RSpec documentation linked below for additional matchers to use when writing your tests

  [RSpec documentation Built in Matchers](https://www.relishapp.com/rspec/rspec-expectations/docs/built-in-matchers).  Make sure you are on the version that corresponds to your installed library (v3.3).

## The Flow

Most testing frameworks, including RSpec, follow this flow:

  - Setup
  - Run
  - Teardown

Think `Red/Green/Refactor`

* Each spec should run in isolation.  


## Challenge: Cereal Robot Exercise

[Watch this video.](https://www.youtube.com/watch?v=E2evC2xTNWg)

Split up into groups of 4. For 15 minutes, on a whiteboard, work with your group to draft the unit tests for this cereal-delivering robot.

Goal: When all the tests pass, that means the robot works. However, you're only writing **pending** tests -- don't actually write the code that would make the tests pass.

Constraints: Try to write everything as `describe`, `context`, and `it` blocks. Method names should start with `#`.

## Closing

### Quiz Questions:

- What is the purpose Unit testing?
- How does Unit testing compare to Functional testing?
- Explain what role RSpec plays in testing.
- Describe TDD Cycle/Mantra
- Explain what is RSpec's basic syntax. Specially how does `describe` and `context` differ?

<details><summary>Sample answers</summary>

1. Design/architecture/maintainability/fewer bugs.
2. Unit tests are intended to test small, little blocks of code, and make sure a specific input results in a specific output. They are useful for us as developers. Functional tests verify our apps at the level of user interaction.  They visit web pages, click on links, validate the DOM.  
3. RSpec is a testing framework for the Ruby, makes writing tests much more simple for us as developers! We can use Rspec to write unit tests.
4. Red, Green, Refactor.  We write a test that fails, indicating that the feature is not supported.  Then, we adjust code until it passes (turns Green).  Lastly, we refactor our app using the knowledge we gained from supporting the spec.
5. "Describe" and "Context" FUNCTIONALLY do the same thing (context is an alias of describe) The difference is the intent they express.
"```describe```" indicates what I'm testing, typically a class or the name of a method while " ```context```" indicates a specific set of circumstances that effect the test (think WHEN!).

</details>

### Additional Resources
- [Structure of RSpec Tests](http://jakegoulding.com/presentations/rspec-structure/)
- [Better Specs](http://betterspecs.org/)
- [Code School RSpec](https://www.codeschool.com/courses/testing-with-rspec)
- [RSpec Cheatsheets](https://www.anchor.com.au/wp-content/uploads/rspec_cheatsheet_attributed.pdf)
