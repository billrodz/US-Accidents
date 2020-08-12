# US Accidents
 US Accident Data

# Intro & Team 

I'm Carlos Mercado, I'm a Senior Data Scientist at a global consulting firm based 
in Washington D.C. I've worked extensively in R and R Shiny, especially in 
public health. 

I'm William Rodriguez ... 

We've known each other for over 15 years and we've recently begun working 
together to practice R and data science. We're recording our lessons and open 
sourcing projects to provide applicable material to the data science community. 
We hope you enjoy these projects! 

# Data 

US Accidents ... (include link to documentation, include citation from 
curator.) 

# Experiment Design & Hypothesis

This experiment was designed prior to data exploration and modeling. We hope 
we're right, but we'd be excited to be wrong! 

We have a hypothesis that weather conditions affect accident frequency 
and severity. This feels a bit obvious of course, so we wanted to put a spin 
on it. First, in general, what weather conditions are most associated with 
accidents? What conditions are associated with more severe accidents? And ultimately
can we predict accidents and their severity using weather forecasts (i.e. 
can a predictive model identify the number of accidents across severities given
weather conditions). 

Our primary hypothesis is that severe weather events such as thunderstorms and rain 
together will be associated with more accidents and/or more severity of the accidents.
This may end up being only partially true, especially if people drive more
carefully in severe weather events and/or if we people avoid driving in them. 

Second just for fun, we'd like to explore the idea that a particular state has 
the "worst" drivers.

###### How we would know we're right 

Experiment Statement: Periods of severe weather will lead to an increased number 
of severe accidents; 

The dataset is quite large (3.5M rows) so for simplicity we took a simple random 
sample of 200,000 rows. We *did not* stratify or cluster our sample based on 
population of any geographic area (e.g. county or state) nor stratify or cluster
our sample based on the proportional frequency of a geographic area in the 
full dataset. We treat the population as the 3.5M and the 200,000 rows as a
sample for estimating all of our statistics. We would know we're correct if in
similar time periods in similar places with different weather conditions had 
both more accidents and more severe ones associated with the different weather 
conditions. We would then model this behavior and predict accident frequency
and severity in the population (3.5M Accidents). 

##### Narrative Logic 

Assume: 
* Driving frequency in static conditions has normal predictable seasonality.
    + That is, for the same location with the same weather, July 2015 and July 2019 should have similar driving patterns all else equal. 
* Data collection is not itself impacted by weather conditions or changes over the study period. Or more plainly, the accidents have minimal exogenous bias. 
    + i.e., a thunderstorm didn't take out the power and accidents occured without being tracked. 
    
For a specific location, differences in accident counts and severities will 
be impacted by weather conditions. 


##### Predicting Accident Severity 

Taking the February 2016 - January 2019 data from our sample, can we 
predict accidents in each month from February 2019 - January 2020.  


##### Worst Drivers 


# Results 

##### Post-Hoc - Representativeness of our Sample 

##### Conclusion 