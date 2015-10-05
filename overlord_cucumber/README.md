## Super Villain's Detonation Device

You've been contacted by a super villain in search of help. He says he has a great idea, and needs only your genius to bring it to completion. Turns out the idea is going to be a bomb. I mean, literally. It's a bomb. Still, he's offering equity.

One tricky problem is that bombs are quite expensive to debug in prod. To avoid an embarrassing dud, you're going to develop and test the bomb in the relative safety of your own workshop (desk, really). Thankfully, you've got requirements, so mostly this is just an exercise of translating those requirements into working tests and then writing the software to control the bomb. 

### Requirements

1. Even coffee machines have webservers these days. The bomb interface should be a Sinatra app, and the tests should be written in Cucumber and Rspec. A simple Sinatra base has been provided.
2. The bomb interface should include a field to type in an activation / deactivation code and an indicator of the activation state of the bomb.
3. When the super villain first boots the bomb, it should not be activated. The bomb can be booted with or without activation/deactivation codes specified.
4. The activation code is pretty simple:
  * The code should be configurable on boot. If no code is specified, 1234 seems pretty safe. Validate that only numeric inputs are allowed.
  * When the correct activation code is entered, the bomb should activate. Putting in the same activation code again should have no effect. From now on, the status indicator should let the user know that the bomb is active.
5. Next, the deactivation code.
  * This code should be configurable as well. A good default code would be 0000.
  * Once the bomb is active, putting in the correct deactivation code should cause the bomb to revert to inactivity, and indicate as such.
  * If a user puts in the wrong deactivation code three times, the bomb should explode. I'm not really sure what the interface would look like for this, since the bomb is exploded and all, but let's just indicate it somehow to be sure.
  * Once a bomb has exploded, none of the buttons work anymore. Obv.
![Bomb Lifecycle](/overlord_cucumber/img/overlord_bomb.png)

### Getting Started
Make sure you have the following installed:
* [Ruby v2.2.2](https://www.ruby-lang.org/en/documentation/installation/) Note: The gems [ruby-install](https://github.com/postmodern/ruby-install) and [chruby](https://github.com/postmodern/chruby) are very helpful in managing Ruby versions. 
* [Git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)
* Bundler gem - run `gem install bundler` to install
* Text editor of your choice ([Sublime](http://www.sublimetext.com/2) is a good one)

Clone this repository into a folder to download the Cucumber exercises:
```
git clone https://github.com/vconcepcion/level_up_exercises.git
```

Navigate to the overlord_cucumber directory:
```
cd level_up_exercises/overlord_cucumber
```

Install dependencies:
```
bundle install
```

Start the app:
```
ruby overlord.rb
```

You should get some output as follows:
```
[2015-10-03 22:07:38] INFO  WEBrick 1.3.1
[2015-10-03 22:07:38] INFO  ruby 2.2.2 (2015-04-13) [x86_64-darwin14]
== Sinatra/1.4.5 has taken the stage on 4567 for development with backup from WEBrick
[2015-10-03 22:07:38] INFO  WEBrick::HTTPServer#start: pid=74461 port=4567
```

In a browser go to http://localhost:4567 (note: the port number in the URL will be specified in the above output but should default to 4567). If the app is properly up and running, you should see the following page.

![Bomb Config Screen](/overlord_cucumber/img/bomb_config_screen.png)

Back in terminal (ctrl-c to quit the overlord app), run:
```
bundle exec cucumber features/test.feature
```

If run successfully, you should see the following output:
```
Feature: Test
  As a meetup attendee
  I want to verify that I can run Cucumber tests
  So that I don't waste time installing stuff at the meetup

  Scenario: Running a test                       # features/test.feature:6
    Given I have followed the setup instructions # features/step_definitions/test_steps.rb:3
    When I run this test                         # features/step_definitions/test_steps.rb:6
    Then it should pass                          # features/step_definitions/test_steps.rb:9

1 scenario (1 passed)
3 steps (3 passed)
```

If you see the above output, you're all set.

### Credit/Thanks
Sinatra app written by Dan Kotowski - https://github.com/djkotowski

