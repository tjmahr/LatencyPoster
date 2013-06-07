## Introduction and Rationale

* The 2AFC looking-while-listening paradigm [LWL; @FernaldLWL] has become widely used to examine lexical processing in young children.
* The speed at which children look to familiar objects when hearing the object-name at 18 months reliably predicts vocabulary size up to 8 years of age [@MarchmanLangOutcomes].  
    - However, these reaction time measures are not easily obtained.
    - Reaction time provides a measure of how quickly a child looks to a picture when its object name is presented.  Therefore, reaction time can be measured only on trials where the child is _not_ looking at the target picture at the onset of the target word.
    - In a 2AFC paradigm, only about 50% of trials provide reaction time data. 
    - Usually, even fewer trials provide reaction time data because there are always some trials where young children are not fixating on a picture at target word onset.
    - This is a considerable problem, given the small number of trials in LWL studies (usually between 24 and 36).
* Adults can be instructed to fixate on a central orienting stimuli, but young children cannot be similarly instructed.
* This study used an animated centering stimulus in an attempt to increase the number of LWL trials with useable reaction times.

## METHOD

### Conditions

Condition 1: No animated centering stimulus.

Condition 2: Animated centering stimulus.

* Centering stimulus was an abstract geometric animation. It appeared onscreen after two images had been presented for 2000\ ms. (__Describe and maybe show example__)
* The animation looped until the child had fixated on it for 300\ ms or until 8000\ ms had elapsed. Then the carrier phrase was played, at target-word onset, the centering stimulus disappeared.
* Because carrier phrase and target-word presentation were triggered by fixation to the animation, these trials incorporated _gaze-contingency_ into the LWL paradigm.




### Participants

* N\ =\ 25 (12 female, 13 male) in condition 1 and N\ =\ 25 (11 female, 14 male) in condition 2.
* Participants in the two groups closely matched on the basis of age, sex, and PPVT-4 standard score.


**&nbsp;**   **Age (months)**   **EVT-2 standard score**   **PPVT-4 standard score**  
------------ ------------------ -------------------------- ---------------------------
CS1          39.44 (30--46)     129.8 (111--149)           90.2 (50--128)             
CS2          40.52 (31--48)     122.5 (92--146)            77.04 (45--118)            
------------ ------------------ -------------------------- ---------------------------


### Methodology

* Looking-while-listening mispronunciation paradigm [@SwingleyMP; @WhiteSubsegmental]
* Experiment designed in E-Prime Professional 2.0, used to interface with Tobii T60 XL Eye-tracker.
* Eye-tracking task presented to children as “watching a movie.”
* Images presented onscreen: one familiar and one unfamiliar object.
* Position counterbalanced (left-right).
* Images normed for familiarity and unfamiliarity.

#### Three conditions

1. CP: Correct pronunciation of real words
2. MP: Mispronunciations of these real words, with a one-feature change of initial consonant
3. NW: Nonwords trials presented with familiar objects not used in CP trials

* Target words all CVC in the carrier phrases “See the \_\_\_\_!” or “Find the \_\_\_\_!”
* (6\ CP\ +\ 6\ MP\ +\ 6\ NW)\ *\ 2 repetitions\ +\ 2 other real-word familiarization trials\ =\ 38 trials
* 2 blocks of 38 trials, eye-tracker calibrated before each block.
* Brief animation played every 6--7 trials to keep child engaged in task. 

![](mp_display.png)


### Calculation of Latency (reaction time)

* Latency is the amount of time between target-word onset and the first look to target.
* Latency calculated for CP and NW trials only. 
* On each trial, reaction time was calculated only if:
    
    1. the child looked onscreen within the 50\ ms after target-word onset
    2. the child was not already looking at familiar object (CP trials) or at unfamiliar object (NW trials) during within 50\ ms after target-word onset.
    
* Latency\ =\ Time of first look to target\ –\ time of first tracked look during target-word onset (0 to 50\ ms)
* Reaction time trimming: We excluded latencies that were less than 250\ ms or greater than 2SD above the group mean.

### Research Questions

* Does the use of an animated centering stimulus result in more useable latencies?
    - That is, are there more trials with useable latencies in condition 2 as compared to condition 1?
* Does this animated centering stimulus create additional task demands? 
    - Do children take longer to look to the target in condition 2 relative to condition 1?
    - Does the relationship between reaction time and vocabulary size reported in the literature continue to be observed when an animated centering stimulus is used?


## RESULTS

* As expected, children looked to familiar object in CP trials and to unfamiliar object in NW trials.

### Latency Results




* Condition 1:
    - CP trials: Latencies available in 32.7% of trials (additional 4.8% trimmed)
    - NW trials: Latencies available in 30.5% of trials (additional 5.8% trimmed)
* Condition 2:
    - CP trials: Latencies available in 63.9% of trials (additional 8% trimmed)
    - NW trials: Latencies available in 61.3% of trials (additional 8.5% trimmed)
* Mean latencies are very similar across the two conditions and the two trial types.
* Distributions of latencies differs across the two conditions, with condition 2 (with the centering stimuli) having a more peaky and positively skewed distribution.





![Figure 2. Histograms of latencies (ms) for condition 1 (top) and condition 2 (bottom) for CP trials (left) and NW trials (right).](figure/unnamed-chunk-5.png) 










### Regression analyses

* Do age, expressive vocabulary size or trial type predict latency in either conditions?
* We ran two separate multiple regression analyses, one for each condition. The dependent variable was the mean latencies for each subject for each trial type (CP or NW).
* Independent variables were age, trial type (CP or NW), and EVT-2 raw score (expressive vocabulary size).
* The regression results were also checked against a mixed effects model that used by-subject random intercepts and random slopes for trial type rather than aggregating latencies into subject means.







![Figure 2. Relationship between EVT-2 and mean latencies for each subject by condition and trial](figure/unnamed-chunk-10.png) 



#### Regression Results:  Condition 1

* Age, trial type, and EVT-2 were significant predictors of latency, _R_^2\ =\ 0.285, _F_(3, 46)\ =\ 6.11, _p_\ =\ 0.001.


              **Estimate**   **Std. Error**   **t value**   **Pr(>|t|)**  
------------- -------------- ---------------- ------------- --------------
(Intercept)   423.97         171.89           2.47          0.02          
EVT           -6.65          2.15             -3.10         0.00          
Age           18.70          5.41             3.46          0.00          
ConditionNW   -89.78         40.88            -2.20         0.03          
------------- -------------- ---------------- ------------- --------------







#### Regression Results: Condition 2
* None of the independent variables were significant predictors of latency, _R_^2\ =\ 0.096, _F_(3, 46)\ =\ 1.62, _p_\ =\ 0.197.



              **Estimate**   **Std. Error**   **t value**   **Pr(>|t|)**  
------------- -------------- ---------------- ------------- --------------
(Intercept)   979.01         129.30           7.57          0.00          
EVT           -1.39          1.24             -1.12         0.27          
Age           -3.79          3.66             -1.04         0.31          
ConditionNW   -9.11          30.29            -0.30         0.76          
------------- -------------- ---------------- ------------- --------------


## Discussion





* These results suggest that using an animated centering stimulus will yield more useable latency data.
    - About 54.35% of trials had useable latencies when an animated centering stimulus was used, compared to r percents$CS1`% when it was not used.
* The fact that reaction times were not significantly different across the two conditions suggests that the animated centering stimulus does not create additional task demands.
* As in previous research, vocabulary size was a significant predictor of latency in condition 1 without the animated centering stimulus
* However, neither vocabulary size nor age was a significant predictor of latency when an animated centering stimulus was used.
* This result suggests that the effect of age and vocabulary size on latency may be due, at least in part, to older children and children with larger vocabularies having better attention to task. When an animated centering stimulus is used to maintain attention, the effect of age and vocabulary size on latency is no longer observed.
* To conclude, the use of an animated centering stimulus does not create additional task demands. Instead, it results in more useable latency data and better attention to task.


### Acknowledgements

Thanks to Franzo Law II, Alissa Schneeberg, Danielle Lee, David Kaplan, Morgan Meredith, Erica Richmond, Nancy Wermuth, and other members of the Learning To Talk Laboratory for help with many aspects of this study. We also thank the children who participated and their parents.

This research was supported by NIDCD Grant R01-02932 to Jan Edwards, Mary Beckman, and Benjamin Munson and NICHD Grant P30-HD03352 to the Waisman Center.

#### Reproducible Research!

Data-set and supporting `R` scripts available on `github.com/tjmahr/LatencyPoster`

![](qrcode_small.png)

### References
