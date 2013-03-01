# Coding dojo for Xtend #

## Overview ##

This is a simple coding dojo created to introduce the team I'm working with to the Xtend language.

It took about 4 hours for 5 people to run the first 3 katas using the proposed organization. Nobody except me knew Xtend beforehand, nor did they know about which katas we were going to be working on.

For more information about Xtend, visit the [Xtend Homepage][1].

## Suggested organization ##

1.  Prepare a room with one computer setup for development, and hooked up to a large screen (TV, projector, ...).
    This dojo was run with the following environment:
    * Windows 7
    * [Oracle JDK 1.6][2]
    * [Maven 2.2.1][3]
    * [Eclipse Juno (4.2)][4]
    * [Eclipse XTend plugin 2.3.1][1]
    
2.  Clone the repository to your workspace.

3.  Ensure the environment is working by testing the solutions:

        mvn clean test

4.  Remove the sources in the `*.solution` packages from the build.

5.  Explain to everyone attending how things will work:

    1.  They will be working in pair, in sessions of around 8 min.
    
    2.  Each session, there should be one pilot (who's the only one allowed to use the computer) and one copilot (who'll be sitting next to the pilot).
    
    3.  At the end of each session, the copilot becomes the pilot, and a new copilot takes his place.
    
    4.  This is not a competition; the emphasis is on trying to learn how everyone work and have fun discovering new things, rather than solving (very simple) problems the fastest way possible.

6.  For each kata

    1.  Explain what the kata is about by showing off the Java interfaces, the unit tests and answering questions.
    
    2.  Have a first round of sessions to build the solution in Java, validating it using the provided unit tests.
    
    3.  Debrief the solution. It should be the opportunity to clarify design choice and comment on the code. You can also use the provided solution for another perspective.
    
    4.  Explain the Xtend concepts they'll need to implement the Xtend solution.
    
    5.  Have another round of sessions to convert their solution into Xtend, validating it once again against the provided unit tests.
    
    6.  Debrief the solution. This should the opportunity to show off how certain Xtend features make the code clearer, how certain parts of the Java solution can be reworked in a different way to be more Xtend oriented.
    
## Katas ##

The included katas are:

1.  Hello world.

2.  Compute the mean value of a series of integers, applying filter to clean up the input.

3.  Compute the mean value of a series of integers represented in different formats.

4.  Build a text representation of the file system for a given path.

[1]: http://www.eclipse.org/xtend/
[2]: http://www.oracle.com/technetwork/java/index.html
[3]: http://maven.apache.org/
[4]: http://www.eclipse.org/
