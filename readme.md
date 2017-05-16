![](https://ga-dash.s3.amazonaws.com/production/assets/logo-9f88ae6c9c3871690e33280fcf557f33.png)

# Testing with RSpec

### Why is this important?

Test Driven Development leads to better code. TDD is extremely helpful when implimenting software according to predefined specifications and expectations. Previously, we've run tests and passed them; now, we'll see how to write them.

### What are the objectives?
*After this workshop, developers will be able to:*

- Justify writing unit tests.
- Explain important testing concepts: edge cases and test coverage.
- Read and explain Rspec tests.
- Write DRY and effective test code using RSpec.

### Where should we be now?
*Before this workshop, developers should already be able to:*

- Program in Ruby.
- Write code to pass existing tests.

## Do You Test?

#### Place yourselves somewhere in the following ranges:

* I have used TDD **or** I have never used TDD.

* I love the idea of TDD **or** I hate the idea of TDD.

#### Brainstorm:

* For those of you who are negative to testing, why? What did you or would you do instead?
* For those of you who are positive to testing, why? What problems did it solve?

<!-- <details><summary>Some possible responses...</summary>

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
-->

### Why Test?

As our applications increase in complexity, we need a saftey net. We need something to quickly ensure that we "do no harm" as we make changes. We need a battery of automated tests. These are specifications about YOUR code that you can run to ensure your code is doing what it should.

Think back to the way you code. You probably create a part of a web page, then browse to that page to test it to ensure that it is doing as you expect. Then you add another feature. Then test both features. Then you add a third feature and test. Have you ever had the experience of accidentally breaking an earlier feature?  Imagine if you had a battery of automated specs which run against your code so you can see if your new changes fit your new requirements *and* every requirement that came before this.

## Types of Tests 


**Unit tests** check the smallest units of code. Unit tests are intended to test individual methods to ensure a specific input results in a specific output. These are the tests we'll focus on today. 

**Integration Tests** combine components pr parts of an app together, sometimes just a few and other times the entire system.  They test the that components work together and that the interface between them is behaving as we expect.

**Acceptance tests** verify our apps at the level of user interaction. They test for behaviors that happen when users take an action like visiting a page, clicking a links, loggin in, etc.


### Test Process

You'll see the term **test coverage** pop up pretty often. People are always aiming for "100% test coverage". If your app has 100% test coverage, that means every single method in your app has one or more unit test verifying that it works.

>For instance, it's easy and free to write Salesforce apps. However, Salesforce will only add your app to its "app store" if you've obtained 100% test coverage and all tests are passing.

**What are the reasons testing is so important? Why would employers love it so much?**

We've asked you to write user stories. Writing unit tests is a very similar process.

When we think of "testing" we tend to think of something you do *after* you've created something. With unit tests, you're encouraged to write the tests *first* before you even start writing actual code.

## TDD Review

![TDD Example](http://joshldavis.com/img/tdd-vs-bdd/tdd-flowchart.png)

**Benefits**

* Fewer bugs in our code.

* Provides a clear goal in the development (make all tests pass).

* Allows for automation and continuous integration, ensuring that our application won’t break.

* A lot of time saved down the line! (Think about refactoring.)

**Drawbacks**

* Requires time and effort.

* Could be more costly to an organization when there are changes in requirements.

## What is RSpec?

**RSpec** is a Ruby  gem that makes it easier to write tests. 

## RSpec Example

Code is available in the example-tests directory: [example-tests](./example-tests)

When `rspec` is run in the `example-tests` directory, what does it show?

```
Finished in 0.00565 seconds (files took 0.14281 seconds to load)
5 examples, 0 failures
```
Let's review `spec/person_spec.rb`.  This is the specification for a `Person`.  It indicates how we can expect a Person to function.

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
    subject(:matt) { Person.new("Matt") }

    it "creates a new instance of class Person" do
      expect(matt).to be_an_instance_of(Person)
    end

    it "gives each instance a name attribute and accessor" do
      expect(matt.name).to_not be_nil
    end

    it "sets default language to 'English'" do
      expect(matt.language).to eq("English")
    end
  end

  describe "#greeting" do
    context "when language is English (the default)" do
      subject(:bob) { Person.new("Bob") }

      it "returns a greeting in English" do
        expect(bob.greeting).to eq("Hello, my name is Bob.")
      end
    end
    context "when language is 'Italian'" do
      subject(:tony) { Person.new("Tony", "Italian") }

      it "returns a greeting in Italian" do
        expect(tony.greeting).to eq("Ciao, mi chiamo Tony.")
      end
    end
  end
end
```

>What does `expect(matt).to be_an_instance_of(Person)` mean in regular English?

#### Think, pair, share: What aren't we testing? 

 Think like a developer. What code exists that we aren't testing? What examples would be good to clarify what our code can do?

###  Test Structure

Let's take a look at the structure of one test:

```ruby 
it "returns a greeting in English" do
  expect(bob.greeting).to eq("Hello, my name is Bob.")
end
```

We use `expect(_____)` to "wrap" the code we want to test, sometimes known as the Item Under Test. The `expect` method will run the code to get an **actual** value.   Then we chain on the `to` method (or sometimes `not_to`). This `to` method takes in a matcher method. The matcher method tells us about the **expected** behavior. 

> Item Under Test: `bob.greeting`

> Expectation: `expect(bob.greeting).to` 

> Matcher: `eq("Hello, my name is Bob.")`   

Take a few minutes to look through the RSpec documentation on [Built-in Matchers](https://www.relishapp.com/rspec/rspec-expectations/docs/built-in-matchers).  What are some matchers you think you will use?

## Creating a Unit Test with RSpec

We are going to be creating something similar to the above example. Instead of a `Person`,  we will be writing a spec for creating a new ruby class `Dog`.

### Set-up

Make a new directory `dog`, `cd` into it, and `touch` a `Gemfile`.

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

Realistically we'll want our `Dog` constant to be class that creates new dogs. So let's start specing it out. We'll first want to start describing it's `.new` method. In Ruby documentation and tests, it is convention to prefix class methods with `::` and instance methods with `#`.

**/spec/dog_spec.rb**

```ruby 
describe Dog do
  describe "::new" do
    # specs go here
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
      # expectations here
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


>What is the minimal amount of code we can write in `models/dog.rb` to pass our current expectation?

## More expectations!


### Naming your Dog

Let's give our dog instances the method to get and set an attribute `name`. Start with the specfication.

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

>What is the minimal code one could write to pass this test?

### Check for Understanding: Hungry Dog

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

### Feeding the Dog

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

### Check for Understanding: Teach the Dog to Eat

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

### Context

Image we want the eat method to behave differently in different contexts. For example if the dog is not hungry and has a `hunger_level` of `0`, we don't want the eat method to continue decrementing.   This is an important **edge case** to consider!

In order to setup different scenarios or contexts in our specifications, we can use the `context` keyword. Generally, context blocks are "nice to have" (not must-have) in testing and improve organization and readability.

Use `describe` for items under tests and `context` for different states that the items or application could be in.


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

### Check for Understanding: Don't Over Eat

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

## Refactoring

Do you see any opportunities to refactor? Identify them...

```ruby
describe Dog do
  describe "::new" do
    it "initializes a new dog" do
      dog = Dog.new
      expect(dog).to be_a(Dog)
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

### Subject Blocks

We could use `before`, `let`, or `subject` to help us refactor these specifications. Let's prefer using `subject` as the dog is the subject, or thing we are testing. `let` is similar, but may be used when one wants to set up a variable that isn't necessarily the subject, for example it could be the food the dog is eating. Whereas `let` and `subject` are used to setup "dependencies", `before` which is best used to setup an action in advance, such as opening a connection with a database.

```ruby
describe Dog do
  # refactors the tests with subject
  subject(:dog) { Dog.new }
  describe "::new" do
    it "initializes a new dog" do
      expect(dog).to be_a(Dog)
    end
  end
  describe "#name" do
    it "allows the reading and writing of a name" do
      dog.name = "Fido"
      expect(dog.name).to eq("Fido")
    end
  end
  describe "#name" do
    it "allows the reading and writing of a hunger level" do
      dog.hunger_level = 5
      expect(dog.hunger_level).to eq(5)
    end
  end
  describe "eat" do
    context "when the dog is hungry" do
      it "decrements the hunger level when invoked" do

        dog.hunger_level = 5
        dog.eat
        expect(dog.hunger_level).to eq(4)
      end
    end
    context "when the dog is full" do
      it "doesn't decrement the hunger level when invoked" do

        dog.hunger_level = 0
        dog.eat
        expect(dog.hunger_level).to eq(0)
      end
    end
  end
end
```

### Before Blocks

We can further refactor the above code with a `before` block in order to setup the state of our dog by calling a few methods on it.

```ruby
describe Dog do
  subject(:dog) { Dog.new }
  before do
    dog.name = "Fido"
    dog.hunger_level = 5
  end
  describe "::new" do
    it "initializes a new dog" do
      expect(dog).to be_a(Dog)
    end
  end
  describe "#name" do
    it "allows the reading and writing of a name" do
      expect(dog.name).to eq("Fido")
    end
  end
  describe "#name" do
    it "allows the reading and writing of a hunger level" do
      expect(dog.hunger_level).to eq(5)
    end
  end
  describe "eat" do
    context "when the dog is hungry" do
      it "decrements the hunger level when invoked" do
        dog.eat
        expect(dog.hunger_level).to eq(4)
      end
    end
    context "when the dog is full" do
      it "doesn't decrement the hunger level when invoked" do
        dog.hunger_level = 0
        dog.eat
        expect(dog.hunger_level).to eq(0)
      end
    end
  end
end
```

>Note: you can pass different options to before.
>
>**before(:each)** is a block of code that runs every time *before each* test is execute.
>
>**before(:all)** is the same concept, except it only runs **once**, *before all* the tests inside it have started.

## Check for Understanding: Cereal Robot 

[Watch this video](https://www.youtube.com/watch?v=E2evC2xTNWg).

Split up into groups of 4. For 15 minutes, on a whiteboard, work with your group to draft the unit tests for this cereal-delivering robot.

Goal: Pseudocode tests so that when all the tests pass, we'll know the robot works. However, you're only writing **pending** tests -- don't actually write the code that would make the tests pass.

Constraints: Try to write everything as `describe`, `context`, and `it` blocks. Method names should start with `#`.


## Closing Thoughts

- What is the purpose Unit testing?
- Explain what role RSpec plays in testing.
- Why should we test our code on the inputs that will be most common for our app?
- Why should we test our code with edge cases?  
- Why might we test error cases?

### Resources
- RSpec docs on [the basic structure of a test](https://www.relishapp.com/rspec/rspec-core/v/3-5/docs/example-groups/basic-structure-describe-it)
- RSpec docs on [expectations](http://www.relishapp.com/rspec/rspec-expectations/docs)  
- RSpec docs on [Built-in Matchers](https://www.relishapp.com/rspec/rspec-expectations/docs/built-in-matchers)
- Talk by Sandi Metz on [The Magic Tricks of Testing](https://www.youtube.com/watch?v=URSWYvyc42M)
- [Better Specs](http://betterspecs.org/) guidelines
- [RSpec Cheatsheets](https://www.anchor.com.au/wp-content/uploads/rspec_cheatsheet_attributed.pdf)
