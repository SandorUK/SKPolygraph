SKPolygraph
===========

What is this?
-------------

This is a CocoaPod that can be used for simple sentiment analysis of an English text.
Sentiment analysis aims to determine the attitude of a speaker or a writer with respect to some topic or the overall contextual polarity of a text. Simply put it tells you whether the text is "happy" or "sad".

For instance "It was a good sunny day" will score 2.0 points, meaning it is a positive text and "It was rainy and cold day" will be graded as negative.


How to use it?
--------------

Install using [CocoaPods](http://cocoapods.org/). 
	pod SKPolygraph

Include SKPolygraph in your code
	#include "SKPolygraph.h"

Sample usage to get sentimental score for text
	float score = [[SKPolygraph sharedInstance] analyseSentiment:@"It was cold and rainy."];

You can also analyse a single word. For that you need to include SKWord.h. Use it like this:
	SKWord *word = [[SKPolygraph sharedInstance] analyseSentimentOfWord:@"cold"];

See sample project unit tests for more examples.

Known Issues
--------------

The dictionary used for analysis is taken from http://www.cs.uic.edu/~liub/FBS/sentiment-analysis.html thus it is very basic, providing only negative -1.0 and positive 1.0 values. 

In future versions I plan to use more complex dictionaries with more gradation of values

The dictionary used for analysis is taken from http://www.cs.uic.edu/~liub/FBS/sentiment-analysis.html thus it is very basic, providing only negative -1.0 and positive 1.0 values. 

In future versions I plan to use more complex dictionaries with more gradation of values.
