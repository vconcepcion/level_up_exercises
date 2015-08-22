## Super Villain's Detonation Device

You've been contacted by a super villain in search of help. He says he has a great idea, and needs only your genius to bring it to completion. Turns out the idea is going to be a bomb. I mean, literally. It's a bomb. Still, he's offering equity.

One tricky problem is that bombs are quite expensive to debug in prod. To avoid an embarrassing dud, you're going to develop and test the bomb in the relative safety of your own workshop (desk, really). Thankfully, you've got requirements, so mostly this is just an exercise of translating those requirements into working tests and then writing the software to control the bomb. 

But, this is the important part: you're going to write the tests for the device before you write the app code. You cleverly realize that by writing the tests the way you'd like the code to work, you'll make your resulting code that much better. Well done, smartie.

### Requirements

1. The bomb interface should have a method to enter in an activation / deactivation code and method(s) to indicate the activation state of the bomb.
2. When the super villain first boots the bomb, it should not be activated.
3. The activation code is pretty simple:
  * The code should be configurable on boot. If no code is specified, 1234 seems pretty safe. Validate that only numeric inputs are allowed.
  * When the correct activation code is entered, the bomb should activate. Putting in the same activation code again should have no effect. From now on, the status indicator should let the user know that the bomb is active.
4. Next, the deactivation code:
  * This code should be configurable as well. A good default code would be 0000.
  * Once the bomb is active, putting in the correct deactivation code should cause the bomb to revert to inactivity, and indicate as such.
  * If a user puts in the wrong deactivation code three times, the bomb should explode. I'm not really sure what the interface would look like for this, since the bomb is exploded and all, but let's just indicate it somehow to be sure.
  * Once a bomb has exploded, none of the buttons work anymore. Obv.

### Getting Started

Clone this repository to pull down the Overlord RSpec exercises:
```
git clone git@github.com:vconcepcion/level_up_exercises.git
```

Navigate to the overlord_rspec directory:
```
cd level_up_exercises/overlord_rspec
```

Run the bomb specs:
```
rspec spec/bomb_spec.rb
```

If run successfully, you should see some output containing the following:
```
....
Finished in 0.01584 seconds (files took 0.31828 seconds to load)
16 examples, 8 failures, 6 pending
...
```

Try running just the practice specs:
`rspec spec/bomb_spec.rb --tag practice`

```
...
Finished in 0.00279 seconds (files took 0.0981 seconds to load)
9 examples, 3 failures, 6 pending
...
```
If you see the above output, you're all set.

### Instructions
Follow the steps below to get all the exercises in `spec/bomb_spec.rb` to pass. Do not proceed to the next exercise until all the previous ones have passed.

####Exercise #1 - Expectations
Type the following command to run the test:
```
rspec spec/bomb_spec.rb --tag exercise:1
```

Modify the code in the `bomb.rb` file to make the test pass.

Can you think of a way to rewrite the following expectation?
```
expect(bomb.status).to eq(:inactive)
```
Hint: Check out the first example under the [Predicate matchers](https://github.com/rspec/rspec-expectations#predicate-matchers) section of the RSpec Expectations page.

####Exercise #2 - Red -> Green -> Refactor
Run the test. Notice that this test is pending and has not yet been implemented.

```
Pending: (Failures listed here are expected and do not affect your suite's status)

  1) Bomb when it is inactive is activated if the correct activation code is entered
     # Not yet implemented
     # ./spec/bomb_spec.rb:14

Finished in 0.00042 seconds (files took 0.23126 seconds to load)
1 example, 0 failures, 1 pending
```

Try writing the test based on its description.

If written properly, the test should fail at first. Once you have the test failing, modify the code in the `bomb.rb` file to make it pass.

####Exercise #3 - Expecting Change (or no change)
Complete the test using the [matcher for expecting no change](https://www.relishapp.com/rspec/rspec-expectations/v/2-0/docs/matchers/expect-change#expecting-no-change): `expect { ... }.to_not change { ... }`.

Hint: What action is taking place? What attribute of the bomb will remain unchanged?

Make sure the test passes before continuing.

####Exercise #4 - Expecting Measurable Change
Write a test that uses the [matcher for expecting change](https://www.relishapp.com/rspec/rspec-expectations/v/2-0/docs/matchers/expect-change#expecting-change) to test that the remaining attempts is lowered by 1 if the wrong deactivation code is entered: `expect { ... }.to change { ... }.by(...)`.

Hint: What action is taking place? What attribute of the bomb will be changed as a result, and by how much?

If written properly, the test should fail at first. Once you have the test failing, modify the code in the `bomb.rb` file to make it pass.

####Exercise #5 - Expecting Messages
Write a test that uses the [matcher for expecting a message](https://www.relishapp.com/rspec/rspec-mocks/v/2-14/docs/message-expectations/expect-message-using-expect#expect-a-message) to test that the bomb "receives the explode message" when the wrong deactivation code is entered three times: `expect(...).to receive(...)`.

If written properly, the test should fail at first. Once you have the test failing, modify the code in the `bomb.rb` file to make it pass.

####Exercise #6 - Before Hooks
Run the test. Notice that it is failing because there's nothing in the test yet that would cause the bomb to explode.

Instead of updating the contents of the `it 'indicates that it is out-of-service'` block, update the contents of the [before block](https://www.relishapp.com/rspec/rspec-core/v/2-2/docs/hooks/before-and-after-hooks#define-before(:each)-block).
```
before do
  # TODO make the bomb explode
  # ...
end
```

Make sure the test passes before continuing.

####Exercise #7 - Expecting errors
This test uses the [raise_error matcher](https://www.relishapp.com/rspec/rspec-expectations/v/2-7/docs/built-in-matchers/raise-error-matcher#expect-specific-error).

```
expect {
  # TODO do something here that will raise an input error
  # ...
}.to raise_error(InvalidInputError)
```

Given the test description, complete the test so that it passes.

####Exercise #8 - Expecting errors
Write a test similar to the previous exercise that tests that an `InvalidInputError` is raised when the non-numeric code '1234!' is entered.

Make sure the test passes before continuing.

####Exercise #9 - Expecting errors
Follow the `it 'validates the configured activation code'` example to write a spec that tests that an `InvalidInputError` is raised when a Bomb is initialized with an invalid (non-numeric) deactivation code.

If written properly, the test should fail at first. Once you have the test failing, modify the code in the `bomb.rb` file to make it pass.

####Bonus
Read up on some RSpec guidelines at [Better Specs](http://betterspecs.org). Try to apply some of these techniques to your tests.

###Solution
You may view a full solution on the [overlord_rspec](https://github.com/vconcepcion/level_up_exercises/tree/overlord_rspec/overlord_rspec) branch of this repo.
